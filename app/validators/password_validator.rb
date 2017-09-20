class PasswordValidator < ActiveModel::Validator
  VALIDATIONS = [
    { type: 'uppercase', regexp: /[A-Z]/ },
    { type: 'lowercase', regexp: /[a-z]/ },
    { type: 'number',    regexp: /\d/    }
  ].freeze

  def validate(record)
    validate_spaces(record)
    VALIDATIONS.each do |validation|
      send("validate_#{validation[:type]}", record)
    end
  end

  private

  def validate_spaces(record)
    return unless record.password&.include?(' ')
    record.errors.add(:password, "mustn't contain spaces")
  end

  VALIDATIONS.each do |validation|
    define_method "validate_#{validation[:type]}" do |record|
      return if record.password.match?(validation[:regexp])
      record.errors.add(
        :password,
        "must contain at least 1 #{validation[:type]}"
      )
    end
  end
end
