SimpleForm.setup do |config|

  config.wrappers :default, class: :input,
    hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    
    b.use :html5
 
    b.use :placeholder
    
    b.optional :readonly

    ## Inputs
    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }
  end

  config.default_wrapper = :default

  config.boolean_style = :nested

  config.button_class = 'btn'

  config.error_notification_tag = :div

  config.error_notification_class = 'error_notification'

  config.label_text = lambda { |label, required, explicit_label| "#{label}" }

  config.browser_validations = false

  config.boolean_label_class = 'checkbox'

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'
end
