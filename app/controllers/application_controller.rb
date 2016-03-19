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


	def require_user
		
		if current_user && !current_user.nil?
			
		else
			store_location
			flash[:notice] = "You must be logged in to access this page"
			redirect_to login_path
			return false
		end
	end

	def require_no_user
		if current_user
			store_location
			#reset_session
			#flash[:notice] = "You must be logged out to access this page"
			redirect_to user_session_path
			return false
		end
	end

  private

  def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
  end

  def current_user
  	#@current_user ||= curent_user_session && curent_user_session.user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record  	
  end

	def store_location
		#Rails.logger.warn("=> ApplicationController::store_location")
		#Rails.cache.write("ReturnTo.#{request.subdomains.join('-')}", request.url)
		session[:return_to] = request.url
	end

	def redirect_back_or_default(default)
		redirect_to(session[:return_to] || default)
		session[:return_to] = nil
	end

	def set_user
		@user = current_user
	end

  def set_view_path
  	if !@user.nil?
    	prepend_view_path "#{Rails.root}/app/views/#{@user.setting.framework}"
    elsif !@owner.nil?
			prepend_view_path "#{Rails.root}/app/views/#{@owner.setting.framework}"
    end
  end
end
