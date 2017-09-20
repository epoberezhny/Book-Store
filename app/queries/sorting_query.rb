class SortingQuery < Rectify::Query
  I18N_SCOPE = :sorting_types.freeze
  
  def self.type(name, **opts)
    @default_sorting = name if opts[:default] == true
    title, order = opts.values_at(:title, :order)
    title = title || ->{ I18n.t(name, scope: I18N_SCOPE, default: name.to_s) }
    sorting_types[name] = { title: title, order: order }
  end

  def self.sorting_types
    @sorting_types ||= HashWithIndifferentAccess.new
  end

  def self.types_and_titles
    sorting_types.map do |name, value|
      title = value[:title]
      title = title.call if title.respond_to?(:call)
      [name, title]
    end
  end

  def self.active_sorting(name)
    title = sorting_types.dig(name, :title) || sorting_types[default_sorting][:title]
    title.respond_to?(:call) ? title.call : title
  end

  def self.default_sorting
    @default_sorting ||= sorting_types.keys.first.to_sym
  end

  private

  def sorting_order(name)
    sorting_types   = self.class.sorting_types
    default_sorting = self.class.default_sorting
    sorting_types.dig(name, :order) || sorting_types[default_sorting][:order]
  end
end