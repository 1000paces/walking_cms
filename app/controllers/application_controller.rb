=begin
Handy Commands
Rails Console:
bundle exec rails console

Mysql DB:
bundle exec rails db
=end


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
