class PostsController < ApplicationController
  
  def index
    params[:page].present? ? page = params[:page] : page = 1
    request = {
        page:     page,
        per_page: 10,
        member_profile_id: current_profile[:id]
    }
    response_hash = api_request("posts", request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @posts       =  response.data.posts
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
        current_user_id: current_user.id
    }
    response_hash = api_request("posts/show", request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      # @event_id = params[:id]
      @posts  =  response.data.posts
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end
  
  def get_likes
    params[:page].present? ? page = params[:page] : page = 1
    request = {
        page:     page,
        per_page: 10,
        post_id: params[:id]
    }
    response_hash = api_request("posts/#{params[:id]}/post_likes", request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @event_id = params[:event_id]
      @likes  =  response.data.post_likes
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end
  
  def get_comments
    params[:page].present? ? page = params[:page] : page = 1
    request = {
        page:     page,
        per_page: 10,
        post_id: params[:id]
    }
    response_hash = api_request("posts/#{params[:id]}/post_comments", request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @event_id = params[:event_id]
      @post_id  = params[:id]
      @comments  =  response.data.post_comments
      @paging_data = response.paging_data
    else
      return render json: false
    end
  end
  
  def destroy
    request = {
        post_id: params[:id]
    }
    response_hash = api_request("posts/#{params[:id]}/", request, DELETE_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @event_id = params[:event_id]
      redirect_to event_path(params[:event_id])
    else
      return render json: false
    end
  end
end
