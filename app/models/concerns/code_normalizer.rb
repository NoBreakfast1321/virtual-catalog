module CodeNormalizer
  extend ActiveSupport::Concern

  included { before_validation :normalize_code }

  private

  def normalize_code
    self.code = code&.strip&.presence
  end
end
