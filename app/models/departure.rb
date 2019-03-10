class Departure < ApplicationRecord
  belongs_to :incident
  belongs_to :user

  # Scopes
  default_scope { order(date_start: :desc) }
  scope :date_start_asc, -> { unscope(:order).order(date_start: :asc) }

  validates :user_id, :incident_id, :description, :date_start, presence: true

  validate :check_date_start, if: -> { incident_id }

  private

  def check_date_start
    incident = Incident.find(incident_id)
    errors.add(:date_start, :not_in_the_past) if date_start && incident && (date_start < incident.date_receive)
  end

end
