class RemoteControlCenter < ApplicationRecord
  belongs_to :botnet

  has_many :relationships, foreign_key: "remote_control_center_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

  has_many :incidents, through: :relationships, source: :incident

  # Scopes
  default_scope { order(name: :asc) }

  # Get Country by MaxMind DB
  before_validation :set_country, if: -> { ip.present? && IPAddress.valid?(ip) }

  # Drop Country if ip is blank
  after_validation :drop_country, if: -> { ip.blank? }

  # Set downcase name
  after_validation :set_downcase_name

  # Check domain by http(s)
  after_validation :set_correct_domain, if: -> { domain.present? }

  validates :name, :botnet_id, presence: true

  validates :name, uniqueness: { case_sensitive: false}, if: -> { name != 'iplist' }

  validates :domain, uniqueness: { case_sensitive: false }, allow_blank: true

  validates :ip, ipaddr: true, allow_blank: true, uniqueness: { scope: :name }

  # Check if country is undefined by IP-address
  validate :check_country, if: -> { ip.present? && country.blank? }

  # Check if IP-address and Domain are blank
  validate :check_address, if: -> { ip.blank? && domain.blank? }

  def get_relationship(incident_id)
    self.relationships.find_by(incident_id: incident_id)
  end

  def self.search(query)
    query = query.strip
    where("name ilike ? or ip like ? or domain ilike ? or country ilike ?", "%#{query}%", "#{query}%", "%#{query}%", query)
  end

  private

  def set_country
    self.ip = ip.gsub(/^0*/, '').gsub(/\.0*/, '.')

    self.country = Maxminddb.lookup(ip).country.name(:ru)
  end

  def drop_country
    self.country = nil
  end

  def set_correct_domain
    self.domain = domain.downcase.gsub(/\Ahttp[s]\:/,'').gsub(/\//,'').gsub(/\Awww\./,'')
  end

  def set_downcase_name
    self.name = name.downcase
  end

  def check_country
    errors.add(:country, :undetected)
  end

  def check_address
    errors.add(:domain, :blank)
    errors.add(:ip, :blank)
  end
end
