module PriceFormatter
  def format_price(*names)
    names.each do |name|
      define_method "formatted_#{name}" do
        public_send(name).to_s(:currency)
      end
    end
  end
end