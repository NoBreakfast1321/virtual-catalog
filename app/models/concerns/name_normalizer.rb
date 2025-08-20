module NameNormalizer
  extend ActiveSupport::Concern

  included { before_validation :normalize_name }

  private

  def normalize_name
    self.name = name&.strip&.presence
  end
end
