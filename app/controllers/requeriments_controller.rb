class RequerimentsController < ApplicationController
  before_action :set_requeriment, only: [:show, :edit, :update, :destroy]

  def index
    @requeriments = policy_scope(Requeriment).order(created_at: :desc)

  end

  def show
    @requeriment = Requeriment.find(params[:id])
    @score = Score.new
    has_some_scores?

  end

  def new
    @requeriment = Requeriment.new
    import_query_requerimento
    import_names_collection
    authorize @requeriment
  end

  def create
    # Se já existe requerimento com o número de procolo informado, não irá criar novo requerimento
    # e será redirecionado para o 'show' do protocolo informado.
    if Requeriment.exists?(protocol: params[:requeriment][:protocol], user: current_user)
      @requeriment = Requeriment.where(protocol: params[:requeriment][:protocol]).first
      authorize @requeriment
      redirect_to requeriment_path(@requeriment), alert: "Requerimento não foi criado.
        O protocolo informado já possui cadastro."
    else
      # Protocolo informado não possui cadastro pelo current_user
      @requeriment = Requeriment.new(requeriment_params)
      create_or_find_insured # Método para verificar se já existe o segurado
      @requeriment.insured = @insured
      @requeriment.user = current_user
      authorize @requeriment
      if @requeriment.save
        redirect_to requeriment_path(@requeriment), notice: "Requerimento criado com sucesso."
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @requeriment.destroy
    redirect_to requeriments_path, notice: "Requerimento foi deletado."
  end

  private

  def set_requeriment
    @requeriment = Requeriment.find(params[:id])
    authorize @requeriment
  end

  def requeriment_params
    params.require(:requeriment).permit(:protocol, :der, :status, :servico)
  end

  def insured_params
    params.require(:requeriment).permit(:name, :cpf, :mothers_name, :birth_date)
  end

  def create_or_find_insured
    if Insured.where(cpf: params[:requeriment][:cpf]) == []
      @insured = Insured.new(insured_params)
      @insured.save
    else
      @insured = Insured.where(cpf: params[:requeriment][:cpf]).first
    end
    @insured
  end

  def import_query_requerimento
    @query_requerimento = ""
    if params[:query].present?
      @query_requerimento = params[:query][:requerimento]
      @protocolo = @query_requerimento.match(/(?<=PROTOCOLO DE REQUERIMENTO)(.|\n)*(?=Data de entrada:)/)
      @der = @query_requerimento.match(/(?<=Data de entrada:)(.|\n)*(?= - )/)

      # Isolamento dos campos do interessado para realizar as buscas do @nome, @cpf, @data_nascimento e @nome_mae
      @interessado = @query_requerimento.match(/(?<=Nome Completo da Mãe)(.|\n)*(?=Procuradores)/).to_s

      # Requerimentos antigos possui a palavra "Procuradores" depois dos campos "CPF Nome Completo Data Nascimento Nome Completo da Mãe"
      if @interessado.include?("CPF Nome Completo Data Nascimento Nome Completo da Mãe")
        @interessado.delete_suffix!("CPF Nome Completo Data Nascimento Nome Completo da Mãe\r\n")
      end

      @cpf = @interessado.match(/\d{3}.\d{3}.\d{3}-\d{2}/)
      @data_nascimento = @interessado.match(/\d{2}\/\d{2}\/\d{4}/)
      @nome = @interessado.match(/(?<=\d{3}.\d{3}.\d{3}-\d{2})(.|\n)*(?= \d{2}\/\d{2}\/\d{4})/)
      @nome_mae = @interessado.match(/(?<=\d{2}\/\d{2}\/\d{4})(.|\n)*/)

      @servico = @query_requerimento.match(/(?<=Canal de atendimento\r\n).*(?=\n)/)

      @status = @query_requerimento.match(/(Pendente)|(Cancelada)|(Concluída)|(Exigência)/)
    end
  end

  def import_names_collection
    @collection_all_services = ScoreForService.all.order("servico ASC").distinct.pluck(:servico)
    @collection_all_status = ["Pendente", "Exigência", "Concluída", "Cancelada"]
  end

  def has_some_scores?
    # As variáveis @has_conlusao, @has_exigencia e @has_subtarefa são utilizadas
    # para desabilitar os botões de criar score no view requeriments#show
    @scores = @requeriment.scores
    @has_conclusao = @scores.any?{ |score| score.status == 'conclusao' }
    @has_exigencia = @scores.any?{ |score| score.status == 'exigencia' }
    @has_subtarefa = @scores.any?{ |score| score.status == 'subtarefa' }
  end
end
