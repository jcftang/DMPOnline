class TemplateInstance < ActiveRecord::Base
  belongs_to :template
  belongs_to :plan
  belongs_to :current_edition, :class_name => "Edition", :foreign_key => "current_edition_id"
  has_many :phase_edition_instances
  has_many :answers, :through => :phase_edition_instances, :conditions => "template_instances.current_edition_id = phase_edition_instances.edition_id"
  has_many :questions, :through => :answers
  has_many :template_instance_rights
  has_many :editions, :through => :phase_edition_instances
  has_many :phases, :through => :editions, :order => 'position ASC, id ASC'
  
  attr_accessible :current_edition_id, :template_id, :template_instance_rights_attributes
  attr_readonly :template_id
  accepts_nested_attributes_for :template_instance_rights, :reject_if => :all_blank, :allow_destroy => true
  
  before_validation :check_current_edition
  validates_uniqueness_of :template_id, :scope => :plan_id  
  validates :current_edition_id, :presence => true
  after_create :create_phase_edition_instances

  # owner: per template instance, can update a plan's template instance and change user access rights (not currently in use)
  # read: per template instance, can view and export a plan's template instance
  # write: per plan, can update a plan's template instance
  ROLES = %w[none owner read write]

  def self.for_user(user)
    # Check all template instances for access rights for provided user
    user ||= User.new
    joins(:plan).includes(:template_instance_rights).where("plans.user_id = ? OR ? LIKE email_mask", user.id, user.email)
  end

  def current_phase
    self.current_edition.phase
  end

  protected
  
  def check_current_edition
    if current_edition_id.nil?
      unless template_id.nil?
        self.current_edition_id = Edition.initial_for_template(template_id).id
      end
    end
  end
  
  def create_phase_edition_instances
    Edition.phases_current(self.template_id).each do |v|
      self.phase_edition_instances.create!(:edition_id => v.id)
    end
  end
  
end
