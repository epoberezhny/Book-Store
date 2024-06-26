class PasswordValidator < ActiveModel::Validator
  I18N_SCOPE = :validators.freeze

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
    record.errors.add(
      :password,
      I18n.t(:spaces, scope: I18N_SCOPE)
    )
  end

  VALIDATIONS.each do |validation|
    define_method "validate_#{validation[:type]}" do |record|
      return if record.password&.match?(validation[:regexp])
      record.errors.add(
        :password,
        I18n.t(:contain, scope: I18N_SCOPE, type: validation[:type])
      )
    end
  end
end
