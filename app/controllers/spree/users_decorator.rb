module Spree::UsersDecorator
  def self.prepended(base)
    base.skip_before_action :verify_authenticity_token, only: [:session_location], raise: false
  end

  def session_location
    session[:coords] = params["coords"]
  end
end

Spree::UsersController.prepend(Spree::UsersDecorator)