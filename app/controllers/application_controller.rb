class ApplicationController < ActionController::Base
  require 'open-uri'
  include Authentication
  include AppConstants
  include HashToObject
  include ApplicationHelper
  helper_method :include_controller_js?, :include_controller_css?,
                :admin?, :member?
  
  def exception_response(e)
    redirect_to root_url, :alert => e.Message
  end
  
  # def api_base_url
  #   "http://#{ENV['TRAINEAT_API_HOST_' + ENV['TRAINEAT_MODE']]}/api/v1/"
  # end

  def api_base_url
    "https://frozen-harbor-98767.herokuapp.com/api/v1/"
  end

  def api_request(url, params, method, is_auth_token, is_file=false)
    params[:is_setting_websites_required] = true if params.present?
    
    uri  = URI.parse(api_base_url + url)
    http = Net::HTTP.new(uri.host, uri.port)
    
    if uri.scheme.downcase == 'https'
      http.use_ssl = true
    end
    
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXx"
    puts api_base_url + url
    puts uri.inspect
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXx"
    
    json_headers = {
        "Content-Type" => "application/json",
        "Accept"       => "application/json"
    }
    
    if method == POST_REQUEST
      request      = Net::HTTP::Post.new(uri.request_uri, json_headers)
      request.body = params.to_json
      if is_auth_token
        signed_request = ApiAuth.sign!(request, current_profile[:auth_token], current_profile[:user][:id].to_s)
        @response      = http.request(signed_request)
      else
        @response = http.request(request)
      end
    elsif method == GET_REQUEST
      request = Net::HTTP::Get.new(uri.request_uri, json_headers)
      request.body = params.to_json
      if is_auth_token
        signed_request = ApiAuth.sign!(request, current_profile[:auth_token], current_profile[:user][:id].to_s)
        @response      = http.request(signed_request)
      else
        @response = http.request(request)
      end
    elsif method == PUT_REQUEST
      request      = Net::HTTP::Put.new(uri.request_uri, json_headers)
      request.body = params.to_json
      if is_auth_token
        signed_request = ApiAuth.sign!(request, current_profile[:auth_token], current_profile[:user][:id].to_s)
        @response      = http.request(signed_request)
      else
        @response = http.request(request)
      end
    elsif method == DELETE_REQUEST
      request      = Net::HTTP::Delete.new(uri.request_uri, json_headers)
      request.body = params.to_json
      if is_auth_token
        signed_request = ApiAuth.sign!(request, current_profile[:auth_token], current_profile[:user][:id].to_s)
        @response      = http.request(signed_request)
      else
        @response = http.request(request)
      end
    end
    
    unless is_file
      if @response.present?
        @response = JSON.parse(@response.body)
      end
      
      if @response['errors'] == 'Access Denied'
        destroy_and_clear_session
        redirect_to root_path
      end
      @response
    end
  end
  
  def include_controller_js?
    @include_controller_js
  end
  
  def include_controller_js
    @include_controller_js = true
  end
  
  def include_controller_css
    @include_controller_css = true
  end
  
  def include_controller_css?
    @include_controller_css
  end
  
  def admin?
    current_user.try(:profile_type) == ADMIN
  end
  
  def member?
    current_user.try(:profile_type) == MEMBER
  end
  
  private
  def setting_websites
    @setting_website = session[:setting_website]
  end
end
