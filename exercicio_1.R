
# Entre no seguinte link:
# https://pt.wikipedia.org/wiki/Eleição_presidencial_no_Brasil_em_2002
# V� at� o t�pico RESUMO DAS ELEICOES

# Crie um vetor com o nome dos seis candidatos a presid�ncia

candidatos <- c("Lula da Silva","Jos� Serra", "Anthony Garotinho", "Ciro Gomes","Z� Maria", "Rui Costa")


# Crie um vetor com a sigla do partido de cada candidato

partido <- c("PT","PSDB","PSB","PPS","PSTU","PCO")


# Crie um vetor com o total de votos de cada candidato
  
votos_candidatos <- c(39455233,19705445,15180097,10170882,402236,38619)


# Crie um objeto calculando a soma dos votos dos candidatos no 1o turno
  
total_votos <- sum(votos_candidatos)


# Crie um vetor com a porcentagem de votos de cada candidato
# fazendo uma operação aritmética entre o objeto votos_candidatos
# e o objeto total_votos

porcentagem_votos <- (votos_candidatos*100)/total_votos
####Achei essa fun��o para retirar as casa decimais 
porcentagem0 <- trunc(porcentagem_votos)
####E essa pra fazer o arredondamento tradicional
porcentagem0 <- round(porcentagem_votos)


# Crie uma matriz que conste uma coluna com o total de votos de cada candidato
# e outra com a porcentagem dos votos de cada candidato

matriz_votos <- matrix(c(votos_candidatos, porcentagem_votos),ncol = 2)
####Matriz arredondada (n�o achei fun��o que incluia "%" nos elementos:
matriz_votos <- matrix(c(votos_candidatos, porcentagem0),ncol = 2)


# Nomeie as linhas da matriz com o nome dos candidatos

rownames(matriz_votos) <- c("Lula da Silva","Jos� Serra","Anthony Garotinho","Ciro Gomes","Jos� Maria", "Rui Costa")


# Nomeie tamb�m as colunas

colnames(matriz_votos) <- c("Total de votos", "Porcentagem")


# Crie um dataframe com o nome dos candidatos, o partido,
# a quantidade de votos e o percentual

resultados <- data.frame(candidatos,partido,votos_candidatos,porcentagem_votos)


# Crie um vetor l�gico, indicado TRUE ou FALSE, com a informacao se
# o candidato foi para o segundo turno

segundo_turno <- porcentagem_votos > 20


# Adicione esta coluna no dataframe

resultados_col_extra <- cbind(resultados,segundo_turno)


# Calcule a soma da porcentagem dos dois candidatos que obtiveram mais votos

somat�rio_mais_votados <- sum(resultados[1,4],resultados[2,4])


# Exiba as informa��es do dataframe dos dois candidatos com mais votos

mais_votados <- resultados_col_extra [c(1,2),]



###############################################################################

# Substitua o s�mbolo de interroga��o por um 
# c�digo que retorne o seguinte resultado:
#
# [1] 24 18 31

q <- c(47, 24, 18, 33, 31, 15)
q[c(2,3,5)]

###############################################################################

# Substitua o s�mbolo de interroga��o por um 
# c�digo que retorne o seguinte resultado:
#
# Out Nov
#  24   2

x <- c(5, 4, 24, 2)
y <- c("Ago", "Set", "Out", "Nov")
names(x) <- y

x[c(3,4)]

###############################################################################

# Substitua o s�mbolo de interroga��o por um 
# c�digo que retorne o seguinte resultado:
#
# 'data.frame':	2 obs. of  2 variables:
# $ x: Factor w/ 2 levels "d","e": 1 2
# $ y: num  1 4

x = c("d","e")
df <- data.frame(x <- factor(x),
                 y = c(1,4)
)


str(df)

###############################################################################

# Crie a seguinte matriz
#
#       [,1] [,2] [,3]
# [1,]   19   22   25
# [2,]   20   23   26
# [3,]   21   24   27


matriz <- matrix(19:27, nrow = 3)


###############################################################################

# Se Z � uma matriz 4 por 4, qual � o resultado de Z[1,4] ?

####O resultado ser� o elemento presente na primeira linha e quarta coluna.

###############################################################################

# Substitua o s�mbolo de interroga��o por um 
# c�digo que retorne o seguinte resultado:
#
#  W3 W4 W1 W2 
#  20 69  5 88 

y <- c(20, 69, 5, 88)
q <- c("W3", "W4", "W1", "W2")
names(y) <- q
y
  
###############################################################################

# Substitua o s�mbolo de interroga��o por um 
# c�digo que retorne o seguinte resultado:
#
#       [,1] [,2]
# [1,]    4    6
# [2,]    3    7
# [3,]    1    8


cbind(c(4, 3, 1), c(6,7,8))



###############################################################################

# Substitua o s�mbolo de interroga��o por um 
# c�digo que retorne o seguinte resultado:
#       [,1] [,2] [,3] [,4]
# [1,]    1    3   13   15
# [2,]    2    4   14   16

x <- 1:4
y <- 13:16

matrix(c(x,y),
       nrow = 2,
       byrow = FALSE)

###############################################################################

# Crie o seguinte dataframe df
#
# df
#    x  y    z
# 1 17  A  Sep
# 2 37  B  Jul
# 3 12  C  Jun
# 4 48  D  Feb
# 5 19  E  Mar

x <- c(17,37,12,48,19)
y <- c("A","B","C","D","E")
z <- c("Sep","Jul","Jun","Feb","Mar")

df <- data.frame(x,y,z)


# Ainda utilizando o dataframe df,
# qual c�digo produziria o seguinte resultado?
#
#    x  y
# 1 17  A
# 2 37  B
# 3 12  C

df2 <- df[1:3,1:2]

###############################################################################

# Responder o exerc�cio te�rico abaixo

#Como fontes de informa��o a Grande M�dia (uma express�o usada para designar a 
#m�dia ou os m�dia de massas, que influencia um grande n�mero de pessoas, 
#refletindo correntes de pensamento dominantes) tem perdido credibilidade para
#com seus consumidores. Devido a diversos fatores como o partidarismo de not�cias
#fatores de financiamento e omiss�es. O ambiente digital que se consolida no s�culo
#XXI como principal ferramenta de acesso � informa��es � permeado por desinforma��o
#que se materializa em not�cias falsas e campanhas de shitstorm. Este contexto,
#gera grandes riscos para a confian�a em rela��o ao conte�do de not�cias. A m�dia
#alternativa (tamb�m conhecida por m�dia contra-hegem�nica ou m�dia 
#contra-hegem�nicos (mas n�o independente(s)) � o conjunto dos ve�culos de 
#comunica��o que se contrap�em a uma hegemonia, ou posi��o pol�tica dominante - 
#e, em alguns casos, repressora) ent�o, surge como contra-poder frente aos atores 
#manipuladores do poder institu�do entre os meios midi�ticos. 


#Hip�tese:As atividades e surgimento de m�dias alternativas aumenta � medida que
#a credibilidade da m�dia tradicional decai e a circula��o de desinforma��o
#aumenta.

#vari�vel independente: credibilidade da m�dia tradicional
#vari�vel independente: a circula��o de desinforma��o
#vari�vel dependente: atividade de m�dias alternativas

#Operacionaliza��o: Com o n�vel de credibilidade da m�dia tradicional baixo 
#as atividades das m�dias alternativas aumenta resultando numa rela��o negativa
#entre essas vari�veis. O aumento da circula��o de desinforma��o pode causar o
# aumento de atividades e cria��o de m�dias alternativas traduzindo uma rela��o
#positiva entre essas vari�veis.

#a credibilidade da Grade M�dia pode ser operacionalizada atrav�s da coleta de dados 
#estat�sticos que apontem para n�mero de leitores atrav�s de certo per�odo de tempo
#ou utilizando dados estat�sticos de pesquisas qualitativas sobre a confian�a nos
#conte�dos de m�dias tradicionais. 

#a circula��o de desinforma��o nas redes pode ser dimensionada atrav�s da raspagem
#de dados que demonstrem a quantidade de not�cias falsas (fake news) e o n�vel de
#engajamento de cada not�cia. Tamb�m a ser analisado num dado per�odo de tempo.

#a atividade de m�dias alternativas pode ser dimensionada pela coleta de dados 
#num�ricos e estat�sticos sobre a cria��o de sites e plataformas com finalidade 
#de propaga��o de not�cias que se enquadrem no conceito de "m�dia alterntiva" 
#no per�odo de tempo preestabelecido.

