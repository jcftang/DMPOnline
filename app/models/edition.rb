class Edition < ActiveRecord::Base
  belongs_to :phase
  belongs_to :dcc_edition, :class_name => "Edition", :foreign_key => "dcc_edition_id"
  has_many :phase_edition_instances
  has_many :questions
  has_many :template_instances, :through => :phase_edition_instances
  has_many :answers, :through => :phase_edition_instances

  attr_accessible :edition, :dcc_edition_id

  STATUS = %w[unpublished published active old]
  
  validates :edition, :phase_id, :status, :presence => true
  before_destroy :not_in_use? 


  # NB done as class method instead of using scope since Arel will break db migrations for co-developers/third party installs
  def self.published
    where(:status => STATUS.index('published')).order('id desc').first
  end

  def state=(state)
    self.status = STATUS.index(state.to_s)
  end
  
  def state
    STATUS[self.status].to_sym
  end
  
  def publish
    Edition
      .where(:phase_id => self.phase_id, :status => STATUS.index('published'))
      .update_all(:status => STATUS.index('old'))
    self.state= :published
    self.save!
    self.active_check
  end
  
  def unpublish
    self.state= :unpublished
    self.save!
    self.active_check
  end

  def active_check
    Edition
      .joins('LEFT OUTER JOIN phase_edition_instances ON editions.id = phase_edition_instances.edition_id')
      .where(:status => STATUS.index('active'), :phase_edition_instances => {:edition_id => nil})
      .update_all(:status => STATUS.index('old'))
    Edition
      .joins(:phase_edition_instances)
      .where('status NOT IN (?, ?)', STATUS.index('active'), STATUS.index('published'))
      .update_all(:status => STATUS.index('active'))
  end

  def sorted_sections
    self.questions.where(:parent_id => nil).nested_set
  end

  def section_questions(qid)
    self.questions.where('parent_id IS NULL OR parent_id = ?', qid).nested_set
  end
  
  def sorted_questions
    self.questions.nested_set
  end

  def self.initial_for_template(template_id)
    joins(:phase)
    .where('phases.template_id' => template_id, 'editions.status' => STATUS.index('published'))
    .order('phases.position asc, editions.id desc')
    .first
  end

  def self.dcc_checklist_editions
    joins(:phase => {:template => :organisation})
    .select('editions.*, phases.phase, templates.name, organisations.short_name')
    .where(:templates => {:checklist => true})  #.where('status IN (?, ?)', STATUS.index('active'), STATUS.index('published'))
    .order('id desc')
    .all
  end
  
  def self.dcc_checklist_current_edition
    joins(:phase => {:template => :organisation})
    .select('editions.*, phases.phase, templates.name, organisations.short_name')
    .where(:templates => {:checklist => true})
    .where(:status => STATUS.index('published'))
    .order('id desc')
    .first
  end  

  def self.phases_current(tid)
    joins(:phase)
    .where(:phases => {:template_id => tid})
    .where(:status => STATUS.index('published'))
    .all
  end

  def self.report_questions
    includes(:questions => :dcc_questions)
    .all
  end

  private
 
  def not_in_use?
    if self.status != STATUS.index('unpublished')
      errors.add :base, I18n.t('dmp.admin.not_unpublished') 
    end
    errors.blank?
  end

end

