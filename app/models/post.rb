class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  belongs_to :organisation

  validates :title, :body, :organisation_id, :presence => true
  
  attr_accessible :title, :body, :organisation_id, :locale
  attr_readonly :organisation_id

  POSTS_IN_BLOCK = 3
  
  def self.for_org(organisation)
    where(:locale => I18n.locale, :organisation_id => organisation)
    .order('created_at desc')
  end
  
  def self.find_for_block(organisation)
    where(:locale => I18n.locale, :organisation_id => organisation)
    .order('created_at desc')
    .limit(POSTS_IN_BLOCK)
  end

end
