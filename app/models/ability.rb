class Ability
  # All frontend users are authorized using this class
  include CanCan::Ability

  def initialize(user, organisation, dcc)
    user ||= User.new # guest user (not logged in)

    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # Anonymous users can view pages, news articles and documents but that's all
    can :read, Document
    can :read, Page
    
    unless user.new_record?   
      if user.is_sysadmin?
        can :manage, :all
      end

      # Anyone can create a plan (if logged in)
      can :create, Plan
      # Plan author can do anything to a plan
      can :manage, Plan, :user_id => user.id
      can :manage, PhaseEditionInstance, :plan_owner => user.id 

      # Read/write access granted through email address wildcarding
      can [:read, :ajax_section, :duplicate, :output, :export], Plan, :id => TemplateInstanceRight.matching(user.email).with_role('read').map(&:plan_id)
      can [:read, :update, :complete, :ajax_section, :change_phase, :duplicate, :output, :export], Plan, :id => TemplateInstanceRight.matching(user.email).with_role('write').map(&:plan_id)
      can [:read, :output, :output_all, :export], PhaseEditionInstance, :template_instance_id => TemplateInstanceRight.matching(user.email).with_role('read').map(&:template_instance_id)
      can [:read, :update, :output, :output_all, :export, :add_answer, :checklist], PhaseEditionInstance, :template_instance_id => TemplateInstanceRight.matching(user.email).with_role('write').map(&:template_instance_id)

      can [:rights], Plan, :id => TemplateInstanceRight.matching(user.email).with_role('read').map(&:plan_id)
      can [:rights], Plan, :id => TemplateInstanceRight.matching(user.email).with_role('write').map(&:plan_id)
    end

    cannot [:update, :complete, :change_phase], Plan, :locked => true
    cannot [:update, :add_answer, :checklist], PhaseEditionInstance, :locked => true
  end
end
