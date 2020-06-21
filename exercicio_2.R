library(tidyverse)
library(poliscidata)
# Suponha que tenhamos o dataframe df abaixo
#
# x     y
# A     5
# A     3
# B     8
# B    12
#
# Complete o código que obtém o seguinte resultado:
#
#        z
#        7
#

df %>%
summarise(z = mean(y))

#######################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# y1    y2    y3    y4
# 8.04  9.14  7.46  6.58
# 6.95  8.14  6.77  5.76
# 7.58  8.74  12.74 7.71
#
# Complete o código que obtém o seguinte resultado:
#
# y1    
# 8.04  
# 6.95  
# 7.58  


df %>%
select(y1)
  
#######################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#    x  y
#   1  10
#   6  8
#   2  3
#   4  5
#
# Complete o código que obtém o seguinte resultado, fazendo uma operação
# entre x e y
#
#    x  y   z
#   1  10  -9
#   6  8   -2
#   2  3   -1
#   4  5   -1
#


df %>%
transmute (x,y,z = x - y)

########################################################################

#
# Suponha que tenhamos o dataframe df abaixo
#
#    city sales
# Boston   220
# Boston   125
#    NYC   150
#    NYC   250
#
# Complete o código que obtém o seguinte resultado:
#
# city   avg_sales
# Boston      172
# NYC         200 


df %>%
  group_by (city) %>%
  summarise(avg_sales = mean(sales))
  
########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#week   min   max
#  3    55    60
#  2    52    56
#  1    60    63
#  4    65    67
#
# Complete o código que obtém o seguinte resultado:
#
#week   min   max
#  1    60    63
#  2    52    56
#  3    55    60
#  4    65    67

df %>%
  arrange (week)

########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# x_b_1  x_b_2  y_c_1  y_c_2
#  A      2      W1     25
#  A      4      W2     21
#  B      6      W1     26
#  B      8      W2     30
#
# Complete o código que obtém o seguinte resultado:
#
# y_c_1  y_c_2
#  W1     25
#  W2     21
#  W1     26
#  W2     30

df %>%
select(starts_with("y"))

#########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
# Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
# 78           6.7         3.0          5.0         1.7 versicolor
# 121          6.9         3.2          5.7         2.3  virginica
# 11           5.4         3.7          1.5         0.2     setosa
# 92           6.1         3.0          4.6         1.4 versicolor
# 146          6.7         3.0          5.2         2.3  virginica
# 62           5.9         3.0          4.2         1.5 versicolor
# 50           5.0         3.3          1.4         0.2     setosa
# 17           5.4         3.9          1.3         0.4     setosa
# 69           6.2         2.2          4.5         1.5 versicolor
# 143          5.8         2.7          5.1         1.9  virginica
#
# Complete o código que obtém o seguinte resultado:
#
#Species      Sepal.Area
#versicolor      20.10
#virginica       22.08
#setosa          19.98
#versicolor      18.30
#virginica       20.10
#versicolor      17.70
#setosa          16.50
#setosa          21.06
#versicolor      13.64
#virginica      15.66


df %>%
  transmute(Species, Sepal.Area = Sepal.Length*Sepal.Width)

########################################################################

# Suponha que tenhamos o dataframe df abaixo
#
#name         start       end         party     
#Eisenhower   1953-01-20  1961-01-20  Republican
#Kennedy      1961-01-20  1963-11-22  Democratic
#Johnson      1963-11-22  1969-01-20  Democratic
#Nixon        1969-01-20  1974-08-09  Republican
#Ford         1974-08-09  1977-01-20  Republican
#Carter       1977-01-20  1981-01-20  Democratic
#Reagan       1981-01-20  1989-01-20  Republican
#Bush         1989-01-20  1993-01-20  Republican
#Clinton      1993-01-20  2001-01-20  Democratic
#Bush         2001-01-20  2009-01-20  Republican
#Obama        2009-01-20  2017-01-20  Democratic
#
#Crie um código abaixo para que se altere a variável party
#deixando apenas a primeira letra dos partidos

df %>%
  mutate(party = recode(party, Republican = "R", Democratic = "D"))

###############################################################################

# No pacote poliscidata existe um banco de dados chamado nes, com informações 
# do American National Election Survey. Para os exerícicios a seguir, instale 
# o pacote poliscidata e tidyverse, carregue-os e crie um objeto chamado
# df com os dados do nes. 

install.packages ("tidyverse")
library (tidyverse)
install.packages("poliscidata")
library(poliscidata)

df <- nes

# Faça uma primeira exploração do banco de dados com todos os comandos
# passados até aqui que possuem esse objetivo

head(df)
tail (df)
str (df)
summary(df)
glimpse (df)

# Quantos respondentes possui na pesquisa? 

#5916


# Caso queiram ter mais informações sobre as variáveis do nes, basta rodar
# o código `?nes`, que no canto inferior direito aparecerá uma descrição.
# Como temos muitas variáveis, deixe apenas as colunas
# ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote
# income5, gender.

?nes

banco_selecionado <- df %>%
  select(ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote,
        income5, gender)
  
  glimpse(banco_selecionado)


# Se quisermos ter informações apenas de pessoas que votaram na
# eleição de 2012, podemos usar a variável voted2012. Tire do banco
# os respondentes que não votaram


banco_filtrado <- banco_selecionado %>%
  filter(voted2012 == "Voted")
  
glimpse (banco_filtrado) 
  
# Quantos respondentes sobraram?
# 4404


# Crie uma variável chamada white que indica se o respondente é branco
# ou não a partir da variável dem_raceeth, crie a variável ideology a
# partir da variável ftgr_cons (0-33 como liberal, 34 a 66 como centro,
# e 67 a 100 como conservador), ao mesmo tempo em que muda
# a variável obama_vote para trocar o 1 por "Sim" e 2 por "não"

banco_adicionado <- banco_selecionado %>%
  mutate(White = (dem_raceeth == "1. White non-Hispanic"))%>%
  mutate(ideology = case_when(ftgr_cons <= 33 ~ "liberal",
                              ftgr_cons >= 34 & ftgr_cons <= 66 ~ "centro",
                              ftgr_cons >= 67 & ftgr_cons <= 100 ~ "conservador")
         )%>%
  mutate(obama_vote = case_when(obama_vote == 0 ~ "Não", 
                                obama_vote == 1 ~ "Sim"))

         
glimpse(banco_adicionado)


# Demonstre como observar a quantidade de pessoas em cada uma das
# categorias de science_use

df %>%
  count(science_use)

# Demonstre como observar a média de conservadorismo (variável 
# ftgr_cons) para cada categoria de science_use

df %>%
  group_by(science_use)%>%
  summarise(media_cons = mean(ftgr_cons, na.rm = TRUE))

###############################################################################

# Responder as questões teóricas da aula abaixo

#Infelizmente, não encontrei estudos na área de Ciência Política que analisem o 
#tema de meu projeto. Portanto, para responder o exercício tomei por base dois 
#estudos. O primeiro na área de Ciência Sociais é uma dissertação de Mestrado da
#Faculdade UFSCAR de Cristina Maria de Castro intitulada: Poder Judiciário 
#Paulista: imagem e competição por poder simbólico retratadas na mídia". E o 
#segundo, um artigo na área de Comunicação publicada na Intercom por cinco 
#autores da UFBA, intitulado: "Mediatização da Política no Brasil: algumas pistas 
#sobre a circulação discursiva do caso #VazaJato". Para fins de organização as 
#respostas sobre o primeiro estudo estarão precedidas de (1) e as respostas 
#concernentes ao segundo estudo por (2).

#Selecione o principal artigo do campo de estudos relacionado ao seu trabalho e 
#responda as seguintes questões: 

#  1 - Qual é a questão da pesquisa?

#  (1) Duas hipóteses norteiam a pesquisa: i) a ideia de que a magistratura 
#estaria conseguindo levar eficazmente à opinião pública, seu argumento de defesa 
#da autonomia da instituição e, ii) de que alguns (não todos, obviamente) 
#conflitos entre o Legislativo e o Judiciário têm início em ações provenientes 
#do campo dos profissionais do Direito, devido às competições internas a este 
#universo, visando a manutenção ou ampliação do poder profissional simbólico.

#(2) O artigo busca entender como os dispositivos de enunciação circulam na 
#internet e deixam pistas sobre a interação entre os campos sociais. Ou seja, 
#busca identificar a relação entre os circuitos discursivos e os campos sociais,
#a fim de entender as tensões entre o jornalismo, o judiciário e a política no 
#caso #VazaJato.

#  2 - Qual é a teoria? 

#  (1) O argumento da autora parte da visão de Bourdieu de que as profissões 
#possuem poder simbólico reconhecido pela sociedade e influente nesta. Parte 
#deste poder é disputado e ganho na mídia e, no caso da magistratura, é possível
#detectar três níveis fundamentais nos quais ocorre esta disputa: i) a 
#magistratura entra em conflito com o Ministério Público, com jornalistas e 
#advogados que visam enfraquecer seu poder e restringir sua jurisdição; ii) a 
#disputa por poder simbólico encontra-se dentro da própria profissão e, iii) há 
#aquele onde a magistratura vivencia tensões com os outros poderes, o 
#Legislativo e o Executivo. 

#  (2) O objeto empírico do artigo é o caso do #VazaJato e os diálogos 
#divulgados pelo The Intercept que segundo os autores evidencia um conjunto de 
#questões para se pensar o fenômeno da mediatização e da circulação discursiva, 
#sobretudo quando se trata de analisar um discurso em movimento. Em primeiro 
#lugar, os autores ressaltam a implicação do jornalismo nos temas debatidos pela
#sociedade e, neste caso, no que toca à agenda política, jurídica e governamental. 
#Em segundo, destacam as configurações discursivas que as novas possibilidades 
#de acesso e compartilhamento de informação podem evidenciar na trama 
#interdiscursiva, que é tecida no ambiente digital. E por fim, apontam para o 
#desafio teórico metodológico de identificar e testar operadores de análise das 
#zonas de pregnância, bem como dos circuitos possíveis, desta complexa relação 
#situada entre a produção e o reconhecimento.

#   3 - Qual é o desenho de pesquisa? 

#  (1) A análise da luta da magistratura por poder simbólico nos três níveis 
#acima citados se fez através da análise dos artigos dos Jornais Folha de S. 
#Paulo e O Estado de S. Paulo, a partir do ano de 1988, data da implementação da
#nova Consituição e de um novo contexto caracterizado por maiores atribuições 
#dadas ao Ministério Público e por um aumento à críticas à autonomia do Poder 
#Judiciário.

#  (2) O desenho de pesquisa foi construído por tweets e matérias que circularam
#na internet sobre o caso "VazaJato", quando o jornal The Intercept publicou 
#diálogos entre o juiz e atual ministro da Justiça Sérgio Moro e o Procurador 
#Geral da República Deltan Dallagnol, sobre a Operação Lava jato. Com o uso de 
#análise qualitativa das matérias selecionadas como "principais notícias" do 
#Google, com uma coleta manual, e quantitativa no Twitter, com análise 
#automática pelo Phyton. Para a análise automatizada os autores contaram com a 
#ajuda de um colaborador especialista na área de linguagem de programação. No 
#Google, a busca foi orientada pelas palavras-chaves: Moro, vazamentos, Intercept,
#VazaJato e Greenwald, durante o período de 11 a 14 de março 10. E o conteúdo 
#das notícias foi sintetizado a partir de títulos, subtítulos, principais temas,
#palavras-chave e enquadramento, para depois aplicar a análise do discurso.

#   4	- Como o artigo se sai nos 4 quesitos de avaliação de causalidade? 

#  (1) A autora pode cumprir com a primeira avaliação de causalidade, pois 
#existe credibilidade na concepção de que a capacidade de influenciar na opinião 
#pública é vital para a profissão conquistar e manter seu poder simbólico, 
#quando ela lida com um problema que está politizado na mídia, como é o caso da 
#Justiça.
#No entanto, a possibilidade de que o poder simbólico da profissão da 
#magistratura causar a capacidade de influenciar a mídia não pode ser eliminada,
#visto que tal profissão trata de assuntos politizados na mídia, como a Justiça. 
#A covariação entre poder simbólico do magistrado e a aprovação pela opinião 
#pública é verdadeira. Pois, é possível entender que no caso da opinião pública 
#desaprovar das ações do magistrado o poder simbólico da profissão resta 
#enfraquecido.
#No caso de possível variável Z que afete a causalidade entre X e Y, como o que
#é analisado é o poder simbólico conquistado pelo capital social, além da 
#opinião pública pela influencia na mídia, o contexto histórico sociológico da 
#profissão de magistrado poderia afetar a relação causal das variáveis, porém a 
#meu entender não tornando-a espúria, mas no sentido de reforçar a relação 
#causal entre influencia na mídia e poder simbólico da profissão. 

#  (2) O artigo cumpre com a primeira avaliação de causalidade entre as variáveis
#por existir intrínseca relação entre os dispositivos de enunciação que circulam
#na internet e os campos sociais, já que o primeiro se desenvolve e multiplica a
#partir do segundo numa relação de retroalimentação.
#A segunda avaliação de causalidade, no entanto, é negativa. Pois não se pode 
#eliminar o fato que o campo social influencia a circulação de enunciação na 
#internet. Entretanto, para o objeto empírico analisado (caso #Vazajato) os 
#autores identificaram que a circulação da notícia gerou tensões em diversas 
#instituições no campo social.
#A covariação da terceira avaliação é clara. Pois como dito acima existe uma 
#relação de retroalimentação de ambas as variáveis analisadas.
#Por fim, sobre o controle de possível variável Z para a quarta avaliação se tem
#que a circulação da notícia gerou as tensões entre instituições no campo social. 
#Apesar do julgamento de Lula ser permeado de polarização ideológica, é possível 
#visualizar que as tensões geradas para o judiciário, para o jornalismo e para a
#política tenderiam desvanecer sem a divulgação das mensagens trocadas entre Moro 
#e Dellagnol adquiridas por fonte anônima pelo Intercept. 

#   5	- O que ele conclui? 

#  (1) Na análise dos jornais Folha de S. Paulo e O Estado de S. Paulo, a autora
#conclui que o segundo favorece, e muito, o Judiciário em sua busca por poder 
#simbólico, uma vez que faz grande cobertura dos interesses e pontos de vista 
#dos Juízes, contribuindo, portanto, com sua luta em conquistar a credibilidade 
#da opinião pública e, consequentemente, o apoio necessário à manutenção de sua 
#jurisdição profissional, da autonomia do Judiciário enquanto poder e de seu 
#prestígio, tão ameaçados no período pós- Carta de 1988. A Folha, por sua vez, 
#não se compromete com o Judiciário. Da mesma forma não se esforça em para lhe 
#conferir credibilidade, também não extrapola o número de críticas em relação ao 
#número de defesas.

#  (2) Os autores concluíram que "a mediatização, revelou um tensionamento entre
#diferentes instituições e campos sociais, especialmente a política, o Judiciário 
#e o Jornalismo, reafirmando a perspectiva da circulação transversal. O furo 
#jornalístico do The Intercept Brasil modificou protocolos e pautou a agenda 
#jurídica, ao criar um acontecimento político que ganhou visibilidade nas mídias
#nacionais e internacionais, deslocou o foco dos grandes veículos de comunicação,
#deu novos elementos à polarização política que se estabeleceu no país desde o 
#impeachment de Dilma Rousseff e suas consequências na eleição de 2018, além de 
#reposicionar o debate sobre Jornalismo, verdade, democracia e justiça no âmbito
#da esfera pública."
#Além apontarem para "o desafio de analisar um discurso em movimento que, além 
#de ser atualizado constantemente, cria boatos e contra-boatos, gerando tensões 
#características de crise. Neste sentido, seguimos acreditando que o campo de 
#pesquisa deve se debruçar no desenvolvimento de múltiplas ferramentas de análise
#, com o objetivo de construir operadores teórico-metodológicos à altura da 
#acelerada complexificação dos processos de circulação discursiva e semiose 
#social na sociedade mediatizada."

#   6 - Como a sua pesquisa dá um passo a mais para o desenvolvimento teórico 
#presente neste artigo?

#  (1) Este estudo proporciona o arcabouço bibliográfico conceitual para se 
#pensar a relevância da opinião pública e influência da mídia com fins de 
#manutenção e ampliação da credibilidade e valor simbólico dos magistrados como 
#representantes do Poder Judiciário. Além de apresentar métodos qualitativos e 
#quantitativos para a análise empírica do objeto de pesquisa determinado.

#(2) O artigo analisado aponta para sérios desafios na coleta de dados 
#quantitativos para pesquisa sobre mídia no âmbito digital e o discurso em 
#movimento. Além da influência de algoritmos para coleta manual de tais dados. 
#O que pode afetar na escolha do objeto empírico de pesquisa. 
#O arcabouço conceitual para a pesquisa é fortalecido pelas bibliografias 
#tradicionais sobre os estudos da mídia e de opinião pública. No entanto, devido
#a contemporaneidade dos estudos sobre as lógicas digitais políticas se mostra 
#necessário o uso de metodologias que avancem na compreensão qualitativa dos 
#recentes parâmetros midiáticos.

#   Elabore qual é a pergunta da sua pesquisa em apenas uma frase.

#O Poder Judiciário se usa da mídia para criar imagem de credibilidade e apoio 
#social à suas decisões, enquanto a mídia independente e alternativa tende a 
#mostrar as manobras subversivas da justiça.

#   Pense no seu trabalho e avalie em que medida ele passa pelas 4 avaliações de
#relação causal, e quais problemas ele pode ter em cada uma delas.

#Logo na primeira avaliação a hipótese é refutável, já que o Poder Judiciário 
#não necessita do apoio popular para fazer valer suas decisões. No entanto, desde
#a perspectiva de Bourdieu, o padrão de credibilidade como construção de capital 
#social e valor simbólico é possível identificar a relação de causalidade entre 
#a credibilidade do Poder Judiciário e a mídia tradicional. Enquanto, a mídia 
#independente surge como ator de contra-poder que pode ou não, a depender da 
#análise empírica, gerar efeitos de accountability no campo social.

#A segunda avaliação parece também ser fraca, pois os magistrados também como 
#cidadãos comuns podem ser influenciados pelo conteúdo informativo e midiático 
#que consomem, apesar de seu dever de imparcialidade.

#É possível visualizar a covariação entre as atividades judiciárias e os 
#discursos midiáticos tanto tradicionais quanto independentes, principalmente 
#quando as decisões concernem a pessoas de interesse.

#A possibilidade de uma variável Z enfraquecer a relação causal das variáveis 
#não é irrefutável, mas aparentemente difícil de se identificar. Visto que a 
#existência de uma arena oculta que influencie na performance das variáveis é 
#possível, mas não visível ou mensurável.

#FIM                   
                                                                                                                                                                                                              