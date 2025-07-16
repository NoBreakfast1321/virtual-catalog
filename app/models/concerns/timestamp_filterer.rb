module TimestampFilterer
  extend ActiveSupport::Concern

  included do
    scope :created_before, ->(date) { where(created_at: ...date) }
    scope :updated_before, ->(date) { where(updated_at: ...date) }

    scope :created_after, ->(date) { where("created_at > ?", date) }
    scope :updated_after, ->(date) { where("updated_at > ?", date) }

    scope :created_between,
          ->(start_date, end_date) { where(created_at: start_date..end_date) }

    scope :updated_between,
          ->(start_date, end_date) { where(updated_at: start_date..end_date) }
  end
end
