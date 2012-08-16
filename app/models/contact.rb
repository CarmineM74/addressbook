class Contact < ActiveRecord::Base
  attr_accessible :active, :email, :name, :notes, :phone, :surname
end
