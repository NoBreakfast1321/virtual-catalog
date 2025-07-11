module Products
  class VariantsRebuilder
    def self.call(product)
      new(product).call
    end

    def initialize(product)
      raise ArgumentError, "Argument 'product' cannot be nil" if product.nil?

      @product = product
    end

    def call
      ordered_property_groups = product
        .property_groups
        .order(:created_at)
        .reject { |property_group| property_group.properties.empty? }

      ActiveRecord::Base.transaction do
        product.variants.non_base.destroy_all

        return [] if ordered_property_groups.empty?

        combinations = ordered_property_groups
          .map(&:properties)
          .map(&:to_a)
          .then { |properties| properties.first.product(*properties.drop(1)) }

        combinations.map do |properties|
          base_code = product.code ? "#{product.code}-" : ""

          variant = product.variants.create!(
            code: "#{base_code}#{properties.map(&:name).join("-").upcase}",
            price: product.base_variant.price
          )

          properties.each_with_index do |property, index|
            VariantProperty.create!(
              position: index + 1,
              property: property,
              variant: variant
            )
          end

          variant
        end
      end
    end

    private

    attr_reader :product
  end
end
