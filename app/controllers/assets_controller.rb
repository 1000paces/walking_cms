class AssetsController < ApplicationController
  before_action :set_user, except: [:show]
  before_filter :require_user, only: [:show]


end