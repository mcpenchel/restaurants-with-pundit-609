class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    # This will not work!
    # def show
    # end
  end

  def show?
    true
  end

  def create?
    # Hyphotetical scenario where user has the role string attribute
    # and the available options for it are admin, business_owner, business_employee
    # ["admin", "business_owner"].include?(user.role)

    #############################
    ##### REAL DEAL #############
    #############################
    true
  end

  def new?
    create?
  end

  def update?
    # Hyphotetical Scenario
    # Remember =>>>> works_on? would be an User instance method that you would have
    # to create inside the model, and should return true or false depending on the
    # argument received (which would be the restaurant instance)
    # user.role == "admin" || (user.role == "business_employee" && user.works_on?(record))


    #############################
    ##### REAL DEAL #############
    #############################
    is_owner? # this was a refactor to DRY up the code
  end

  def edit?
    update?
  end

  def destroy?
    is_owner? # this was a refactor to DRY up the code
  end

  def is_owner?
    # user which is the current_user from devise
    # record which is the instance that we send in the authorize method in the controller
    record.user == user || user.admin? # read it as @restaurant.user == current_user || current_user.admin == true
  end

end
