class Currency < ActiveRecord::Base
  has_many :plans
  
  attr_accessible :name, :symbol, :iso_code

end
