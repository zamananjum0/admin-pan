class UserSessionsController < ApplicationController
  layout 'signin_layout'
  
  def sign_in
    # if logged_in?
    #
    # else
    #   redirect_to new_user_session_url
    # end
  end
  
  def create
    request = {
        "user":{
            "email":    params[:email],
            "password": params[:password]
        },
        "user_session": {
            "device_uuid": "vBD-y53ED85-FB4",
            "device_type": "web"
        }
    }
    response_hash = api_request('user_sessions/login', request, POST_REQUEST, false)
    response      = HashToObject.convert(response_hash)

    if response.resp_status == 1
      session[:user_session] = response_hash['data']
      redirect_to dashboards_path
    else
      @messages = errors_display([response.errors].flatten)
    end
  end
  
  def destroy
    destroy_and_clear_session
    redirect_to sign_in_user_sessions_path
  end
end
