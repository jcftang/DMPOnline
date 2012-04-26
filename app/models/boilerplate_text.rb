class BoilerplateText < ActiveRecord::Base
  has_paper_trail

  attr_accessible :content

end
