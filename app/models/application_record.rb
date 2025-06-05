class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include FilterableByTimestamp
  include OrderableByTimestamp
end
