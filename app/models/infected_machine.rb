class InfectedMachine < ApplicationRecord
  belongs_to :incident
  belongs_to :botnet
  belongs_to :organisation

  #Scopes
  default_scope { order(name: :asc) }
  scope :incident_id_asc, -> { unscope(:order).order(incident_id: :asc) }

  # Set strip names
  before_validation :set_strip_names

  # Convert HDD identificator
  after_validation :upcase_hdd_id, if: -> { hdd_id.present? }

  validates :name, :incident_id, :botnet_id, :organisation_id, presence: true

  validates :ip, ipaddr: true, allow_blank: true

  validates :name, uniqueness: { scope: :incident_id, case_sensitive: false }
  validates :mac, uniqueness: { scope: :incident_id, case_sensitive: false }, if: -> { mac.present? }
  validates :ip, uniqueness: { scope: :incident_id, case_sensitive: false }, if: -> { ip.present? }
  validates :hdd_id, uniqueness: { scope: :incident_id, case_sensitive: false }, if: -> { hdd_id.present? }

  def self.search(query)
    query = query.strip
    where("name ilike ? or ip like ? or hdd_id ilike ?", "%#{query}%", "#{query}%", "%#{query}%")
  end

  private

  def upcase_hdd_id
    self.hdd_id = hdd_id.upcase
  end

  def set_strip_names
    [:ip, :name].each { |attr| self[attr] = self[attr].strip }
  end
end
