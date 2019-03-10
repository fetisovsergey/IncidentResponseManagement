class Organisation < ApplicationRecord
  REGION_LIST = ['1', '2']

  has_many :incidents, dependent: :destroy
  has_many :infected_machines, dependent: :destroy

  default_scope { order(name: :asc) }

  # Set strip names
  after_validation :set_strip_names

  validates :name, :ip, :region, presence: true

  validates :name, uniqueness: { case_sensitive: false }

  validates :region, inclusion: { in: REGION_LIST }

  def self.search(query)
    query = query.strip
    where("name ilike ? or ip like ?", "%#{query}%", "%#{query}%")
  end

  private

  def set_strip_names
    [:name, :contact_tech, :contact_security, :handler].each { |attr| self[attr] = self[attr].strip }
  end
end
