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

This project uses the [reCAPTCHA gem](https://github.com/ambethia/recaptcha) for bot filtering. To set this up in your development environment, go to the [reCAPTCHA admin console](https://www.google.com/recaptcha/admin/create) and select "reCAPTCHA v2" and "Invisible reCAPTCHA badge" for the reCAPTCHA type. Set the domain to **localhost**. Upon creation, you'll be given a site key and a secret key. Add these values to your `.env` file under `RECAPTCHA_SITE_KEY` and `RECAPTCHA_SECRET_KEY`, respectively.

Make sure to install the libgeos dev package on your deployment server so that the RGeo gem native extensions work.

`sudo apt-get install libgeos-dev`

Mac users will also need to install the geos library locally to do development.
`brew install geos`. If you hit a `Cannot load such file -- rgeo/geos/geos_c_impl` error on a Mac, patch the proj bundle following [these instructions](https://github.com/rgeo/rgeo-proj4/issues/4#issuecomment-536193184).

## Deployment
This project is setup to deploy with capistrano to MAPC servers. Run `cap staging deploy` or `cap production deploy` to deploy the develop branch to staging or master branch to production after pushing your changes to Github. 

## Data Migration
The data migration process to generate a new seed file from the old site is documented [in this commit](https://github.com/MAPC/myschoolcommute2/commit/1fe57646446be2779203b97c5347c3f9dc5e6af4).

## WARNING
`bin/setup` runs a seed task that creates an admin user with the following credentials: 
User: `admin@user.org`
Password: `password`

This should be deleted before moved to production!

# Submodules
Some of the view logic was complicated enough to warrant a front-end framework. There are two, both using React:
1. Public survey form: https://github.com/MAPC/intersecting-streets-react
2. Map for viewing a school and its walksheds: https://github.com/MAPC/school-map

To push changes from these submodules into this repository, follow these steps:
1. Setup the submodule; it must be a sibling directory with this repository:
  /repositories
     /myschoolcommute2
     /intersecting-streets-react
     /school-map
2. From within the submodule directory, run `npm build`. This will build the script and load it into the correct place in the Rails app.
