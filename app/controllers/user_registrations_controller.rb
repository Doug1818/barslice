class UserRegistrationsController < Devise::RegistrationsController
  
  def new
    @user = User.new
    @user.reservations.new
    @room = Room.find(params[:format])
    @bar = Bar.find(@room.bar_id)
  end

  def create
    @room = Room.find(params[:user][:reservations_attributes].values[0][:room_id])
    @bar = Bar.find(@room.bar_id)
    @user = User.new(params[:user])
    @user.reservations.last.date = Date.strptime(params[:user][:reservations_attributes].values[0][:date],"%m/%d/%Y").to_date if params[:user][:reservations_attributes].values[0][:date] != ""
    @user.reservations.last.start_time = TIMES[params[:user][:reservations_attributes].values[0][:start_time]]
    @user.reservations.last.end_time = TIMES[params[:user][:reservations_attributes].values[0][:end_time]]
    @user.reservations.last.user_name = @user.name
    @user.reservations.last.room_name = @room.name
    @user.reservations.last.bar_name = @bar.name
    if @user.save
      if @bar.claimed == true
        flash[:success] = "Your reservation request has been sent to #{@bar.name}. You will be notified of their availability by email as soon as possible."
      else
        flash[:success] = "A reservation request is being sent to #{@bar.name}. You will be notified of their availability by email as soon as possible."
      end
      sign_in(:user, @user)
      redirect_to root_path
      BarMailer.resrequest(@room, @bar, @user).deliver
      UserMailer.resrequest_confirmation(@user).deliver
    else
      render 'new'
    end
  end
end