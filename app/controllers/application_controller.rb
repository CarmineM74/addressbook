class ApplicationController < ActionController::Base
  protect_from_forgery
  layout nil

  before_filter :intercept_html_requests

private
  def intercept_html_requests
    render('layouts/dynamic') if request.format == Mime::HTML
  end

end
