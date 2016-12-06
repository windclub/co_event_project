class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :users_attending, through: :attendees, source: :user
  validates :name, :date, :city, :state, presence: true 
end
