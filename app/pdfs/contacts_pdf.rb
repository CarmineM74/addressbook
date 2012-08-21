require 'prawn/measurement_extensions'

class ContactsPdf
  def initialize(contacts, view)
    @contacts = contacts
    @view = view
    @pdf = Prawn::Document.new
    do_header
    do_body
    do_footer
  end

  def render
    @pdf.render
  end

  def do_header
    @pdf.define_grid(:columns => 24, :rows => 24, :gutter => 5)
    #@pdf.grid.show_all
    @pdf.grid([0,0],[0,23]).bounding_box do
      @pdf.transparent(0.5) { @pdf.stroke_bounds }
      @pdf.text 'Contacts List', :align => :center, :valign => :center
    end
  end

  def do_body
    @pdf.grid([2,0],[20,23]).bounding_box do
      #@pdf.transparent(0.5) { @pdf.stroke_bounds }
      @pdf.table(contact_item_rows) do
        self.header = true
	self.row_colors = ['F0F0F0','A0A0A0']
	self.position = :center
      end
    end
  end

  def contact_item_rows
    [["Name", "Surname", "Phone Nr.", "Email", "Active"]] +
    @contacts.map do |contact|
      [contact.name, contact.surname, contact.phone, contact.email, contact.active? ? "YES" : "NO"]
    end
  end

  def do_footer
    @pdf.grid([22,0],[23,23]).bounding_box do
      @pdf.transparent(0.5) { @pdf.stroke_bounds }
    end
  end

end
