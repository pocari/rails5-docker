class HelloController < ApplicationController
  def hello
    @msg = "world 1234"
    if session[:user_id]
      @hello_msg = "こんにちは, #{session[:user_id]}"
    else
      session[:user_id] = "dummy_user_name" + Time.now.to_s
      @hello_msg = "セッションがなかったので作りました. #{session[:user_id]}"
    end
  end
end
