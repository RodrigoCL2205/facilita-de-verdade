class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    import_resumo
    resumo_head
    resumo_titular
    resumo_dados_beneficio
  end

  private

  def import_resumo
    @resumo = ""
    if params[:query].present?
      @resumo = params[:query][:resumo]
    end
  end

  def resumo_head
    @data_emissao_resumo = @resumo.match(/(?<=I.N.S.S. INSTITUTO NACIONAL DO SEGURO SOCIAL DATA:).*(?=\r)/).to_s
    @beneficio = @resumo.match(/(?<=BENEFICIO: ).*(?= ESPECIE)/)
    @especie = @resumo.match(/(?<=ESPECIE: ).*(?= TRATAMENTO)/)
    @tratamento = @resumo.match(/(?<=TRATAMENTO : ).*(?= DER:)/)
    @der = @resumo.match(/(?<=DER: ).*(?= DRD:)/)
    @drd = @resumo.match(/(?<=DRD: ).*(?=\r\n)/)
    @orgao_concessor = @resumo.match(/(?<=ORGAO CONCESSOR : ).*(?= ORGAO MANTENEDOR :)/)
    @orgao_mantenedor = @resumo.match(/(?<=ORGAO MANTENEDOR : ).*(?= ORGAO PAGADOR)/)
    @despacho = @resumo.match(/(?<=DESPACHO : ).*(?= MOTIVO)/)
    @motivo = @resumo.match(/(?<=MOTIVO : ).*(?=\r\n)/)
    @motivo1 = @resumo.match(/(?<=MOTIVO 1 :).*(?=\r\n)/)
    @motivo2 = @resumo.match(/(?<=MOTIVO 2 :).*(?=\r\n)/)
  end

  def resumo_titular
    @nome = @resumo.match(/(?<=NOME : ).*(?= SEXO)/)
    @sexo = @resumo.match(/(?<=SEXO : ).*(?= DATA NASCIMENTO)/)
    @data_nascimento = @resumo.match(/(?<=DATA NASCIMENTO :).*(?=\r\n)/)
    @nit = @resumo.match(/(?<=NIT : ).*(?= C.P.F. :)/)
    @cpf = @resumo.match(/(?<=C.P.F. : ).*(?=\r\n)/)
    @nome_mae = @resumo.match(/(?<=NOME MAE : ).*(?=\r\n)/)
  end

  def resumo_dados_beneficio
    @ra = @resumo.match(/(?<=R. A. :).*(?= F. F. :)/)
    @ff = @resumo.match(/(?<=F. F. :).*(?= D.I.B. :)/)
    @dib = @resumo.match(/(?<=D.I.B. :).*(?= D.I.P. :)/)
    @dip = @resumo.match(/(?<=D.I.P. : ).*(?= L.T. :)/)
    @datdd = @resumo.match(/(?<=DAT\/DD : ).*(?= DATA LICENCA. :)/)
    @data_licenca = @resumo.match(/(?<=DATA LICENCA. :).*(?= TIPO LICENCA : )/)
    @tipo_licenca = @resumo.match(/(?<=TIPO LICENCA :).*(?= CODIGO ACIDENTE)/)
    @dodr = @resumo.match(/(?<=D.O. \/ D.R. :).*(?= CODIGO ACIDENTE)/)
    @tempo_beneficio = @resumo.match(/(?<=Tempo de servico na D.E.R).*(?= Tempo de servico em)/)
    @dados_beneficio = @resumo.match(/(?<=DADOS DO BENEFICIO)(.|\n)*(?= DADOS DO OBITO DO SEGURADO)/)
    @dados_dependentes = @resumo.match(/(?<=DEPENDENTES)(.|\n)*(?= DADOS DA CERTIDAO DOS DEPENDENTES)/)
  end
end
