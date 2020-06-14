
# Entre no seguinte link:
# https://pt.wikipedia.org/wiki/EleiÃ§Ã£o_presidencial_no_Brasil_em_2002
# Vá até o tópico RESUMO DAS ELEICOES

# Crie um vetor com o nome dos seis candidatos a presidência

candidatos <- c("Lula da Silva","José Serra", "Anthony Garotinho", "Ciro Gomes","Zé Maria", "Rui Costa")


# Crie um vetor com a sigla do partido de cada candidato

partido <- c("PT","PSDB","PSB","PPS","PSTU","PCO")


# Crie um vetor com o total de votos de cada candidato
  
votos_candidatos <- c(39455233,19705445,15180097,10170882,402236,38619)


# Crie um objeto calculando a soma dos votos dos candidatos no 1o turno
  
total_votos <- sum(votos_candidatos)


# Crie um vetor com a porcentagem de votos de cada candidato
# fazendo uma operaÃ§Ã£o aritmÃ©tica entre o objeto votos_candidatos
# e o objeto total_votos

porcentagem_votos <- (votos_candidatos*100)/total_votos
####Achei essa função para retirar as casa decimais 
porcentagem0 <- trunc(porcentagem_votos)
####E essa pra fazer o arredondamento tradicional
porcentagem0 <- round(porcentagem_votos)


# Crie uma matriz que conste uma coluna com o total de votos de cada candidato
# e outra com a porcentagem dos votos de cada candidato

matriz_votos <- matrix(c(votos_candidatos, porcentagem_votos),ncol = 2)
####Matriz arredondada (não achei função que incluia "%" nos elementos:
matriz_votos <- matrix(c(votos_candidatos, porcentagem0),ncol = 2)


# Nomeie as linhas da matriz com o nome dos candidatos

rownames(matriz_votos) <- c("Lula da Silva","José Serra","Anthony Garotinho","Ciro Gomes","José Maria", "Rui Costa")


# Nomeie também as colunas

colnames(matriz_votos) <- c("Total de votos", "Porcentagem")


# Crie um dataframe com o nome dos candidatos, o partido,
# a quantidade de votos e o percentual

resultados <- data.frame(candidatos,partido,votos_candidatos,porcentagem_votos)


# Crie um vetor lógico, indicado TRUE ou FALSE, com a informacao se
# o candidato foi para o segundo turno

segundo_turno <- porcentagem_votos > 20


# Adicione esta coluna no dataframe

resultados_col_extra <- cbind(resultados,segundo_turno)


# Calcule a soma da porcentagem dos dois candidatos que obtiveram mais votos

somatório_mais_votados <- sum(resultados[1,4],resultados[2,4])


# Exiba as informações do dataframe dos dois candidatos com mais votos

mais_votados <- resultados_col_extra [c(1,2),]



###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
#
# [1] 24 18 31

q <- c(47, 24, 18, 33, 31, 15)
q[c(2,3,5)]

###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
#
# Out Nov
#  24   2

x <- c(5, 4, 24, 2)
y <- c("Ago", "Set", "Out", "Nov")
names(x) <- y

x[c(3,4)]

###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
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

# Se Z é uma matriz 4 por 4, qual é o resultado de Z[1,4] ?

####O resultado será o elemento presente na primeira linha e quarta coluna.

###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
#
#  W3 W4 W1 W2 
#  20 69  5 88 

y <- c(20, 69, 5, 88)
q <- c("W3", "W4", "W1", "W2")
names(y) <- q
y
  
###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
#
#       [,1] [,2]
# [1,]    4    6
# [2,]    3    7
# [3,]    1    8


cbind(c(4, 3, 1), c(6,7,8))



###############################################################################

# Substitua o símbolo de interrogação por um 
# código que retorne o seguinte resultado:
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
# qual código produziria o seguinte resultado?
#
#    x  y
# 1 17  A
# 2 37  B
# 3 12  C

df2 <- df[1:3,1:2]

###############################################################################

# Responder o exercício teórico abaixo

#Como fontes de informação a Grande Mídia (uma expressão usada para designar a 
#mídia ou os média de massas, que influencia um grande número de pessoas, 
#refletindo correntes de pensamento dominantes) tem perdido credibilidade para
#com seus consumidores. Devido a diversos fatores como o partidarismo de notícias
#fatores de financiamento e omissões. O ambiente digital que se consolida no século
#XXI como principal ferramenta de acesso à informações é permeado por desinformação
#que se materializa em notícias falsas e campanhas de shitstorm. Este contexto,
#gera grandes riscos para a confiança em relação ao conteúdo de notícias. A mídia
#alternativa (também conhecida por mídia contra-hegemônica ou média 
#contra-hegemónicos (mas não independente(s)) é o conjunto dos veículos de 
#comunicação que se contrapõem a uma hegemonia, ou posição política dominante - 
#e, em alguns casos, repressora) então, surge como contra-poder frente aos atores 
#manipuladores do poder instituído entre os meios midiáticos. 


#Hipótese:As atividades e surgimento de mídias alternativas aumenta à medida que
#a credibilidade da mídia tradicional decai e a circulação de desinformação
#aumenta.

#variável independente: credibilidade da mídia tradicional
#variável independente: a circulação de desinformação
#variável dependente: atividade de mídias alternativas

#Operacionalização: Com o nível de credibilidade da mídia tradicional baixo 
#as atividades das mídias alternativas aumenta resultando numa relação negativa
#entre essas variáveis. O aumento da circulação de desinformação pode causar o
# aumento de atividades e criação de mídias alternativas traduzindo uma relação
#positiva entre essas variáveis.

#a credibilidade da Grade Mídia pode ser operacionalizada através da coleta de dados 
#estatísticos que apontem para número de leitores através de certo período de tempo
#ou utilizando dados estatísticos de pesquisas qualitativas sobre a confiança nos
#conteúdos de mídias tradicionais. 

#a circulação de desinformação nas redes pode ser dimensionada através da raspagem
#de dados que demonstrem a quantidade de notícias falsas (fake news) e o nível de
#engajamento de cada notícia. Também a ser analisado num dado período de tempo.

#a atividade de mídias alternativas pode ser dimensionada pela coleta de dados 
#numéricos e estatísticos sobre a criação de sites e plataformas com finalidade 
#de propagação de notícias que se enquadrem no conceito de "mídia alterntiva" 
#no período de tempo preestabelecido.

