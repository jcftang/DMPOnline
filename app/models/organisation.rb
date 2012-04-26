class Organisation < ActiveRecord::Base
  belongs_to :organisation_type
  belongs_to :dcc_edition, :class_name => "Edition", :foreign_key => "dcc_edition_id"
  has_many :documents
  has_many :pages
  has_many :roles
  has_many :templates
  has_one :dcc_template, :foreign_key => "dcc_template_id", :class_name => "Template"
  
  has_attached_file :logo, :styles => {home: '320x92>', template: '256x72>', thumb: '48x48>'}
  has_attached_file :stylesheet
  
  validates_format_of :domain, :with => /\A[a-z\.]{6,}\Z/
  
  attr_accessible :full_name, :domain, :url, :organisation_type_id, :default_locale, :dcc_edition_id, :short_name, :logo
  scope :dcc, where(:domain => 'dcc.ac.uk')
  
end
