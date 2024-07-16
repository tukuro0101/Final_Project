RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.default_items_per_page = 100

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  config.show_gravatar = true

  config.model 'Cart' do
    list do
      field :user
      field :total_price do
        formatted_value do
          bindings[:object].total_price
        end
      end
      field :created_at
      field :updated_at
      field :cart_items
    end

    show do
      field :user
      field :total_price do
        formatted_value do
          bindings[:object].total_price
        end
      end
      field :created_at
      field :updated_at
      field :cart_items
    end

    edit do
      field :user
      field :total_price do
        formatted_value do
          bindings[:object].total_price
        end
      end
      field :cart_items
    end
  end

  config.model 'Order' do
    list do
      field :user
      field :address
      field :subtotal
      field :gst
      field :pst
      field :hst
      field :total_price
      field :created_at
      field :updated_at
    end

    show do
      field :user
      field :address
      field :subtotal
      field :gst
      field :pst
      field :hst
      field :total_price
      field :created_at
      field :updated_at
      field :order_items
    end

    edit do
      field :user
      field :address
      field :subtotal
      field :gst
      field :pst
      field :hst
      field :total_price
      field :order_items
    end
  end

  config.model 'StaticPage' do
    visible false
    edit do
      field :title
      field :content, :wysihtml5
    end
  end

  config.model 'Category' do
    list do
      field :name
    end
    edit do
      field :name
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.excluded_models = ['ActiveStorage::Blob', 'ActiveStorage::Attachment', 'ActiveStorage::VariantRecord']

  config.model 'Product' do
    list do
      field :name
      field :description
      field :price
      field :stock_quantity
      field :category
      field :image do
        pretty_value do
          bindings[:view].tag(:img, { src: bindings[:object].image_url, style: 'max-width: 100px; max-height: 100px;' }) if bindings[:object].image.attached?
        end
        filterable false
        sortable false
      end
      field :created_at
      field :updated_at
    end

    show do
      field :name
      field :description
      field :price
      field :stock_quantity
      field :category
      field :image do
        pretty_value do
          bindings[:view].tag(:img, { src: bindings[:object].image_url, style: 'max-width: 300px; max-height: 300px;' }) if bindings[:object].image.attached?
        end
      end
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :description
      field :price
      field :stock_quantity
      field :category
      field :image, :active_storage do
        pretty_value do
          bindings[:view].tag(:img, { src: bindings[:object].image_url, style: 'max-width: 300px; max-height: 300px;' }) if bindings[:object].image.attached?
        end
        help 'Current image displayed below. Upload a new image to replace it.'
      end
      field :created_at do
        read_only true
        help 'Read-only'
      end
      field :updated_at do
        read_only true
        help 'Read-only'
      end
    end
  end
end
