class ContactsController < ApplicationController
  respond_to :json

  def index
    @contacts = Contact.all
    respond_with(@contacts)	
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.save
    respond_with(@contact)
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(params[:contact])
    respond_with(@contact)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    respond_with({})
  end
end
