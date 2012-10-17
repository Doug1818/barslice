class UserSessionsController < Devise::SessionsController
  
  def new
    super
    session[:return_to] = request.referrer
  end

  def create
    super
  end

  def destroy
    super
  end
end