class EventsController < ApplicationController
  
  def index
    params[:page].present? ? page = params[:page] : page = 1
    request = {
        page:     page,
        per_page: 10,
        search_key: "Time",
        member_profile_id: current_profile[:id]
    }
    response_hash = api_request('events', request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @events      = response.data.events
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end
  
  def show
    params[:page].present? ? page = params[:page] : page = 1
    request = {
        page:     page,
        per_page: 10,
        event_id: params[:id],
        current_user_id: current_user.id
    }
    response_hash = api_request("events/#{params[:id]}", request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @event_id = params[:id]
      @posts  =  response.data.posts
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end
end
