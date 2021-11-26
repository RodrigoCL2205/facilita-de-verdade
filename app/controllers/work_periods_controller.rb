class WorkPeriodsController < ApplicationController

  def index
    @work_periods = policy_scope(WorkPeriod).order(created_at: :desc)
  end
end
