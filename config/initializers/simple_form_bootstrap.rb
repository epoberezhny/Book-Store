SimpleForm.setup do |config|
  config.error_notification_class = 'alert alert-danger'
  config.button_class = 'btn btn-default'
  config.boolean_label_class = nil
  config.input_class  = 'form-control'

  config.wrappers :vertical_form, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: 'control-label input-label'

    b.use :input#, class: 'form-control'
    b.use :full_error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :general_form, tag: 'div', class: 'form-group mb-30', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.use :label, class: 'control-label input-label'

    b.use :input#, class: 'form-control'
    b.use :full_error, wrap_with: { tag: 'span', class: 'help-block' }
    b.use :hint, wrap_with: { tag: 'p', class: 'help-block' }
  end
  
  config.default_wrapper = :vertical_form
end
