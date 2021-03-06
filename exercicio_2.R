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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado, fazendo uma opera��o
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
# Complete o c�digo que obt�m o seguinte resultado:
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
#Crie um c�digo abaixo para que se altere a vari�vel party
#deixando apenas a primeira letra dos partidos

df %>%
  mutate(party = recode(party, Republican = "R", Democratic = "D"))

###############################################################################

# No pacote poliscidata existe um banco de dados chamado nes, com informa��es 
# do American National Election Survey. Para os exer�cicios a seguir, instale 
# o pacote poliscidata e tidyverse, carregue-os e crie um objeto chamado
# df com os dados do nes. 

install.packages ("tidyverse")
library (tidyverse)
install.packages("poliscidata")
library(poliscidata)

df <- nes

# Fa�a uma primeira explora��o do banco de dados com todos os comandos
# passados at� aqui que possuem esse objetivo

head(df)
tail (df)
str (df)
summary(df)
glimpse (df)

# Quantos respondentes possui na pesquisa? 

#5916


# Caso queiram ter mais informa��es sobre as vari�veis do nes, basta rodar
# o c�digo `?nes`, que no canto inferior direito aparecer� uma descri��o.
# Como temos muitas vari�veis, deixe apenas as colunas
# ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote
# income5, gender.

?nes

banco_selecionado <- df %>%
  select(ftgr_cons, dem_raceeth, voted2012, science_use, preknow3, obama_vote,
        income5, gender)
  
  glimpse(banco_selecionado)


# Se quisermos ter informa��es apenas de pessoas que votaram na
# elei��o de 2012, podemos usar a vari�vel voted2012. Tire do banco
# os respondentes que n�o votaram


banco_filtrado <- banco_selecionado %>%
  filter(voted2012 == "Voted")
  
glimpse (banco_filtrado) 
  
# Quantos respondentes sobraram?
# 4404


# Crie uma vari�vel chamada white que indica se o respondente � branco
# ou n�o a partir da vari�vel dem_raceeth, crie a vari�vel ideology a
# partir da vari�vel ftgr_cons (0-33 como liberal, 34 a 66 como centro,
# e 67 a 100 como conservador), ao mesmo tempo em que muda
# a vari�vel obama_vote para trocar o 1 por "Sim" e 2 por "n�o"

banco_adicionado <- banco_selecionado %>%
  mutate(White = (dem_raceeth == "1. White non-Hispanic"))%>%
  mutate(ideology = case_when(ftgr_cons <= 33 ~ "liberal",
                              ftgr_cons >= 34 & ftgr_cons <= 66 ~ "centro",
                              ftgr_cons >= 67 & ftgr_cons <= 100 ~ "conservador")
         )%>%
  mutate(obama_vote = case_when(obama_vote == 0 ~ "N�o", 
                                obama_vote == 1 ~ "Sim"))

         
glimpse(banco_adicionado)


# Demonstre como observar a quantidade de pessoas em cada uma das
# categorias de science_use

df %>%
  count(science_use)

# Demonstre como observar a m�dia de conservadorismo (vari�vel 
# ftgr_cons) para cada categoria de science_use

df %>%
  group_by(science_use)%>%
  summarise(media_cons = mean(ftgr_cons, na.rm = TRUE))

###############################################################################

# Responder as quest�es te�ricas da aula abaixo

#Infelizmente, n�o encontrei estudos na �rea de Ci�ncia Pol�tica que analisem o 
#tema de meu projeto. Portanto, para responder o exerc�cio tomei por base dois 
#estudos. O primeiro na �rea de Ci�ncia Sociais � uma disserta��o de Mestrado da
#Faculdade UFSCAR de Cristina Maria de Castro intitulada: Poder Judici�rio 
#Paulista: imagem e competi��o por poder simb�lico retratadas na m�dia". E o 
#segundo, um artigo na �rea de Comunica��o publicada na Intercom por cinco 
#autores da UFBA, intitulado: "Mediatiza��o da Pol�tica no Brasil: algumas pistas 
#sobre a circula��o discursiva do caso #VazaJato". Para fins de organiza��o as 
#respostas sobre o primeiro estudo estar�o precedidas de (1) e as respostas 
#concernentes ao segundo estudo por (2).

#Selecione o principal artigo do campo de estudos relacionado ao seu trabalho e 
#responda as seguintes quest�es: 

#  1 - Qual � a quest�o da pesquisa?

#  (1) Duas hip�teses norteiam a pesquisa: i) a ideia de que a magistratura 
#estaria conseguindo levar eficazmente � opini�o p�blica, seu argumento de defesa 
#da autonomia da institui��o e, ii) de que alguns (n�o todos, obviamente) 
#conflitos entre o Legislativo e o Judici�rio t�m in�cio em a��es provenientes 
#do campo dos profissionais do Direito, devido �s competi��es internas a este 
#universo, visando a manuten��o ou amplia��o do poder profissional simb�lico.

#(2) O artigo busca entender como os dispositivos de enuncia��o circulam na 
#internet e deixam pistas sobre a intera��o entre os campos sociais. Ou seja, 
#busca identificar a rela��o entre os circuitos discursivos e os campos sociais,
#a fim de entender as tens�es entre o jornalismo, o judici�rio e a pol�tica no 
#caso #VazaJato.

#  2 - Qual � a teoria? 

#  (1) O argumento da autora parte da vis�o de Bourdieu de que as profiss�es 
#possuem poder simb�lico reconhecido pela sociedade e influente nesta. Parte 
#deste poder � disputado e ganho na m�dia e, no caso da magistratura, � poss�vel
#detectar tr�s n�veis fundamentais nos quais ocorre esta disputa: i) a 
#magistratura entra em conflito com o Minist�rio P�blico, com jornalistas e 
#advogados que visam enfraquecer seu poder e restringir sua jurisdi��o; ii) a 
#disputa por poder simb�lico encontra-se dentro da pr�pria profiss�o e, iii) h� 
#aquele onde a magistratura vivencia tens�es com os outros poderes, o 
#Legislativo e o Executivo. 

#  (2) O objeto emp�rico do artigo � o caso do #VazaJato e os di�logos 
#divulgados pelo The Intercept que segundo os autores evidencia um conjunto de 
#quest�es para se pensar o fen�meno da mediatiza��o e da circula��o discursiva, 
#sobretudo quando se trata de analisar um discurso em movimento. Em primeiro 
#lugar, os autores ressaltam a implica��o do jornalismo nos temas debatidos pela
#sociedade e, neste caso, no que toca � agenda pol�tica, jur�dica e governamental. 
#Em segundo, destacam as configura��es discursivas que as novas possibilidades 
#de acesso e compartilhamento de informa��o podem evidenciar na trama 
#interdiscursiva, que � tecida no ambiente digital. E por fim, apontam para o 
#desafio te�rico metodol�gico de identificar e testar operadores de an�lise das 
#zonas de pregn�ncia, bem como dos circuitos poss�veis, desta complexa rela��o 
#situada entre a produ��o e o reconhecimento.

#   3 - Qual � o desenho de pesquisa? 

#  (1) A an�lise da luta da magistratura por poder simb�lico nos tr�s n�veis 
#acima citados se fez atrav�s da an�lise dos artigos dos Jornais Folha de S. 
#Paulo e O Estado de S. Paulo, a partir do ano de 1988, data da implementa��o da
#nova Consitui��o e de um novo contexto caracterizado por maiores atribui��es 
#dadas ao Minist�rio P�blico e por um aumento � cr�ticas � autonomia do Poder 
#Judici�rio.

#  (2) O desenho de pesquisa foi constru�do por tweets e mat�rias que circularam
#na internet sobre o caso "VazaJato", quando o jornal The Intercept publicou 
#di�logos entre o juiz e atual ministro da Justi�a S�rgio Moro e o Procurador 
#Geral da Rep�blica Deltan Dallagnol, sobre a Opera��o Lava jato. Com o uso de 
#an�lise qualitativa das mat�rias selecionadas como "principais not�cias" do 
#Google, com uma coleta manual, e quantitativa no Twitter, com an�lise 
#autom�tica pelo Phyton. Para a an�lise automatizada os autores contaram com a 
#ajuda de um colaborador especialista na �rea de linguagem de programa��o. No 
#Google, a busca foi orientada pelas palavras-chaves: Moro, vazamentos, Intercept,
#VazaJato e Greenwald, durante o per�odo de 11 a 14 de mar�o 10. E o conte�do 
#das not�cias foi sintetizado a partir de t�tulos, subt�tulos, principais temas,
#palavras-chave e enquadramento, para depois aplicar a an�lise do discurso.

#   4	- Como o artigo se sai nos 4 quesitos de avalia��o de causalidade? 

#  (1) A autora pode cumprir com a primeira avalia��o de causalidade, pois 
#existe credibilidade na concep��o de que a capacidade de influenciar na opini�o 
#p�blica � vital para a profiss�o conquistar e manter seu poder simb�lico, 
#quando ela lida com um problema que est� politizado na m�dia, como � o caso da 
#Justi�a.
#No entanto, a possibilidade de que o poder simb�lico da profiss�o da 
#magistratura causar a capacidade de influenciar a m�dia n�o pode ser eliminada,
#visto que tal profiss�o trata de assuntos politizados na m�dia, como a Justi�a. 
#A covaria��o entre poder simb�lico do magistrado e a aprova��o pela opini�o 
#p�blica � verdadeira. Pois, � poss�vel entender que no caso da opini�o p�blica 
#desaprovar das a��es do magistrado o poder simb�lico da profiss�o resta 
#enfraquecido.
#No caso de poss�vel vari�vel Z que afete a causalidade entre X e Y, como o que
#� analisado � o poder simb�lico conquistado pelo capital social, al�m da 
#opini�o p�blica pela influencia na m�dia, o contexto hist�rico sociol�gico da 
#profiss�o de magistrado poderia afetar a rela��o causal das vari�veis, por�m a 
#meu entender n�o tornando-a esp�ria, mas no sentido de refor�ar a rela��o 
#causal entre influencia na m�dia e poder simb�lico da profiss�o. 

#  (2) O artigo cumpre com a primeira avalia��o de causalidade entre as vari�veis
#por existir intr�nseca rela��o entre os dispositivos de enuncia��o que circulam
#na internet e os campos sociais, j� que o primeiro se desenvolve e multiplica a
#partir do segundo numa rela��o de retroalimenta��o.
#A segunda avalia��o de causalidade, no entanto, � negativa. Pois n�o se pode 
#eliminar o fato que o campo social influencia a circula��o de enuncia��o na 
#internet. Entretanto, para o objeto emp�rico analisado (caso #Vazajato) os 
#autores identificaram que a circula��o da not�cia gerou tens�es em diversas 
#institui��es no campo social.
#A covaria��o da terceira avalia��o � clara. Pois como dito acima existe uma 
#rela��o de retroalimenta��o de ambas as vari�veis analisadas.
#Por fim, sobre o controle de poss�vel vari�vel Z para a quarta avalia��o se tem
#que a circula��o da not�cia gerou as tens�es entre institui��es no campo social. 
#Apesar do julgamento de Lula ser permeado de polariza��o ideol�gica, � poss�vel 
#visualizar que as tens�es geradas para o judici�rio, para o jornalismo e para a
#pol�tica tenderiam desvanecer sem a divulga��o das mensagens trocadas entre Moro 
#e Dellagnol adquiridas por fonte an�nima pelo Intercept. 

#   5	- O que ele conclui? 

#  (1) Na an�lise dos jornais Folha de S. Paulo e O Estado de S. Paulo, a autora
#conclui que o segundo favorece, e muito, o Judici�rio em sua busca por poder 
#simb�lico, uma vez que faz grande cobertura dos interesses e pontos de vista 
#dos Ju�zes, contribuindo, portanto, com sua luta em conquistar a credibilidade 
#da opini�o p�blica e, consequentemente, o apoio necess�rio � manuten��o de sua 
#jurisdi��o profissional, da autonomia do Judici�rio enquanto poder e de seu 
#prest�gio, t�o amea�ados no per�odo p�s- Carta de 1988. A Folha, por sua vez, 
#n�o se compromete com o Judici�rio. Da mesma forma n�o se esfor�a em para lhe 
#conferir credibilidade, tamb�m n�o extrapola o n�mero de cr�ticas em rela��o ao 
#n�mero de defesas.

#  (2) Os autores conclu�ram que "a mediatiza��o, revelou um tensionamento entre
#diferentes institui��es e campos sociais, especialmente a pol�tica, o Judici�rio 
#e o Jornalismo, reafirmando a perspectiva da circula��o transversal. O furo 
#jornal�stico do The Intercept Brasil modificou protocolos e pautou a agenda 
#jur�dica, ao criar um acontecimento pol�tico que ganhou visibilidade nas m�dias
#nacionais e internacionais, deslocou o foco dos grandes ve�culos de comunica��o,
#deu novos elementos � polariza��o pol�tica que se estabeleceu no pa�s desde o 
#impeachment de Dilma Rousseff e suas consequ�ncias na elei��o de 2018, al�m de 
#reposicionar o debate sobre Jornalismo, verdade, democracia e justi�a no �mbito
#da esfera p�blica."
#Al�m apontarem para "o desafio de analisar um discurso em movimento que, al�m 
#de ser atualizado constantemente, cria boatos e contra-boatos, gerando tens�es 
#caracter�sticas de crise. Neste sentido, seguimos acreditando que o campo de 
#pesquisa deve se debru�ar no desenvolvimento de m�ltiplas ferramentas de an�lise
#, com o objetivo de construir operadores te�rico-metodol�gicos � altura da 
#acelerada complexifica��o dos processos de circula��o discursiva e semiose 
#social na sociedade mediatizada."

#   6 - Como a sua pesquisa d� um passo a mais para o desenvolvimento te�rico 
#presente neste artigo?

#  (1) Este estudo proporciona o arcabou�o bibliogr�fico conceitual para se 
#pensar a relev�ncia da opini�o p�blica e influ�ncia da m�dia com fins de 
#manuten��o e amplia��o da credibilidade e valor simb�lico dos magistrados como 
#representantes do Poder Judici�rio. Al�m de apresentar m�todos qualitativos e 
#quantitativos para a an�lise emp�rica do objeto de pesquisa determinado.

#(2) O artigo analisado aponta para s�rios desafios na coleta de dados 
#quantitativos para pesquisa sobre m�dia no �mbito digital e o discurso em 
#movimento. Al�m da influ�ncia de algoritmos para coleta manual de tais dados. 
#O que pode afetar na escolha do objeto emp�rico de pesquisa. 
#O arcabou�o conceitual para a pesquisa � fortalecido pelas bibliografias 
#tradicionais sobre os estudos da m�dia e de opini�o p�blica. No entanto, devido
#a contemporaneidade dos estudos sobre as l�gicas digitais pol�ticas se mostra 
#necess�rio o uso de metodologias que avancem na compreens�o qualitativa dos 
#recentes par�metros midi�ticos.

#   Elabore qual � a pergunta da sua pesquisa em apenas uma frase.

#O Poder Judici�rio se usa da m�dia para criar imagem de credibilidade e apoio 
#social � suas decis�es, enquanto a m�dia independente e alternativa tende a 
#mostrar as manobras subversivas da justi�a.

#   Pense no seu trabalho e avalie em que medida ele passa pelas 4 avalia��es de
#rela��o causal, e quais problemas ele pode ter em cada uma delas.

#Logo na primeira avalia��o a hip�tese � refut�vel, j� que o Poder Judici�rio 
#n�o necessita do apoio popular para fazer valer suas decis�es. No entanto, desde
#a perspectiva de Bourdieu, o padr�o de credibilidade como constru��o de capital 
#social e valor simb�lico � poss�vel identificar a rela��o de causalidade entre 
#a credibilidade do Poder Judici�rio e a m�dia tradicional. Enquanto, a m�dia 
#independente surge como ator de contra-poder que pode ou n�o, a depender da 
#an�lise emp�rica, gerar efeitos de accountability no campo social.

#A segunda avalia��o parece tamb�m ser fraca, pois os magistrados tamb�m como 
#cidad�os comuns podem ser influenciados pelo conte�do informativo e midi�tico 
#que consomem, apesar de seu dever de imparcialidade.

#� poss�vel visualizar a covaria��o entre as atividades judici�rias e os 
#discursos midi�ticos tanto tradicionais quanto independentes, principalmente 
#quando as decis�es concernem a pessoas de interesse.

#A possibilidade de uma vari�vel Z enfraquecer a rela��o causal das vari�veis 
#n�o � irrefut�vel, mas aparentemente dif�cil de se identificar. Visto que a 
#exist�ncia de uma arena oculta que influencie na performance das vari�veis � 
#poss�vel, mas n�o vis�vel ou mensur�vel.

#FIM                   
                                                                                                                                                                                                              