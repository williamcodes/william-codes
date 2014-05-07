class PdfWriter

  attr_reader :user, :content_type, :pdf

  HEADERS = ["TIME", "DATE", "TEMP INSIDE", "TEMP OUTSIDE", "TEMP OF HOT WATER", "NOTES"]
  HEADER_OPTIONS = {width: 90, background_color: "AFAFAF", align: :center, font_style: :bold, border_width: 0.5}
  FONT = "Times-Roman"
  FONT_OPTIONS = {size: 7, align: :center}
  TABLE_OPTIONS = {width: 90, align: :center, border_width: 0.5}
  
  def initialize
    @content_type = "application/pdf"
    image_url = Rails.root.join("app","assets","images","orange_background.png")
    @pdf = Prawn::Document.new(background: image_url)
  end

  def generate_pdf
    populate_pdf
    pdf.render
  end

  def filename
    "cover_letter.pdf"
  end

  def populate_pdf
    image_url = Rails.root.join("app","assets","images","cover_letter.png")
    pdf.image image_url, width: 550
  end
end