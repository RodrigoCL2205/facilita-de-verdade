class WorkPeriodsController < ApplicationController

  def index
    @work_periods = policy_scope(WorkPeriod).order(created_at: :desc)
    score_details
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

  def score_details
    month = Date.today.month
    year = Date.today.year
    @current_month_scores = current_user.scores
    # Array com todos os objetos 'score' do mês atual
    @current_month_scores.select! { |score| score.date.month == month && score.date.year == year }
    # Soma de todos os pontos no mês atual
    @current_month_score = @current_month_scores.map{ |score| score.score }.reduce(:+)
  end
end
