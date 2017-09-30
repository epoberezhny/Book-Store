module SortingQuery
  extend ActiveSupport::Concern

  I18N_SCOPE = :sorting_types

  def sorting_order(name)
    sorting_types   = self.class.sorting_types
    default_sorting = self.class.default_sorting
    sorting_types.dig(name, :order) || sorting_types[default_sorting][:order]
  end

  module ClassMethods
    def type(name, **opts)
      @default_sorting = name if opts[:default] == true
      title, order = opts.values_at(:title, :order)
      title ||= -> { I18n.t(name, scope: I18N_SCOPE, default: name.to_s) }
      sorting_types[name] = { title: title, order: order }
    end
  
    def sorting_types
      @sorting_types ||= HashWithIndifferentAccess.new
    end
  
    def types_and_titles
      sorting_types.map do |name, value|
        title = value[:title]
        title = title.call if title.respond_to?(:call)
        [name, title]
      end
    end
  
    def active_sorting(name)
      title = sorting_types.dig(name, :title) || sorting_types[default_sorting][:title]
      title.respond_to?(:call) ? title.call : title
    end
  
    def default_sorting
      @default_sorting ||= sorting_types.keys.first.to_sym
    end
  end
end
