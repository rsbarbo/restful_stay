class PermissionService
  extend Forwardable

  def_delegators :user, :traveler?, :host?, :admin?

  def initialize(user:, controller:, action:)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    if admin?
      admin_permissions
    elsif host?
      host_permissions
    elsif traveler?
      traveler_permissions
    else
      guest_permissions
    end
  end

  private
    attr_reader :user, :controller, :action

    def admin_permissions
      # return true if controller == 'users' && action.in?(%w(index show))
      return host_permissions
    end

    def host_permissions
      # return true if controller == 'orders' && action.in?(%w(index show))
      return true if controller == 'listings' && action.in?(%w(index new create show))
      return traveler_permissions
    end

    def traveler_permissions
      # return true if controller == 'items' && action.in?(%w(index show))
      return true if controller == 'dashboard' && action.in?(%w(index))
      return true if controller == 'userroles' && action.in?(%w(create))
      return guest_permissions
    end

    def guest_permissions
      # return true if controller == 'stores' && action.in?(%w(index show))
      # return true if controller == 'sessions' && action.in?(%w(new create destroy))
      return true if controller == 'home'
      return true if controller == 'about'
      return true if controller == 'sessions' && action.in?(%w(new create destroy))
      return true if controller == 'users' && action.in?(%w(new create))
      return true if controller == 'confirmation' && action.in?(%w(new create))
    end

end
