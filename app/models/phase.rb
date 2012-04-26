class Phase < ActiveRecord::Base
  belongs_to :template
  has_many :editions, :dependent => :delete_all

  attr_accessible :phase, :position
  validates :phase, :presence => true
  
  acts_as_list :scope => :template_id
  
  after_create do |phase|
    edition = phase.editions.build
    edition.save!
  end
  
  attr_accessor :delete_phase
  after_commit do |phase|
    if phase.delete_phase
      phase.delete!
    end
  end
      
end
