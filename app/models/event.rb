class Event < ActiveRecord::Base
  belongs_to :category
  has_one :location
  #has_many :attendees, :order => 'id desc', :dependent => :destroy
  delegate :name, :to => :category, :prefix => true, :allow_nil => true
  validates_presence_of :name
end
