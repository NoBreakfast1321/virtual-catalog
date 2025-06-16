class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include TimestampFilterer
  include TimestampOrderer
end
