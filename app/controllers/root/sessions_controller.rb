class Root::SessionsController < Root::NamespaceController
  def show
    render :json =>  session
  end
  
  def new
    redirect_to lists_path if warden.authenticated?
  end
  
  def create
    warden.authenticate!
    flash[:success] = t('root.flash.success.welcome_back', :username => warden.user.username)
    
    redirect_to lists_path
  end
  
  def destroy
    warden.logout
    flash[:notice] = t('root.flash.notice.goodbye')
    
    redirect_to root_path
  end
  
  def failure
    flash.now[:error] = t(warden.message, :scope => 'root.flash.error')
      
    render :new
  end
end
