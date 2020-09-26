require 'csv'

class DataController < ApplicationController
  def home
  end

  def upload_csv
    csv_text = params[:upload_csv_file].tempfile.read
    csv_file_contents = []
    CSV.parse(csv_text, headers: true, header_converters: :symbol).each do |row|
      csv_file_contents << row.to_hash
    end
    status, message = Mapping.process_data(csv_file_contents)

    render json: { message: message }, status: (status ? :ok : :bad_request)
  end

  def display
    questions = Question.includes(:mapping, :role)
    render locals: { questions: questions }
  end
end
