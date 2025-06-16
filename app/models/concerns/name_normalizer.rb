module NameNormalizer
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_name
  end

  private

  def normalize_name
    self.name = name.strip if name.present?
  end
end
