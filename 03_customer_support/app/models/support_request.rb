class SupportRequest < ApplicationRecord
  belongs_to :customer
  belongs_to :agent

  @@status_list = %w{open closed}
  @@severity_list = %w{low medium high}
  @@category_list = %w{installation_and_setup voice_quality video_quality}

  validates :customer, presence: true
  validates :subject, presence: true
  validates :status, :presence => true, :inclusion => { :in => @@status_list, :message => "%{value} is not a valid status" }
  validates :severity, :presence => true, :inclusion => { :in => @@severity_list, :message => "%{value} is not a valid severity" }
  validates :category, :presence => true, :inclusion => { :in => @@category_list, :message => "%{value} is not a valid category" }

  after_initialize :after_initialize
  before_save :set_or_unset_closed_at
  after_save :assign_agent

  def is_open?
    return self.status == "open"
  end

  private

  def init
    self.status ||= "open"
    self.severity ||= "low"
  end

  # Checks if status of the support request has been changed
  # Sets closed_at if support request has been closed
  # Removes closed_at if support request has been reopened
  def set_or_unset_closed_at
    if self.status_changed?
      if self.status == "closed"
        self.closed_at = Time.current
      else
        self.clsoed_at = nil
      end
    end
  end

  def assign_agent
    if self.status == "open" and self.agent.blank?
      self.agent = Agent.all.sort_by{|agent| agent.open_support_requests.count}.first
      self.save
    end
  end
end

