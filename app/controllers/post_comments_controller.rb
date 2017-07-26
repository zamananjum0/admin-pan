class PostCommentsController < ApplicationController
  
  def destroy
    request = {
        id: params[:id]
    }
    response_hash = api_request("posts/#{params[:post_id]}/post_comments/#{params[:id]}", request, DELETE_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      redirect_to get_comments_event_post_path(params[:event_id], params[:post_id])
    else
      return render json: false
    end
  end
end
