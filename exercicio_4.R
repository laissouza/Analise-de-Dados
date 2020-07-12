
## Faça todos os gráficos utilizando um tema que você ache mais adequado
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

## Observe o banco de dados com as funções adequadas

glimpse(banco)
head(banco)
tail(banco)
str(banco)
summary(banco)

## A variável democ_regime08 indica se um país é democrático.
## Usando as ferramentas de manipulacao de bancos de dados, verifique
## quantos paises sao democraticos ou nao, e apresente esta variável 
## graficamente

banco$democ_regime08

banco_selecionado <- banco %>%
  count(democ_regime08)
  

ggplot(banco, aes(fct_infreq(democ_regime08))) +
  geom_bar() +
  theme_minimal() +
  labs(title = "Democracias",
       subtitle = "Gráfico de barras",
       x = "País é democrático?",
       y = "Número de países",
       caption = "Elaboração própria a partir do banco world")

## Teste a relação entre a variável democ_regime08 e a variável
## muslim (que indica se um país é muçulmano ou não). E represente
## visualmente as variáveis para visualizar se esta religião
## aumenta ou diminui a chance de um país ser democrático
## Qual seria sua conclusão com relação a associação destas duas
## variáveis?

banco$muslim

tabela <- table(banco$muslim, banco$democ_regime08)
prop.table(tabela)
prop.table(tabela,2)
chisq.test(tabela)
mosaicplot(tabela, shade = TRUE)

ggplot(banco, aes(muslim, fill = democ_regime08)) +
  geom_bar(position = "fill") +
  labs(title = "Democracia x Religião (mulçumana)",
       subtitle = "Gráfico de barras",
       x = "País é mulçumano?",
       y = "Proporção de países mulçumanos",
       caption = "Elaboração própria a partir do banco world")
  
# Pela análise do teste de hipótese e do gráfico é possivel verificar que em 
# em países mulçumanos há menos regimes democráticos em comparação à países não
# mulçumanos. Numa proporção de um quarto dos países considerados mulçumanos são
# democracias enquanto perto de um terço de países não mulçumanos são democracias
# O teste de hipótese resulta no x² de 26.665 e o p-valor de 2.419e-07 como o 
# valor do x² é maior que o valor crítico para df = 1, podemos concluir que há
# uma relação entre as variáveis no sentido de que países considerados mulçumanos
# tem menos probabilidades de serem democracias que nos países não mulçumanos.


## A variável gdppcap08 possui informação sobre o PIB per capta
## dos países. Faça uma representação gráfica desta variável


banco$gdppcap08

ggplot(banco, aes(gdppcap08, fill="")) +
  geom_density() +
  scale_y_continuous(labels = percent) +
  theme_minimal() +
  labs(title = "PIB per capta dos países",
       subtitle = "Gráfico de densidade",
       x = "PIB per capta",
       caption = "Elaboração própria a partir do banco world")


## Faça um sumario com a média, mediana e desvio padrão do pib per capta
## para cada tipo de regime politico, represente a associação destas
## variáveis graficamente, e faça o teste estatístico adequado para
## chegar a uma conclusão. Existe associaçào entre as variáveis?

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
  labs(title = "Regimes Políticos x PIB per capta",
       subtitle = "Gráfico Boxplot",
       x = "Regime Político",
       y = "PIB per capta",
       caption = "Elaboração própria a partir do banco world")

t.test(gdppcap08 ~ democ_regime08, data = banco)

# Pela análise do gráfico feita para cada regime político é possível 
# visualizar uma relação entre regime e PIB per capta visto que a 
# distribuição é maior para democracias que não democracias. No entanto, existem 
# alguns outiliers. Como o valor de t é de -2.894, sendo diferente de 0, é
# possível inferir a favor da hipótese alternativa, com confiança que se retira
# do p-valor igual à 0.0044.

## Por fim, ao invés de utilizar uma variável binária de democracia,
## utilize a variável dem_score14 para avaliar se existe uma associação
## entre regime político e desenvolvimento econômico. Represente
## a associação graficamente, faça o teste estatístico e explica sua
## conclusão

banco$dem_score14

ggplot(banco, aes(dem_score14, gdppcap08)) +
  geom_jitter() +
  theme_minimal() +
  labs(title = "Regimes Políticos x PIB per capta",
       subtitle = "Gráfico de Pontos",
       x = "nível de democracia",
       y = "PIB per capta",
       caption = "Elaboração própria a partir do banco world")

cor.test(banco$dem_score14, banco$gdppcap08)

# Como o valor 0 não se encontra no intervalo de confiança da covariação é 
# possível inferir à favor da significância estatística. o valor de 0.501 para
# a covariância, portanto, indica uma relação entre as variáveis, sendo o nível
# de democracia tendente à influenciar positivamente o Pib per capta, apesar da
# presença de alguns outliers. 

## Teste a associação entre renda per capta e religiao (com a variável
## muslim) e represente graficamente. Qual é sua conclusão? 


ggplot(banco, aes (muslim, gdppcap08)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Religião (mulçumana) x PIB per capta",
       subtitle = "Gráfico Boxplot",
       x = "País é mulçumano?",
       y = "PIB per capta",
       caption = "Elaboração própria a partir do banco world")

t.test(gdppcap08 ~ muslim, data = banco)

# O boxplot mostra que em países que não são de vertente mulçumana a renda per 
# capta parece ser maior e mais consistente. Enquanto para países mulçumanos a 
# renda per capta parece menor com alguns outileirs distribuídos. Com o t-teste
# é possível verificar que há significância estatística na relação das duas 
# variáveis, já que o valor de 0 não se encontra no intervalo. Com confiança que
# se retira do p-valor de 0.028.

## Comparando suas conclusões anteriores, é possível afirmar qual
## das duas variáveis possui maior impacto no desenvolvimento economico?
## Por que? 

#  A partir do p-valor de 0.004 sobre a relação da variável democracia e PIB per
# capta em comparação ao p-valor de 0.028 sobre a relação entre a religião e o 
# PIB per capta podemos ter mais confiança de que o regime democrático influi 
# positivamente no desenvolvimento econômico do que a religião. 

##########################################################################

## Exercício teórico
## Levando em consideração as variáveis de seu trabalho final,
## qual dos 3 testes estatísticos utilizados seria adequado utilizar?

# Como todas as variáveis que serão utilizadas no projeto são categóricas
# o melhor modelo de teste estatísco a ser utilizado para avaliá-las seria a
# a análise tabular com o cálculo do X². 
