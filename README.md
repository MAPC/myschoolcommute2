# README

MySchoolCommute is a statewide platform for surveying and tracking longitudinal and spatial information about transportation modes and behavior from and to school. This platform runs surveys and analyses data collected for surveys.  

## Dependencies
This project requires Postgres, postgis, and pgrouting. See http://www.kyngchaos.com/software/postgres. The setup process will fail without these dependencies.

## PGRouting For Mac
PGRouting is needed for the School walkshed re-generation. This is a less critical feature, so it'd be acceptable to comment out the pgrouting extension in the migration. 
`brew install pgrouting`

## Setup
This project uses Git LFS to manage large seed files. Make sure you download those files before doing anything else.
Run `bin/setup` in your terminal.

Obtain a Sentry Client Key DSN from [Sentry](https://sentry.io/settings/metropolitan-area-planning-cou/my-school-commute-2/keys/) and set `SENTRY_DSN` in your `.env` to that value.

This project uses the [reCAPTCHA gem](https://github.com/ambethia/recaptcha) for bot filtering. To set this up in your development environment, go to the [reCAPTCHA admin console](https://www.google.com/recaptcha/admin/create) and select "reCAPTCHA v2" and "Invisible reCAPTCHA badge" for the reCAPTCHA type. Set the domain to **localhost** and/or **127.0.0.1**, whichever you prefer for local development. Upon creation, you'll be given a site key and a secret key. Add these values to your `.env` file under `RECAPTCHA_SITE_KEY` and `RECAPTCHA_SECRET_KEY`, respectively.

Make sure to install the libgeos dev package on your deployment server so that the RGeo gem native extensions work.

`sudo apt-get install libgeos-dev`

Mac users will also need to install the geos library locally to do development:
`brew install geos`. If you hit a `Cannot load such file -- rgeo/geos/geos_c_impl` error on a Mac, patch the proj bundle following [these instructions](https://github.com/rgeo/rgeo-proj4/issues/4#issuecomment-536193184).

Install all dependencies from [Dockerfile.app](https://github.com/MAPC/myschoolcommute2/blob/master/Dockerfile.app); this includes installing [R](https://www.r-project.org/) and a LaTeX compiler/editor like [MacTeX](https://tug.org/mactex/) for your development environment. If your previously-installed instance of R is earlier than 3.6.1, you can find updating instructions [in the CRAN documentation](https://cran.r-project.org/bin/linux/ubuntu/README.html)).

Run the following script to finalize your R and LaTeX setup:

```
sudo apt-get -y install xzdec texlive-science texlive-latex-base texlive-latex-recommended texlive-pictures texlive-latex-extra
tlmgr init-usertree
tlmgr install caption adjustbox colectbox ucs floatrow siunitx lipsum
```

Make sure that `database.yml` contains specifies a username, password, host, port, and database name. Specifically, make sure to add your `USER` and `POSTGRES_PASSWORD` values to a `.env`. If omitted, you will not be able to run the R script that generated PDF reports. Additionally, the final page of the report relies on the output of a build of school-map; to ensure that the walkshed map is visible, run `npm run build` on `lib/external/school-map/src`.

## Running locally
This is a Rails project with some React components rendered with the [Webpacker gem](https://github.com/rails/webpacker). To run, execute `bundle exec rails s` and `bin/webpack-dev-server` in two separate command prompts.

## Deployment
This project is setup to deploy with capistrano to MAPC servers. Run `cap staging deploy` or `cap production deploy` to deploy the develop branch to staging or master branch to production after pushing your changes to Github.

## Data Migration
The data migration process to generate a new seed file from the old site is documented [in this commit](https://github.com/MAPC/myschoolcommute2/commit/1fe57646446be2779203b97c5347c3f9dc5e6af4).

## Fetch Enrollment Data for annual update from 
https://www.doe.mass.edu/infoservices/reports/enroll/default.html

Postgres `CREATE` statements can be regenerated though [csvkit](https://csvkit.readthedocs.io/en/latest/)
```
csvsql --db postgresql:///myschoolcommute2 --insert enrollment19_20.csv
```
Run the `CREATE` statement in the myschoolcommute2 database.
Use the import/export command to import the data in the csv.

You may have to run and `UPDATE` (and possibly create) on potentially 2 fields `ORG_CODE` and `SCHOOL` both char fields.

Basis for command is

```
UPDATE enrollment20_21
SET ORG_CODE = LPAD(schid, 8 '0'),
SCHOOL = CONCAT(name, ' - ', district, ' (District)')
```

## Correct Issues with Distance Value 
When you have a case where you have null distances, run the following command
```rake database:correct_distances RAILS_ENV=production```

## WARNING
`bin/setup` runs a seed task that creates an admin user with the following credentials: 
User: `admin@user.org`
Password: `password`

This should be deleted before moved to production!

These two queries were requested by Diane at end of year. They can be run in commandline psql to generate csv files locally. Dates and output file location will need to be updated accordingly

```
\copy (select id, ST_AsText (ST_Transform (geometry, 4326)) as geometry,question,mode,shed,distance,survey_id,grade_0,to_school_0,dropoff_0,from_school_0,pickup_0,grade_1,to_school_1,dropoff_1,from_school_1,pickup_1,grade_2,to_school_2,dropoff_2,from_school_2,pickup_2,grade_3,to_school_3,dropoff_3,from_school_3,pickup_3,grade_4,to_school_4,dropoff_4,from_school_4,pickup_4,grade_5,to_school_5,dropoff_5,from_school_5,pickup_5,grade_6,to_school_6,dropoff_6,from_school_6,pickup_6,grade_7,to_school_7,dropoff_7,from_school_7,pickup_7,grade_8,to_school_8,dropoff_8,from_school_8,pickup_8,grade_9,to_school_9,dropoff_9,from_school_9,pickup_9,grade_10,to_school_10,dropoff_10,from_school_10,pickup_10,grade_11,to_school_11,dropoff_11,from_school_11,pickup_11,grade_12,to_school_12,dropoff_12,from_school_12,pickup_12,grade_13,to_school_13,dropoff_13,from_school_13,pickup_13,grade_14,to_school_14,dropoff_14,from_school_14,pickup_14,grade_15,to_school_15,dropoff_15,from_school_15,pickup_15,grade_16,to_school_16,dropoff_16,from_school_16,pickup_16,grade_17,to_school_17,dropoff_17,from_school_17,pickup_17,grade_18,to_school_18,dropoff_18,from_school_18,pickup_18,grade_19,to_school_19,dropoff_19,from_school_19,pickup_19,nr_vehicles,nr_licenses,created_at,updated_at,is_bulk_entry from survey_responses where survey_id in (SELECT id FROM public.surveys
where begin between '07-01-2021' AND '06-30-2022')) TO '/Users/tcomer/Projects/2021-2022 MSC All Reponses Export.csv' DELIMITER ','
CSV HEADER;  
```
```
\copy (select * from _view_full_survey_summary 
where _view_full_survey_summary."Survey ID" 
in (SELECT id FROM public.surveys
where begin between '07-01-2021' AND '06-30-2022')) TO '/Users/tcomer/Projects/2021-2022 MSC Survey ID report.csv' DELIMITER ','
CSV HEADER;
```