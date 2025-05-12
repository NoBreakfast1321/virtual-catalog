module VisibilityScopes
  extend ActiveSupport::Concern

  included do
    scope :visible, -> { where(visible: true) }
    scope :invisible, -> { where(visible: false) }
  end
end
