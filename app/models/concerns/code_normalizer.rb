module CodeNormalizer
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_code
  end

  private

  def normalize_code
    self.code = code&.strip&.presence
  end
end
