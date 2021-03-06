class Admin::UsersController < Admin::AdminController

  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_action :require_user, only: [:show]
  skip_before_action :set_user, :except => :show
  skip_before_action :require_user, :only => [:new, :create]


  # GET /users
  # GET /users.json
  def index
   # @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @page = @user.home_page
    #@row = @page.rows.create unless @page.nil?
    if @page.rows.empty?
      @row = @page.rows.create 
      @cell = @row.cells.create(:body => "")
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @setting = @user.create_setting
  end

  # GET /users/1/edit
  def edit
    set_user
    case params[:pane]

    when 'domain'

    when 'payment'

    else

    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_parameters)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_home_path }
        #format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        #format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    set_user
    respond_to do |format|
      if @user.update(user_parameters)
        format.js { render :update }
      else
        format.js { render :edit }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id]) unless params[:id].blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_parameters
      params.require(:user).permit(:first_name, :last_name, :login, :password, :password_confirmation)
    end
end
