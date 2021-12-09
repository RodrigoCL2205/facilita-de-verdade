class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @work_periods = policy_scope(WorkPeriod).order(created_at: :desc)
    @licenses = current_user.licenses.order(start_date: :asc)
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
