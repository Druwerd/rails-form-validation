module AuthorizationConcern
  extend ActiveSupport::Concern

  def authenticate_user!
    return if current_user.present? && current_user.id == params[:id].to_i

    render plain: '401 Unauthorized', status: :unauthorized
  end
end
