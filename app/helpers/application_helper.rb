module ApplicationHelper
  # Returns the full-title on a per-page basis
  def full_title(page_title = '')
    base_title = 'Life on Peaceful'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
