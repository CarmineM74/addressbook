class ContactsController < ApplicationController
  respond_to :json

  def index
    @contacts = Contact.all
    respond_with(@contacts)	
  end

  def new
  end

  def create
  end

  def show
    
  end

  def edit
    
  end

  def update
  end

  def destroy
  end
end
