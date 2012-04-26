class Guide < ActiveRecord::Base
  belongs_to :question
  belongs_to :edition
  
  attr_accessible :guidance

end
