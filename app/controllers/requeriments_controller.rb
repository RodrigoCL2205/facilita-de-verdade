class RequerimentsController < ApplicationController
  before_action :set_requeriment, only: [:show, :edit, :update, :destroy]

  def index
    @requeriments = policy_scope(Requeriment).order(created_at: :desc)

  end

  def new
    @requeriment = Requeriment.new
    import_query_requerimento
    authorize @requeriment
  end

  def create
    @requeriment = Requeriment.new(requeriment_params)
    @insured = Insured.new(insured_params)
    @insured.save
    @requeriment.insured = @insured
    @requeriment.user = current_user

    authorize @requeriment
    if @requeriment.save
      redirect_to requeriments_path, notice: "Requerimento criado com sucesso."
    else
      render :new
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

  def import_query_requerimento
    @query_requerimento = ""
    if params[:query].present?
      @query_requerimento = params[:query][:requerimento]
      @protocolo = @query_requerimento.match(/(?<=PROTOCOLO DE REQUERIMENTO)(.|\n)*(?=Data de entrada:)/)
      @der = @query_requerimento.match(/(?<=Data de entrada:)(.|\n)*(?= - )/)
      @interessado = @query_requerimento.match(/(?<=Nome Completo da Mãe)(.|\n)*(?=Procuradores)/).to_s

      # Requerimentos antigos possui a palavra "Procuradores" depois dos campos "CPF Nome Completo Data Nascimento Nome Completo da Mãe"
      if @interessado.include?("CPF Nome Completo Data Nascimento Nome Completo da Mãe")
        @interessado.delete_suffix!("CPF Nome Completo Data Nascimento Nome Completo da Mãe\r\n")
      end

      @cpf = @interessado.match(/\d{3}.\d{3}.\d{3}-\d{2}/)
      @data_nascimento = @interessado.match(/\d{2}\/\d{2}\/\d{4}/)
      @nome = @interessado.match(/(?<=\d{3}.\d{3}.\d{3}-\d{2})(.|\n)*(?= \d{2}\/\d{2}\/\d{4})/)
      @nome_mae = @interessado.match(/(?<=\d{2}\/\d{2}\/\d{4})(.|\n)*/)

      @servico = @query_requerimento.match(/(?<=Canal de atendimento\r\n)(.|\n)*(?=\r\nAGÊNCIA)/)
      @status = @query_requerimento.match(/(Pendente)|(Cancelada)|(Concluída)|(Exigência)/)
    end
  end
end
