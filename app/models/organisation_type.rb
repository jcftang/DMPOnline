class OrganisationType < ActiveRecord::Base
  has_many :organisations, :order => "name"

  attr_accessible :title, :description

end
