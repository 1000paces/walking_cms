class Admin::AdminController < ApplicationController
  before_action :set_user#, except: [:show]
  before_filter :require_user#, only: [:show]
  before_filter :set_view_path

end