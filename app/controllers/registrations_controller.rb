class RegistrationsController < Devise::RegistrationsController
  
  def new
    @bar = Bar.new
    @bar.hrsranges.new
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end