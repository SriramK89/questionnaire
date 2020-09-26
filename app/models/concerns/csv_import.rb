module CSVImport
  extend ActiveSupport::Concern

  def process_data(csv_file_contents)
    begin
      csv_file_contents.each_with_index do |csv_file_content, i|
        mapping = Mapping.find_or_initialize_by(name: csv_file_content[:mapping])
        return [false, "Error while creating mapping #{mapping.errors.full_messages.join(', ')} on row number #{i + 2}"] if mapping.id.nil? && !mapping.save

        role = Role.find_or_initialize_by(name: csv_file_content[:role])
        return [false, "Error while creating role #{role.errors.full_messages.join(', ')} on row number #{i + 2}"] if role.id.nil? && !role.save

        question = Question.find_or_initialize_by(content: csv_file_content[:question], mapping_id: mapping.id, role_id: role.id)
        question.pri = csv_file_content[:pri].to_i
        question.teaming_stages = csv_file_content[:teaming_stages]
        question.appears = csv_file_content[:appears_day].to_i
        question.frequency = csv_file_content[:frequency].to_i
        question.question_type = csv_file_content[:type]
        question.is_required = (csv_file_content[:required].downcase == 'yes')
        question.conditions = csv_file_content[:conditions]
        return [false, "Error while creating question #{question.errors.full_messages.join(', ')} on row number #{i + 2}"] if !question.save
      end
    rescue Exception
      return [false, "Exception occured. Check CSV file format"]
    end

    [true, "Created all questions"]
  end
end