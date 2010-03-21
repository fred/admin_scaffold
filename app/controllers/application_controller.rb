# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  helper_method :current_user_session, :current_user

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
  
  before_filter :get_locale, :store_location
  
  before_filter :set_iphone_format
  
  def is_iphone_request?
    request.user_agent.downcase =~ /(mobile\/.+safari)|(iphone)|(ipod)|(blackberry)|(symbian)|(series60)|(android)|(smartphone)|(wap)|(mobile)/
  end

  def set_iphone_format
    if params[:desktop]
      session[:mobile] = nil
    end
    if is_iphone_request? or params[:mobile] or session[:mobile]
      session[:desktop] = nil
      session[:mobile] = true
      request.format = :iphone
    end
  end
    
  def initialize
    @start_time = Time.now.usec
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def authorized?
    logged_in? && current_user.admin?
  end
  
  def authorized_only
    redirect_to new_user_session_path unless authorized?
  end
  
  
  
  ##################
  # LOCALE METHODS #
  ##################
  
  def default_language
    "en"
  end
  
  def get_locale_from_profile
    if current_user && current_user.default_language
      case current_user.default_language
      when "Portugues"
        session[:language] = "pt-BR"
      when "English"
        session[:language] = "en"
      else
        session[:language] = "pt-BR"
      end
      logger.debug "* Lang from user profile : #{current_user.default_language}"
    end
  end
  
  # retrieve the language from the session store, 
  # otherwise set to default of pt-BR
  def get_locale_from_session
    if (session && session[:language])
      lang = session[:language]
    else
      lang = default_language
    end
    lang
  end
  
  # overwrite session language if params[:language] is given and fixate it
  # params[:session] only accepts 'en' or 'th' (English or Thai)
  # otherwise get from user profile
  def get_locale
    if (params[:language] && params[:language].to_s.match(/en|pt-BR/))
      logger.debug "* Lang from headers : #{extract_locale_from_accept_language_header}"
      logger.debug "* session[:language] was: '#{session[:language]}'"
      session[:language] = params[:language]
    elsif RAILS_ENV == "test"
      session[:language] = "en"
    else
      session[:language] = get_locale_from_session
    end
    set_locale
  end
  
  def set_locale
    if session[:language]
      set_locale_to(session[:language])
    else
      lang = extract_locale_from_accept_language_header
      set_locale_to(default_language)
    end
  end
  
  def set_locale_to(lang)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = lang
    logger.debug "* Locale set to '#{I18n.locale}'"
    logger.debug "* session[:language] is '#{session[:language]}'"
  end
  
  
  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      if params[:return_to]
        session[:return_to] = params[:return_to]
      else
        session[:return_to] = request.request_uri
      end
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end



    def extract_locale_from_accept_language_header
      # if request.env['HTTP_ACCEPT_LANGUAGE'] && !request.env['HTTP_ACCEPT_LANGUAGE'].empty?
      #   lang = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      #   lang = "th" if lang.empty?
      # end
      # Should work for all browsers
      lang = "pt-BR"
      return lang
    end
end
