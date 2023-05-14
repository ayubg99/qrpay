class WelcomeController < ApplicationController
  def index
    @contact = Contact.new
  end
end
