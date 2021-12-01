class WorkPeriodsController < ApplicationController

  def index
    @work_periods = policy_scope(WorkPeriod).order(created_at: :desc)
  end

  def new
    @work_period = WorkPeriod.new
    authorize @work_period
    @program_colletcion = ['CEAB', 'PGRP', 'CEAP']
  end

  def create
    @work_period = WorkPeriod.new(work_period_params)
    @work_period.user = current_user
    authorize @work_period
    if @work_period.save
      redirect_to work_periods_path, notice: "Período criado com sucesso."
    else
      render :new
    end

  end

  private

  def work_period_params
    params.require(:work_period).permit(:program, :start_date, :end_date)
  end
end
