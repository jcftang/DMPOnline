class Mapping < ActiveRecord::Base
  belongs_to :question
  belongs_to :dcc_question, :class_name => "Question", :foreign_key => "dcc_question_id"
  has_one :guide, :as => :guidance, :dependent => :delete
  has_many :boilerplate_texts, :as => :boilerplate, :dependent => :delete_all

  accepts_nested_attributes_for :guide, :allow_destroy => true
  accepts_nested_attributes_for :boilerplate_texts, :allow_destroy => true
  attr_accessible :question_id, :dcc_question_id, :guide_attributes, :boilerplate_texts_attributes

end
