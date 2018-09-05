require 'socket'

class InfoController < ApplicationController

  def show
    render plain: Socket.gethostname + "\n"
  end

end
