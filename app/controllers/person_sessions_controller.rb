# This controller handles the login/logout function of the site.
class PersonSessionsController < ApplicationController

  skip_before_filter :require_activation, :only => [:new, :destroy]

  def new
    @person_session = PersonSession.new
    @body = "login single-col"
  end
  

  def create
    @person_session = PersonSession.new(params[:person_session])
    @person_session.save do |result|
      if result
        flash[:notice] = t('notice_logged_in_successfully')
        unless params[:person_session].nil?
          logger.info "OSC LOGIN SUCCESS: #{params[:person_session][:email]} from #{request.remote_ip}"
        end
        redirect_back_or_default root_url
      end
    end
    if !performed?
      #flash[:error] = t('error_authentication_failed')
      unless params[:person_session].nil?
        logger.info "OSC LOGIN FAILURE: #{params[:person_session][:email]} from #{request.remote_ip}"
      end
      @body = "login single-col"
      render :action => 'new'
    end
  end

  def destroy
    @current_person_session.destroy
    flash[:notice] = "Log out successful!"
    redirect_back_or_default root_url
  end
end
