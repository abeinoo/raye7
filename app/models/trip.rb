class Trip < ActiveRecord::Base
  validates_presence_of :time, :source, :destination

  belongs_to :user
  has_many :users_trips
  has_many :users, through: :users_trips

end
