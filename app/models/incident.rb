class Incident < ApplicationRecord

  SOURCE_LIST = ['1', '2', '3', 'Другой']
  include AASM

  belongs_to :user
  belongs_to :organisation

  has_many :events, dependent: :destroy
  has_many :infected_machines, dependent: :destroy
  has_many :departures, dependent: :destroy
  has_many :documents, dependent: :destroy

  has_many :relationships, foreign_key: "incident_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy

  has_many :remote_control_centers, through: :relationships, source: :remote_control_center

  # Scopes
  default_scope { order(identificator: :asc) }
  scope :date_close_desc, -> { unscope(:order).order(date_close: :desc) }
  scope :date_close_asc, -> { unscope(:order).order(date_close: :asc) }
  scope :state_asc, -> { unscope(:order).order(state: :asc) }

  validates :user_id, :organisation_id, :identificator, :source, :date_receive, :date_incident, :description, :current_state, presence: true

  validates :source, inclusion: { in: SOURCE_LIST }

  validates :identificator, numericality: { only_integer: true, greater_than: 0 }, uniqueness: true

  validate :check_dates, if: -> { date_receive && date_incident}
  validate :check_close_date, if: -> { date_close }

  aasm column: 'state' do
    state :active, initial: true
    state :closed

    event :close  do
      transitions from: :active, to: :closed
    end

    event :open  do
      transitions from: :closed, to: :active
    end
  end

  def set_close_date
    self.update_column(:date_close, Time.now)
  end

  def unset_close_date
    self.update_column(:date_close, nil)
  end

  def botnet_ids
    (self.infected_machines + self.remote_control_centers).pluck(:botnet_id).sort.uniq
  end

  def botnets
    Botnet.where(id: self.botnet_ids)
  end

  def remote_control_centers_compact
    remote_control_centers = self.remote_control_centers.to_a.
                                  delete_if { |remote_control_center| remote_control_center.country.blank? }
  end

  def remote_control_centers_available
    remote_control_centers = []

    Botnet.all.each { |botnet| remote_control_centers += botnet.remote_control_centers }

    (remote_control_centers - self.remote_control_centers).collect{ |rcc| ["#{rcc.botnet.name}: #{rcc.ip}#{ (rcc.domain.present? && rcc.ip.present?) ? ' - ' : '' }#{ rcc.domain.present? ? rcc.name + ' - ' + rcc.domain : '' }", rcc.id] }
  end

  def remote_control_centers_countries
    self.remote_control_centers.pluck(:country).compact
  end

  private

  def check_dates
    errors.add(:date_receive, :not_in_the_past) if date_receive < date_incident
  end

  def check_close_date
    errors.add(:date_close, :not_in_the_past) if (date_close < date_receive || date_close < date_incident)
  end

end
