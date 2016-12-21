class Admin::AdminController < ApplicationController
  before_action :set_user#, except: [:show]
  before_action :require_user#, only: [:show]
  before_action :set_view_path

end