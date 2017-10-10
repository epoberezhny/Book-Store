RailsAdmin.config do |config|

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new { except ['Review', 'Order'] }
    # export
    bulk_delete
    show
    edit { except ['Review'] }
    delete
    show_in_app { except ['Order'] }
    state
  end

  config.label_methods << :email

  config.included_models = %w[Book Author Category User Review Order Material]

  config.model 'User' do
    visible false
  end

  config.model 'Material' do
    visible false

    edit do
      field :name
    end
  end

  config.model 'Category' do
    field :name
  end

  config.model 'Author' do
    fields :first_name, :last_name

    object_label_method do
      :custom_label_method
    end
  end

  config.model 'Review' do
    list do
      fields :book, :created_at, :user
      field :state, :state
      scopes [:unprocessed, :processed]
    end

    show do
      fields :body, :book, :user
    end

    edit do
      field :state
    end

    state events: { approve: 'btn-success', reject: 'btn-danger' },
          states: { approved: 'label-success', rejected: 'label-danger' }
  end

  config.model 'Order' do
    states = %i[in_queue in_delivery delivered canceled]

    list do
      fields :id, :created_at
      field :state
      scopes states
    end

    show do
      field :user
    end

    edit do
      field :state, :enum do
        enum do
          states
        end
      end
    end
  end

  config.model 'Book' do
    list do
      fields :cover, :category, :title, :authors, :description, :price
    end

    edit do
      exclude_fields :reviews, :order_items_count

      field :additional_images do
        partial 'additional_images_field'
      end

      configure :dimensions do
        partial 'dimensions_fields'
      end
    end

    show do
      configure :additional_images do
        formatted_value do
          bindings[:view].render 'additional_images', model: bindings[:object]
        end
      end
    end
  end

  def custom_label_method
    self.decorate.full_name
  end
end
