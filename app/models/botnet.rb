class Botnet < ApplicationRecord
  has_many :remote_control_centers, dependent: :destroy
  has_many :infected_machines, dependent: :destroy

  default_scope { order(name: :asc) }

  # Set downcase name
  after_validation :set_downcase_name

  validates :name, uniqueness: { case_sensitive: true }, presence: true

  def countries
    self.remote_control_centers.pluck(:country).compact.sort.uniq
  end

  def incident_ids
    (self.infected_machines + Relationship.where(remote_control_center_id: self.remote_control_centers.pluck(:id))).pluck(:incident_id).sort.uniq
  end

  def incidents
    Incident.where(id: self.incident_ids)
  end

  def self.search(query)
    query = query.strip
    where("name ilike ?", "%#{query}%")
  end

  private

  def set_downcase_name
    self.name = name.capitalize
  end
end
