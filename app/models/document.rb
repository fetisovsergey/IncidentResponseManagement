class Document < ApplicationRecord
  belongs_to :incident
  belongs_to :user

  # Scopes
  default_scope { order(date_signature: :desc) }
  scope :date_signature_asc, -> { unscope(:order).order(date_signature: :asc) }

  # Set strip names
  after_validation :set_strip_names

  validates :incident_id, :user_id, :destination, :description, :date_signature, :number, presence: true

  validate :check_date_start, if: -> { incident_id }

  private

  def check_date_start
    incident = Incident.find(incident_id)
    errors.add(:date_signature, :not_in_the_past) if date_signature && incident && (date_signature < incident.date_receive)
  end

  def set_strip_names
    [:number, :destination].each { |attr| self[attr] = self[attr].strip }
  end

end
