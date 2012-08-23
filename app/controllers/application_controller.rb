class ApplicationController < ActionController::Base
  protect_from_forgery
  layout nil

  before_filter :intercept_html_requests

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authentication_required
    respond_with({error: 'authentication required'}, :status => 401, :location => nil) if @current_user.nil?
  end

  def intercept_html_requests
    render('layouts/dynamic') if request.format == Mime::HTML
  end

end
