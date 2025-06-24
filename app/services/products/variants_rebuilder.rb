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
      property_groups = product.property_groups.reject { |property_group| property_group.properties.empty? }

      ActiveRecord::Base.transaction do
        product.variants.destroy_all

        return [] if property_groups.empty?

        combinations = property_groups
          .map(&:properties)
          .map(&:to_a)
          .then { |properties| properties.first.product(*properties.drop(1)) }

        combinations.map do |properties|
          variant = product.variants.create!

          variant.properties << properties

          variant
        end
      end
    end

    private

    attr_reader :product
  end
end
