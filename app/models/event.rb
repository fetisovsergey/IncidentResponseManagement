class Event < ApplicationRecord
  belongs_to :incident
  belongs_to :user

  default_scope { order(date_event: :asc) }

  validates :user_id, :incident_id, :date_event, :description, presence: true

  validate :check_date_event

  after_validation :set_current_state_of_incident

  private

  def set_current_state_of_incident
    incident = self.incident

    incident.update_column(:current_state, self.description) if self.new_record? || (incident.events.last == self)
  end

  def check_date_event
    incident = Incident.find(incident_id)
    errors.add(:date_event, :not_in_the_past) if date_event && (date_event < incident.date_receive)
  end
end
