# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Cleaning all Rural Document Types!"
RuralDocumentType.destroy_all
puts "All Rural Document Types destroyed!"

documentos_rurais = ["Blocos de notas do produtor rural",
                    "Carteira de vacinação",
                    "Certidão batismo dos filhos",
                    "Certidão de casamento civil",
                    "Certidão de casamento no religioso",
                    "Certidão de curatela",
                    "Certidão de nascimento dos Filhos",
                    "Certidão de tutela",
                    "Certificado de alistamento ou de quitação com o serviço militar",
                    "Comprovante de empréstimo bancário para fins de atividade rural",
                    "Comprovante de matrícula ou ficha de inscrição em escola, ata ou boletim escolar do trabalhador ou dos filhos",
                    "Comprovante de participação como beneficiário em programas governamentais para a área rural nos estado, no distrito federal ou nos municípios",
                    "Comprovante de recebimento de assistência ou de acompanhamento de empresa de assistência técnica e extensão rural",
                    "Comprovantes de recolhimento de contribuição à Previdência Social, decorrentes da comercialização da produção",
                    "Contribuição social ao sindicato de trabalhadores rurais, à colônia ou à associação de pescadores, produtores rurais ou a outra entidade congênere",
                    "Cópia da declaração de imposto de renda, com indicação de renda proveniente da comercialização de produção rural",
                    "Cópia de ficha de atendimento médico ou odontológico",
                    "Declaração de Aptidão ao Programa Nacional de Fortalecimento da Agricultura Familiar – DAP",
                    "Declaração de aptidão fornecida pelo sindicato dos trabalhadores rurais para fins de obtenção de financiamento junto ao PRONAF",
                    "Declaração firmada por autoridades administrativas ou judiciárias locais",
                    "Declaração fundamentada de sindicato que represente os trabalhadores rurais, inclusive os agricultores familiares ou de colônia de pescadores artesanais",
                    "Documentos fiscais relativos à entrega de produção rural à cooperativa agrícola, entreposto de pescado ou outros, com indicação do segurado como vendedor ou consignante",
                    "Escritura pública de imóvel",
                    "Ficha de associado em cooperativa",
                    "Ficha de inscrição ou registro sindical ou associativo junto ao sindicato de trabalhadores rurais, colônia ou associação de pescadores, produtores ou outras entidades congêneres",
                    "Ficha ou registro em livros de casas de saúde, hospitais, postos de saúde ou do programa dos agentes comunitários de saúde",
                    "Notas fiscais de entrada de mercadorias, de que trata o § 24 do art. 225 do RPS, emitidas pela empresa adquirente da produção, com indicação do nome do segurado como vendedor",
                    "Procuração",
                    "Publicação na imprensa ou em informativos de circulação pública",
                    "Recibo de compra de implementos ou de insumos agrícolas",
                    "Recibo de pagamento de contribuição federativa ou confederativa",
                    "Registro em documentos de associações de produtores rurais, comunitárias, recreativas, desportivas ou religiosas",
                    "Registro em livros de entidades religiosas, quando da participação em batismo, crisma, casamento ou em outros sacramentos",
                    "Registro em processos administrativos ou judiciais, inclusive inquéritos, como testemunha, autor ou réu",
                    "Título de aforamento",
                    "Título de eleitor ou ficha de cadastro eleitoral",
                    "Título de propriedade de imóvel rural",
                    "Outros documentos que comprovem atividade segurado especial"]

puts "Creating Rural Document Types."
documentos_rurais.each do |element|
  puts "Creating new RuralDocumentType"
  document = RuralDocumentType.new(document: element)
  document.save!
  puts "Created RuralDocumentType id: #{document.id}."
end
puts "Finished Creation."
