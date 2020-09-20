# frozen_string_literal: true

class UsersController < ApplicationController
  include ActiveModel::Serializers::JSON
  def me
    render json: @current_user, adapter: :json
  end

  def update_status
    message = params[:text]
    TwitterManager::TweetCreator.call(message)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
