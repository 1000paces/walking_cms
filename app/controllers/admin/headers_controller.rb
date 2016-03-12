class Admin::HeadersController < ApplicationController
  before_action :set_user
  before_filter :require_user

  def show
  	@page = Page.find params[:id]
  end
end