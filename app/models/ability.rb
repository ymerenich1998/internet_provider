class Ability
  include CanCan::Ability

  def initialize(employee)
    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    can :read, Consumer
    can :read, Complaint
    can :read, Solved
    can :read, ChangeTariffRequest
    can :read, Payment

    if employee.system_admin?
      can :read, Employee
      can :manage, Employee, id: employee.id
      can :read, Tariff
    end

    if employee.admin?
      can :manage, Employee
      can :manage, Tariff
      can :manage, Payment
    end

    if employee.admin? || employee.system_admin?
      can :manage, Complaint
      can :manage, Consumer
      can :manage, Solved
      can :manage, ChangeTariffRequest
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
