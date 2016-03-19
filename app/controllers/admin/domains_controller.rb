class Admin::DomainsController < Admin::AdminController

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
    @domain = @user.domain
    if @domain.nil?
      redirect_to new_admin_domain_path
    end
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.create(domain_params)
    if @domain.errors.any?
      render(:template => "/shared/errors", :layout => false)
    end
    #respond_to do |format|
    #  if @domain.save
    #    format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
    #    format.json { render :show, status: :created, location: @domain }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @domain.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    @domain = @user.domain
    @domain.update(domain_params)
    if @domain.errors.any?
      render(:template => "/shared/errors", :layout => false)
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_domain
    #  @domain = Domain.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_params
      params.require(:domain).permit(:name, :label).merge(user_id: current_user.id)
    end
end
