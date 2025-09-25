module SlugRestricter
  extend ActiveSupport::Concern

  # TODO: Would it be wise to also include application paths here?
  # Taken from https://github.com/norman/friendly_id
  RESERVED_SLUGS = %w[
    admin
    assets
    edit
    images
    index
    javascripts
    login
    logout
    new
    session
    stylesheets
    users
  ]

  included { validate :validate_slug_not_reserved, if: -> { slug.present? } }

  private

  def validate_slug_not_reserved
    if RESERVED_SLUGS.include?(slug)
      errors.add(:name, :cannot_generate_slug)
      errors.add(:slug, :cannot_generate_slug)

      throw(:abort)
    end
  end
end
