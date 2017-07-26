class DashboardsController < ApplicationController
  
  def index
    if logged_in?
      request = {}
      response_hash = api_request('dashboards', request, GET_REQUEST, true)
      response      = HashToObject.convert(response_hash)
      if response.resp_status == 1
        @events       = response.data.events
        @posts        = response.data.posts
        @users        = response.data.users
        @new_users        = response.data.new_users
        @yesterday_users        = response.data.yesterday_users
        @today_events = response.data.today_events
        @yesterday_events = response.data.yesterday_events
      else
        return render json: false
      end
    else
      redirect_to sign_in_user_sessions_path
    end
  end
end
