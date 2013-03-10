class CustomFailure < Devise::FailureApp
  def redirect_url
    if request.referrer.include?("/claim_bar")
      bar_id = request.referrer.split("/")[4].to_i
      claim_bar_bar_path(bar_id)
    else
      super
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end