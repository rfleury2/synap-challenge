class League < ActiveRecord::Base
  has_many :people
  belongs_to :event
end