class Admin::HeadersController < ApplicationController
  before_action :set_user
  before_filter :require_user


end