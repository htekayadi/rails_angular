class Agent < User
  after_initialize :init

  has_many :support_requests

  before_destroy :assign_support_requests

  def open_support_requests
    return elf.support_requests.where(status: "open")
  end

  private

  def init
    self.type ||= "agent"
  end

  # Assigns the agent's support requests to other agents
  def assign_support_requests
    @support_requests = self.support_requests

    return if @support_requests.blank?

    @remaining_agents = Agent.all - [self]

    if @remaining_agents.blank?
      errors.add :agent, "Cannot delete last agent"
      throw :abort
    else
      @support_requests_groups = @support_requests.in_groups(@remaining_agents.count)
      @remaining_agents.each_with_index do |agent, i|
        @support_requests_to_assign = @support_requests[i]
        @support_requests_to_assign.each do |support_request|
          support_request.agent = agent
        end
      end

      unless @support_requests_groups.flatten.each(&:save)
        errors.add :agent, "Cannot reassign support requests"
        throw :abort
      end
    end
  end
end