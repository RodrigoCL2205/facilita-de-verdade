class ScoresController < ApplicationController
  before_action :set_score, only: [:edit, :update, :destroy]

  def new
    @score = Score.new
    authorize @score
  end

  def create
      @score = Score.new
      @requeriment = Requeriment.find(params[:score][:requeriment])
      @score.requeriment = @requeriment
      @score.work_period = WorkPeriod.where(user: current_user).first
      @score.status = params[:score][:status]
      @score.date = Date.today
      find_value_of_score
      authorize @score
      if score_for_current_user
        redirect_to requeriment_path(@requeriment), alert: "Ponto não foi migrado para o controle da meta.
        O requerimento com o protocolo #{@requeriment.protocol} já possui ponto somado para o status #{@score.status}."
      else
        if @score.save
          redirect_to requeriment_path(@requeriment), notice: "Ponto migrado para o controle da meta."
        else
          redirect_to requeriment_path(@requeriment), alert: "Erro ao criar ponto no controle da meta."
        end
      end
  end

  def edit
  end

  def update
    date = params[:score][:date]
    @score.update(date: date)
    redirect_to requeriment_path(@requeriment), notice: "Data alterada com sucesso."
  end

  def destroy
    @score.destroy
    redirect_to requeriment_path(@requeriment), notice: "Pontuação retirada do controle da meta."
  end

  private

  def set_score
    @score = Score.find(params[:id])
    @requeriment = @score.requeriment
    authorize @score
  end

  def score_params
    params.require(:score).permit(:requeriment, :servico, :status, :score, :date, :work_period)
  end

  def find_value_of_score
    @score_for_service = ScoreForService.where(servico: @requeriment.servico).first
    case @score.status
    when 'conclusao'
      @score.score = @score_for_service.conclusao
      @requeriment.update(status: "Concluida")
    when 'exigencia'
      @score.score = @score_for_service.exigencia
      @requeriment.update(status: "Exigência")
    when 'subtarefa'
      @score.score = @score_for_service.subtarefa
    else
      redirect_to requeriment_path(@requeriment), alert: "Erro ao criar ponto no controle da meta."
    end
  end

  def score_for_current_user
    Score.exists?(requeriment: @score.requeriment, servico: @score.servico, status: @score.status) || Score.exists?(requeriment: @score.requeriment, servico: @score.servico, status: 'conclusao')
  end
end
