module SlugRestricter
  extend ActiveSupport::Concern

  # Taken from https://github.com/norman/friendly_id
  RESERVED_SLUGS = %w[ new edit index session login logout users admin stylesheets assets javascripts images ]

  included do
    validate :restrict_slug_creation, if: -> { slug.present? }
  end

  private

  def restrict_slug_creation
    if RESERVED_SLUGS.include?(slug)
      errors.add(:name, "is reserved and cannot be used")
      errors.add(:slug, "is reserved and cannot be used")

      throw(:abort)
    end
  end
end
