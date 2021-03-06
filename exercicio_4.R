
## Fa�a todos os gr�ficos utilizando um tema que voc� ache mais adequado
## e nomeie os eixos x e y da maneira adequada

## Carregue o banco world do pacote poliscidata

library(poliscidata)
library(tidyverse)
install.packages("scales")
library(scales)
install.packages("ggthemes")
library(ggthemes)
library(graphics)

banco <- world %>%
  filter(!is.na(democ_regime08),
         !is.na(muslim),
         !is.na(dem_score14))

## Observe o banco de dados com as fun��es adequadas

glimpse(banco)
head(banco)
tail(banco)
str(banco)
summary(banco)

## A vari�vel democ_regime08 indica se um pa�s � democr�tico.
## Usando as ferramentas de manipulacao de bancos de dados, verifique
## quantos paises sao democraticos ou nao, e apresente esta vari�vel 
## graficamente

banco$democ_regime08

banco_selecionado <- banco %>%
  count(democ_regime08)
  

ggplot(banco, aes(fct_infreq(democ_regime08))) +
  geom_bar() +
  theme_minimal() +
  labs(title = "Democracias",
       subtitle = "Gr�fico de barras",
       x = "Pa�s � democr�tico?",
       y = "N�mero de pa�ses",
       caption = "Elabora��o pr�pria a partir do banco world")

## Teste a rela��o entre a vari�vel democ_regime08 e a vari�vel
## muslim (que indica se um pa�s � mu�ulmano ou n�o). E represente
## visualmente as vari�veis para visualizar se esta religi�o
## aumenta ou diminui a chance de um pa�s ser democr�tico
## Qual seria sua conclus�o com rela��o a associa��o destas duas
## vari�veis?

banco$muslim

tabela <- table(banco$muslim, banco$democ_regime08)
prop.table(tabela)
prop.table(tabela,2)
chisq.test(tabela)
mosaicplot(tabela, shade = TRUE)

ggplot(banco, aes(muslim, fill = democ_regime08)) +
  geom_bar(position = "fill") +
  labs(title = "Democracia x Religi�o (mul�umana)",
       subtitle = "Gr�fico de barras",
       x = "Pa�s � mul�umano?",
       y = "Propor��o de pa�ses mul�umanos",
       caption = "Elabora��o pr�pria a partir do banco world")
  
# Pela an�lise do teste de hip�tese e do gr�fico � possivel verificar que em 
# em pa�ses mul�umanos h� menos regimes democr�ticos em compara��o � pa�ses n�o
# mul�umanos. Numa propor��o de um quarto dos pa�ses considerados mul�umanos s�o
# democracias enquanto perto de um ter�o de pa�ses n�o mul�umanos s�o democracias
# O teste de hip�tese resulta no x� de 26.665 e o p-valor de 2.419e-07 como o 
# valor do x� � maior que o valor cr�tico para df = 1, podemos concluir que h�
# uma rela��o entre as vari�veis no sentido de que pa�ses considerados mul�umanos
# tem menos probabilidades de serem democracias que nos pa�ses n�o mul�umanos.


## A vari�vel gdppcap08 possui informa��o sobre o PIB per capta
## dos pa�ses. Fa�a uma representa��o gr�fica desta vari�vel


banco$gdppcap08

ggplot(banco, aes(gdppcap08, fill="")) +
  geom_density() +
  scale_y_continuous(labels = percent) +
  theme_minimal() +
  labs(title = "PIB per capta dos pa�ses",
       subtitle = "Gr�fico de densidade",
       x = "PIB per capta",
       caption = "Elabora��o pr�pria a partir do banco world")


## Fa�a um sumario com a m�dia, mediana e desvio padr�o do pib per capta
## para cada tipo de regime politico, represente a associa��o destas
## vari�veis graficamente, e fa�a o teste estat�stico adequado para
## chegar a uma conclus�o. Existe associa��o entre as vari�veis?

banco %>%
  group_by(dem_level4) %>%
  summarise(media = mean(gdppcap08, na.rm = TRUE), 
            mediana = median(gdppcap08, na.rm = TRUE), 
            desvio = sd(gdppcap08, na.rm = TRUE),
            n()
  ) 

ggplot(banco, aes(democ_regime08, gdppcap08)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Regimes Pol�ticos x PIB per capta",
       subtitle = "Gr�fico Boxplot",
       x = "Regime Pol�tico",
       y = "PIB per capta",
       caption = "Elabora��o pr�pria a partir do banco world")

t.test(gdppcap08 ~ democ_regime08, data = banco)

# Pela an�lise do gr�fico feita para cada regime pol�tico � poss�vel 
# visualizar uma rela��o entre regime e PIB per capta visto que a 
# distribui��o � maior para democracias que n�o democracias. No entanto, existem 
# alguns outiliers. Como o valor de t � de -2.894, sendo diferente de 0, �
# poss�vel inferir a favor da hip�tese alternativa, com confian�a que se retira
# do p-valor igual � 0.0044.

## Por fim, ao inv�s de utilizar uma vari�vel bin�ria de democracia,
## utilize a vari�vel dem_score14 para avaliar se existe uma associa��o
## entre regime pol�tico e desenvolvimento econ�mico. Represente
## a associa��o graficamente, fa�a o teste estat�stico e explica sua
## conclus�o

banco$dem_score14

ggplot(banco, aes(dem_score14, gdppcap08)) +
  geom_jitter() +
  theme_minimal() +
  labs(title = "Regimes Pol�ticos x PIB per capta",
       subtitle = "Gr�fico de Pontos",
       x = "n�vel de democracia",
       y = "PIB per capta",
       caption = "Elabora��o pr�pria a partir do banco world")

cor.test(banco$dem_score14, banco$gdppcap08)

# Como o valor 0 n�o se encontra no intervalo de confian�a da covaria��o � 
# poss�vel inferir � favor da signific�ncia estat�stica. o valor de 0.501 para
# a covari�ncia, portanto, indica uma rela��o entre as vari�veis, sendo o n�vel
# de democracia tendente � influenciar positivamente o Pib per capta, apesar da
# presen�a de alguns outliers. 

## Teste a associa��o entre renda per capta e religiao (com a vari�vel
## muslim) e represente graficamente. Qual � sua conclus�o? 


ggplot(banco, aes (muslim, gdppcap08)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Religi�o (mul�umana) x PIB per capta",
       subtitle = "Gr�fico Boxplot",
       x = "Pa�s � mul�umano?",
       y = "PIB per capta",
       caption = "Elabora��o pr�pria a partir do banco world")

t.test(gdppcap08 ~ muslim, data = banco)

# O boxplot mostra que em pa�ses que n�o s�o de vertente mul�umana a renda per 
# capta parece ser maior e mais consistente. Enquanto para pa�ses mul�umanos a 
# renda per capta parece menor com alguns outileirs distribu�dos. Com o t-teste
# � poss�vel verificar que h� signific�ncia estat�stica na rela��o das duas 
# vari�veis, j� que o valor de 0 n�o se encontra no intervalo. Com confian�a que
# se retira do p-valor de 0.028.

## Comparando suas conclus�es anteriores, � poss�vel afirmar qual
## das duas vari�veis possui maior impacto no desenvolvimento economico?
## Por que? 

#  A partir do p-valor de 0.004 sobre a rela��o da vari�vel democracia e PIB per
# capta em compara��o ao p-valor de 0.028 sobre a rela��o entre a religi�o e o 
# PIB per capta podemos ter mais confian�a de que o regime democr�tico influi 
# positivamente no desenvolvimento econ�mico do que a religi�o. 

##########################################################################

## Exerc�cio te�rico
## Levando em considera��o as vari�veis de seu trabalho final,
## qual dos 3 testes estat�sticos utilizados seria adequado utilizar?

# Como todas as vari�veis que ser�o utilizadas no projeto s�o categ�ricas
# o melhor modelo de teste estat�sco a ser utilizado para avali�-las seria a
# a an�lise tabular com o c�lculo do X�. 
