class RegistrationsController < Devise::RegistrationsController
  
  def new
    @bar = Bar.new
    @bar.hrsranges.new
  end

  def create
    @bar = Bar.new(params[:bar])
    @bar.hrsranges.each_with_index do |hrsrange, idx|
      hrsrange.open = TIMES[params[:bar][:hrsranges_attributes].values[idx][:open]]
      hrsrange.close = TIMES[params[:bar][:hrsranges_attributes].values[idx][:close]]
    end
    if @bar.save
      sign_in @bar
      flash[:success] = "Welcome! You have signed up successfully."
      if current_bar.rooms.count == 0
        redirect_to new_room_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = "Sign up unsuccessfull"
      redirect_to new_bar_registration_path
    end
  end

  def edit
    @bar = current_bar
    @bar.hrsranges.each do |hrsrange|
      hrsrange.open = TIMES.key(hrsrange.open) if hrsrange.open
      hrsrange.close = TIMES.key(hrsrange.close) if hrsrange.close
    end
  end

  def update
    @bar = current_bar
    params[:bar][:hrsranges_attributes].values.each do |hrsrange|
      hrsrange[:open] = TIMES[hrsrange[:open]]
      hrsrange[:close] = TIMES[hrsrange[:close]]
    end if params[:bar][:hrsranges_attributes]
    if @bar.update_with_password(params[:bar])
      sign_in @bar
      flash[:success] = "You updated your account successfully."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    super
  end
end