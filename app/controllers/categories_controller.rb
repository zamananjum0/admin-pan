class CategoriesController < ApplicationController
  
  def index
    if params[:page].present?
      page = params[:page]
    else
      page = 1
    end
    request = {
        page:     page,
        per_page: 10,
        auth_token: current_profile[:auth_token]
    }
    response_hash = api_request('categories', request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @categories    = response.data.categories
    else
      return render json: false
    end
  end
  
  def create
    if params[:name].present?
      request = {
          category: {
              name: params[:name]
          }
      }
      response_hash = api_request('categories', request, POST_REQUEST, true)
      response      = HashToObject.convert(response_hash)
      if response.resp_status == 1
        redirect_to  categories_path
      else
        return render json: false
      end
    else
      redirect_to categories_path
    end
  end
  
  def edit
    request = {}
    response_hash = api_request("categories/#{params[:id]}/edit", request, GET_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      @category = response.data.category
    else
      return render json: false
    end
  end
  
  def update
    if params[:name].present?
      request = {
          name: params[:name]
      }
      response_hash = api_request("/categories/#{params[:id]}", request, PUT_REQUEST, true)
      response      = HashToObject.convert(response_hash)
      if response.resp_status == 1
        redirect_to  categories_path
      else
        return render json: false
      end
    else
      redirect_to categories_path
    end
  end
  
  
  def destroy
    request = {}
    response_hash = api_request("categories/#{params[:id]}", request, DELETE_REQUEST, true)
    response      = HashToObject.convert(response_hash)
    if response.resp_status == 1
      redirect_to  categories_path
    else
      return render json: false
    end
  end
  
  
end
