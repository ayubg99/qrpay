class ReceiptsController < ApplicationController
    def download
        pdf_path = "#{params[:pdf_path]}.pdf"
        send_file pdf_path, filename: 'receipt.pdf', type: 'application/pdf', disposition: 'attachment'

    end
end
