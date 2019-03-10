class Relationship < ApplicationRecord
  belongs_to :incident
  belongs_to :remote_control_center

  validates :incident_id, :remote_control_center_id, presence: true
  validates :remote_control_center_id, uniqueness: { scope: :incident_id }
end
