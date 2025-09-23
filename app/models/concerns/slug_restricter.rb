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

  included { validate :restrict_slug_creation, if: -> { slug.present? } }

  private

  def restrict_slug_creation
    if RESERVED_SLUGS.include?(slug)
      errors.add(:name, :reserved_slug)
      errors.add(:slug, :reserved_slug)

      throw(:abort)
    end
  end
end
