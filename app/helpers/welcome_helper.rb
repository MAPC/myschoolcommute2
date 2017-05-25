module WelcomeHelper
  def nest_for_menus(districts)    
    active_districts = 
      districts.map { |dist| 
        { name: dist.distname, value: dist.id } 
      }

    nested_active_schools = Hash.new
    active_districts.each { |dist|
      active_schools = 
        School.active.where(district_id: dist[:value])

      nested_active_schools["#{dist[:name]}"] = 
        active_schools.map { |school| { value: school.active_surveys.first.id, name: school.name } } 
    }

    { districts: active_districts, schools: nested_active_schools  }.to_json.html_safe
  end
end
