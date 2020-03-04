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

  # Redirects to stored referrer (or to the default).
  def redirect_back_or(default)
    controller.redirect_to(session[:referrer] || default)
    session.delete(:referrer)
  end

  # Stores the URL trying to be accessed.
  def store_referrer
    session[:referrer] = request.referrer if request.get?
  end

  def edit_path(model)
    send("edit_#{model.model_name.singular}_path", model)
  end

end
