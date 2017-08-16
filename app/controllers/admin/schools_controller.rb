module Admin
  class SchoolsController < Admin::ApplicationController
    # before_action :transform_geometry, only: [:create]

    # def transform_geometry
    #   if params[:school][:geometry].match(/-*\d{1,2}\.\d+,-*\d{0,2}\.\d+/)
    #     point = RGeo::Cartesian.factory(srid: 4326, proj4: '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs').point()
    #     ma_factory = RGeo::Cartesian.factory(srid: 26986, proj4: '+proj=lcc +lat_1=42.68333333333333 +lat_2=41.71666666666667 +lat_0=41 +lon_0=-71.5 +x_0=200000 +y_0=750000 +ellps=GRS80 +datum=NAD83 +units=m +no_defs')
    #     params[:school][:geometry] = RGeo::Feature.cast(point, factory: ma_factory, project: true).as_text
    #   end
    # end
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = School.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   School.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
