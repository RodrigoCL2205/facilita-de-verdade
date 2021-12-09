class WorkPeriodsController < ApplicationController
  before_action :set_work_period, only: [:edit, :update, :destroy]

  def index
    @work_periods = policy_scope(WorkPeriod).order(created_at: :desc)
    @licenses = current_user.licenses.order(start_date: :asc)
    score_details
  end

  def new
    @work_period = WorkPeriod.new
    authorize @work_period
    @program_collection = ['CEAB', 'PGRP', 'CEAP']
  end

  def create
    @work_period = WorkPeriod.new(work_period_params)
    @work_period.user = current_user
    authorize @work_period
    if !@work_period.end_date.nil? && @work_period.end_date < @work_period.start_date
      redirect_to new_work_period_path, alert: "Data fim não pode ser menor que a data de início."
    elsif @work_period.save
      redirect_to users_show_path(current_user), notice: "Período criado com sucesso."
    else
      render :new
    end
  end

  def edit
    @program_collection = ['CEAB', 'PGRP', 'CEAP']
  end

  def update
    @work_period.update(work_period_params)
    redirect_to users_show_path(current_user), notice: "Período alterado."
  end

  def destroy
    @scores = @work_period.scores
    @scores.each { |score| score.destroy }
    @work_period.destroy
    redirect_to users_show_path(current_user), notice: "Período de atividade excluído com sucesso."
  end

  private

  def set_work_period
    @work_period = WorkPeriod.find(params[:id])
    authorize @work_period
  end

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
