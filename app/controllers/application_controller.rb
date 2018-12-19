class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Make the current_user method available to views also, not just controllers:
  helper_method :current_user
  helper_method :sort_column, :sort_direction


  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # authorize method redirects user to login page if not logged in:
  def authorize
    redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  # Methods for sortable columns. Used in show views for Author, Composer, Work. sortable_columns is the white-list of columns in each of the individual controllers.

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "date"
  end

  def sort_direction
    if %w[asc, desc].include?(params[:direction])
      params[:direction]
    else
      "asc" 
    end
    # %w[asc, desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
