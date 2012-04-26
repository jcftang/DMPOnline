class Page < ActiveRecord::Base
  belongs_to :organisation
  validates :position, :menu, :organisation_id, :presence => true

  attr_accessible :title, :body, :slug, :menu, :position, :target_url, :organisation_id, :locale 
  attr_readonly :organisation_id

  scope :menu, ->(menu) { where(:menu => MENU.index(menu)).order(:position) }
  
  MENU = %w[none help navigation]

  def self.for_org(organisation)
    where(:locale => I18n.locale, :organisation_id => organisation)
  end
  
end
