class RequerimentsController < ApplicationController

  def index
    @requeriment = Requeriment.all
    import_query_requerimento

    @protocolo = @query_requerimento.match(/(?<=PROTOCOLO DE REQUERIMENTO)(.|\n)*(?=Data de entrada:)/)
    @der = @query_requerimento.match(/(?<=Data de entrada:)(.|\n)*(?=- Central de Serviços)/)
    @interessado = @query_requerimento.match(/(?<=Nome Completo da Mãe)(.|\n)*(?=Procuradores)/).to_s
    @cpf = @interessado.match(/\d{3}.\d{3}.\d{3}-\d{2}/)
    @data_nascimento = @interessado.match(/\d{2}\/\d{2}\/\d{4}/)
    @nome = @interessado.match(/(?<=\d{3}.\d{3}.\d{3}-\d{2})(.|\n)*(?=\d{2}\/\d{2}\/\d{4})/)
    @nome_mae = @interessado.match(/(?<=\d{2}\/\d{2}\/\d{4})(.|\n)*/)
  end

  private

  def import_query_requerimento
    @query_requerimento = ""
    if params[:query].present?
      @query_requerimento = params[:query][:requerimento]
    end
  end
end
