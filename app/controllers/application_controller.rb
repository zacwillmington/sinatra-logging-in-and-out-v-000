require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
      @user = User.find_by('username' => params[:username])
      #binding.pry
      if @user != nil
          session[:user_id] = @user.id
          redirect to '/account'
      else
         erb :error
      end
  end

  get '/account' do
    #    binding.pry
    @user = Helpers.current_user(session)
    # binding.pry
        if  !Helpers.is_logged_in?(session)
            erb :error
      else
        #   binding.pry
          erb :account
      end
  end

  get '/error' do
      erb :error
  end

  get '/logout' do
      session.clear
      redirect to '/'
  end


end
