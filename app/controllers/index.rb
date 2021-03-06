get '/' do
  if current_user?
    @user = current_user
  end
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end


get '/sign_out' do
  session.clear
  redirect '/'
end

get '/status/:job_id' do
  job_is_complete(params[:job_id])
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  @user = User.find_by_username(@access_token.params[:screen_name])
  unless @user
    @user = User.create(username: @access_token.params[:screen_name],
                        oauth_token:  @access_token.params[:oauth_token],
                        oauth_secret: @access_token.params[:oauth_token_secret])
  end
  session[:user_id] = @user.id
  erb :index
end

post "/tweet" do
  @text = params[:tweet]
  delay = params[:delay].to_i
  if delay <= 0
    @job_id = current_user.tweet(@text)
  else
    @job_id = current_user.tweet_later(delay, @text)
  end
  return @job_id if request.xhr?
  if @job_id
    erb :tweeted
  else
    erb :failed_tweet
  end
end


