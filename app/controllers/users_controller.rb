class UsersController < ApplicationController
  
  def index
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    request = {
        page:     page,
        per_page: 10
    }
    response_hash = api_request('users', request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @member_profiles  = response.data.member_profiles
      @paging_data      = response.paging_data
    else
      return render json: false
    end
  end
  
  def user_events
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    request = {
        page:     page,
        per_page: 10,
        member_profile_id: params[:id]
    }
    response_hash = api_request('users/user_events', request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @events      = response.data.events
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end

  def user_posts
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    request = {
        page:     page,
        per_page: 10,
        member_profile_id: params[:id]
    }
    response_hash = api_request('users/user_posts', request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @posts       = response.data.posts
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end

  def user_followers
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    request = {
        page:     page,
        per_page: 10,
        member_profile_id: params[:id]
    }
    response_hash = api_request('users/user_followers', request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @followers   = response.data.member_followers
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end
  
end
