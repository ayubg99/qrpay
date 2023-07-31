class Table < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :restaurant
  has_one_attached :qrcode, dependent: :destroy
  before_commit :generate_qrcode, on: :create

  validates :table_number, presence: true, uniqueness: { scope: :restaurant_id }

  private

  def generate_qrcode
    # Get the host
    # host = Rails.application.routes.default_url_options[:host]
    # Create the QR code object
    # qrcode = RQRCode::QRCode.new("http://#{host}/posts/#{id}")
    #host = Rails.application.config.action_controller.default_url_options[:host]
    
    qrcode = RQRCode::QRCode.new('https://nameless-journey-71604-bcaa0875548a.herokuapp.com' + restaurant_path(self.restaurant, table_number: self.table_number))

    # Create a new PNG object
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120,
    )

    # Attach the QR code to the active storage
    self.qrcode.attach(
      io: StringIO.new(png.to_s),
      filename: "qrcode.png",
      content_type: "image/png",
    )
  end
end
