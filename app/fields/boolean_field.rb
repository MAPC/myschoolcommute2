require "administrate/field/base"

class BooleanField < Administrate::Field::Base
  def to_s
    I18n.t(data)
  end
end
