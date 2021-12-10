class WorkPeriodsController < ApplicationController
  before_action :set_work_period, only: [:edit, :update, :destroy]

  def index
    @work_periods = policy_scope(WorkPeriod).order(created_at: :desc)
    @licenses = current_user.licenses.order(start_date: :asc)
    month = Date.today.month
    year = Date.today.year
    score_details(year, month)

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

  def score_details(year, month)
    @array_current_month_scores = current_user.scores
    # Array com todos os objetos 'score' do mês atual
    @array_current_month_scores.select! { |score| score.date.month == month && score.date.year == year }
    # Soma de todos os pontos no mês atual
    @current_month_score = @array_current_month_scores.map{ |score| score.score }.reduce(:+)
    # Array com todos os objetos 'score' do dia atual
    @array_current_day_scores = @array_current_month_scores.select { |score| score.date == Date.today }
    # Soma de todos os pontos do dia atual
    @current_day_score = @array_current_day_scores.map { |score| score.score }.reduce(:+)
    @meta_mensal = sum_score(year, month)
    @falta_meta_mensal = @meta_mensal - @current_month_score
  end

  def create_hash_dias(year, month)
    # É criado um hash para cada dia do mês vigente para verificar se é útil.
    @array_hash_dia = []
    # Armazena o dia e se ele é útil com 'true' ou 'false'
    @hash_dias = {}
    # Verifica o número de dias o mês vigente possui e realiza a iteração do último até o primeiro
    number_of_days = Time.days_in_month(month, year)
    day = Date.new(year, month, number_of_days)
    number_of_days.times do
      valor = program_score_value(year, month, number_of_days)
      # Criar metodo para verificar se é útil e retornar valor
      if day.saturday? || day.sunday?
        valor = 0
      end
      @hash_dias[number_of_days] = valor
      # Instanciar day com a data anterior a data iterada
      number_of_days -= 1
      break if number_of_days.zero?
      day = Date.new(year, month, number_of_days)
    end
    @hash_dias
  end
  # Utilizado para calcular valores da meta

  def sum_score(year, month)
    create_hash_dias(year, month)
    @hash_dias.values.reduce(:+).round(2)
  end

  HASH_PONTO_POR_PROGRAMA = {
    'CEAB' => 4.27,
    'PGRP' => 4.48,
    'CEAP' => 5.55
  }

  def program_score_value(year, month, day)
    date = Date.new(year, month, day)
    @current_work_period = WorkPeriod.where('start_date <= ? AND end_date >= ?', date, date).first
    # Verifica se a data está dentro de alguma licença
    @current_license = License.where('start_date <= ? AND end_date >= ?', date, date)
    programa = @current_work_period.program
     @valor = 0
    if @current_license == []
      @valor = HASH_PONTO_POR_PROGRAMA[programa]
    end
    return @valor
  end

end
