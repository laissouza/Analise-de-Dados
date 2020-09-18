Exercicio 10
================

### Continuaremos com a utilização dos dados do ESEB2018. Carregue o banco da mesma forma que nos exercicios anteriores

``` r
library(tidyverse)
library(haven)

link <- "https://github.com/MartinsRodrigo/Analise-de-dados/blob/master/04622.sav?raw=true"

download.file(link, "04622.sav", mode = "wb")

banco <- read_spss("04622.sav") 

banco <- banco %>%
  mutate(D10 = as_factor(D10)) %>%
  filter(Q18 < 11,
         D9 < 9999998,
         Q1501 < 11,
         Q12P2_B < 3) %>%
  mutate(Q12P2_B = case_when(Q12P2_B == 1 ~ 0,  # Quem votou em Haddad = 0
                             Q12P2_B == 2 ~ 1)) # Quem votou em Bolsonaro = 1
```

### Crie a mesma variável de religião utilizada no exercício anterior

``` r
Outras <- levels(banco$D10)[-c(3,5,13)]

banco <- banco %>%
  mutate(religiao = case_when(D10 %in% Outras ~ "Outras",
                              D10 == "Católica" ~ "Católica",
                              D10 == "Evangélica" ~ "Evangélica",
                              D10 == "Não tem religião" ~ "Não tem religião"))
```

### Faça uma regressão linear utilizando as mesmas variáveis do exercício 9 - idade(D1A\_ID), educação (D3\_ESCOLA), renda (D9), nota atribuída ao PT (Q1501), auto-atribuição ideológica (Q18), sexo (D2\_SEXO) e religião (variável criada no passo anterior) - explicam o voto em Bolsonaro (Q12P2\_B).

``` r
regressao <- lm(Q12P2_B ~ D1A_ID + D3_ESCOLA +  D9 + Q1501 + Q18 + D2_SEXO + religiao, data = banco)

summary (regressao)
```

    ## 
    ## Call:
    ## lm(formula = Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao, data = banco)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.05532 -0.19854  0.01565  0.16182  0.96682 
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)               7.067e-01  6.469e-02  10.924  < 2e-16 ***
    ## D1A_ID                    1.140e-03  7.539e-04   1.512  0.13074    
    ## D3_ESCOLA                 5.547e-03  5.226e-03   1.061  0.28873    
    ## D9                       -9.837e-07  3.196e-06  -0.308  0.75832    
    ## Q1501                    -7.728e-02  2.799e-03 -27.610  < 2e-16 ***
    ## Q18                       2.651e-02  3.093e-03   8.570  < 2e-16 ***
    ## D2_SEXO                  -5.286e-02  2.089e-02  -2.530  0.01154 *  
    ## religiaoEvangélica        7.684e-02  2.363e-02   3.251  0.00118 ** 
    ## religiaoNão tem religião -2.746e-03  4.238e-02  -0.065  0.94835    
    ## religiaoOutras           -7.263e-02  3.678e-02  -1.975  0.04855 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.3489 on 1138 degrees of freedom
    ## Multiple R-squared:  0.5028, Adjusted R-squared:  0.4989 
    ## F-statistic: 127.9 on 9 and 1138 DF,  p-value: < 2.2e-16

### Interprete o resultado dos coeficientes

Para todas as variáveis indepentes em zero temos o valor de 7.067e-01
para a variável dependente indicado pelo intercepto. No que tange a
variável idade temos uma variação de 1.140e-03 em Y para um aumento
unitário na faixa etária. No entanto, este coeficiente não conta com
significância estatística, já que seu p-valor é de 0.13074. No quesito
educação temos uma variação de 5.547e-03 para o voto em Bolsonaro, porém
mais uma vez esse coeficiente não apresenta significância estatística. O
mesmo acontece para a variável de renda que apresenta variação de
-9.837e-07 porém sem significância estatística. Passando à variável de
avaliação do PT, temos alta significâcia estatística (\< 2e-16) de que
para um aumento unitário na avaliação deste partido, o voto em Bolsonaro
tende a diminuir visto o valor negativo apresentado no coeficiente
(-7.728e-02). A variável de atribuição ideológica é outra que apresenta
significância estatística para sua variação (\< 2e-16). Neste caso cada
aumento unitário da variável Q18 indica que o respondente se identifca
mais a direita do espectro político, assim o efeito desta variável para
o voto em Bolsonaro é positivo (2.651e-02). No que tange o sexo dos
respondentes sendo homens indicados como 1 e mulheres indicadas como 2,
temos que o aumento unitário, ou seja, ser mulher tem um efeito negativo
no voto em Bolsonaro (-5.286e-02) quando comparadas aos homens que terão
o mesmo valor de variação porém tal variação será positiva. A
significância estatística deste coeficiente é razoável para ser
considerado relevante ao modelo. Ao analisar a variável de religião
percebe-se que a categoria de referência é a católica. Assim, quando
comparados aos católicos somente o grupo dos evangélicos (7.684e-02) e
de outras religiões (-7.263e-02) possuem relevância estatística para seu
efeito no voto em Bolsonaro. Sendo os evangélicos mais propensos que
caólicos à votar em Bolsonaro pelo sinal positivo de seu coeficente,
enquanto aqueles que se identificam com outras religiões são menos
propensos à votar em Bolsonaro que os católicos devido ao sinal negativo
no valor do coeficiente. Aqueles que não possuem religião, apesar de
mostar efeito de -2.746e-03 para o voto em Bolsonaro quando comparados à
católicos, não possuem significância estatística.

### O resultado difere dos encontrados anteriormente, quando a variavel dependente era a aprovação de Bolsonaro?

Os valores dos coeficientes e das significâncias estatísticas das
variáveis independentes analisadas não diferem de forma significante
daqueles analisados sobre a avaliação de Bolsonaro.

### Faça uma regressão logistica com as mesmas variaveis

``` r
regressao_logistica <- glm(Q12P2_B ~ D1A_ID + D3_ESCOLA +  D9 + Q1501 + Q18 + D2_SEXO + religiao, data = banco, family = "binomial")

summary(regressao_logistica)
```

    ## 
    ## Call:
    ## glm(formula = Q12P2_B ~ D1A_ID + D3_ESCOLA + D9 + Q1501 + Q18 + 
    ##     D2_SEXO + religiao, family = "binomial", data = banco)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.7529  -0.5625   0.2518   0.4744   2.5830  
    ## 
    ## Coefficients:
    ##                            Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)               8.209e-01  5.298e-01   1.550  0.12124    
    ## D1A_ID                    1.001e-02  6.337e-03   1.580  0.11405    
    ## D3_ESCOLA                 5.634e-02  4.358e-02   1.293  0.19602    
    ## D9                       -4.635e-06  2.396e-05  -0.193  0.84660    
    ## Q1501                    -4.678e-01  2.666e-02 -17.545  < 2e-16 ***
    ## Q18                       2.242e-01  2.748e-02   8.159 3.37e-16 ***
    ## D2_SEXO                  -4.497e-01  1.739e-01  -2.586  0.00971 ** 
    ## religiaoEvangélica        6.217e-01  1.985e-01   3.132  0.00173 ** 
    ## religiaoNão tem religião -2.106e-02  3.478e-01  -0.061  0.95172    
    ## religiaoOutras           -6.736e-01  3.122e-01  -2.158  0.03096 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1557.84  on 1147  degrees of freedom
    ## Residual deviance:  862.45  on 1138  degrees of freedom
    ## AIC: 882.45
    ## 
    ## Number of Fisher Scoring iterations: 5

### Transforme os coeficientes estimados em probabilidade

``` r
library(margins)

margins(regressao_logistica)
```

    ##    D1A_ID D3_ESCOLA         D9    Q1501     Q18 D2_SEXO religiaoEvangélica
    ##  0.001171  0.006589 -5.421e-07 -0.05471 0.02622 -0.0526            0.07346
    ##  religiaoNão tem religião religiaoOutras
    ##                 -0.002521       -0.08172

``` r
summary(margins(regressao_logistica))
```

    ##                    factor     AME     SE        z      p   lower   upper
    ##                    D1A_ID  0.0012 0.0007   1.5849 0.1130 -0.0003  0.0026
    ##                   D2_SEXO -0.0526 0.0202  -2.6078 0.0091 -0.0921 -0.0131
    ##                 D3_ESCOLA  0.0066 0.0051   1.2949 0.1953 -0.0034  0.0166
    ##                        D9 -0.0000 0.0000  -0.1935 0.8466 -0.0000  0.0000
    ##                     Q1501 -0.0547 0.0009 -57.9079 0.0000 -0.0566 -0.0529
    ##                       Q18  0.0262 0.0030   8.8434 0.0000  0.0204  0.0320
    ##        religiaoEvangélica  0.0735 0.0235   3.1280 0.0018  0.0274  0.1195
    ##  religiaoNão tem religião -0.0025 0.0417  -0.0605 0.9517 -0.0842  0.0791
    ##            religiaoOutras -0.0817 0.0379  -2.1574 0.0310 -0.1560 -0.0075

### Quais foram as diferenças no resultado entre usar a regressão linear e a logistica?

A regressão linear apresenta a variação absoluta na variável dependente
para um aumento unitário em cada variável independente. Enquanto a
regressão logística apresenta o efeito médio em porcentagem sobre o voto
em Bolsonaro para cada aumento unitário na variável independente. Assim,
na regressão logística temos que a variável de idade tem um efeito de
0.12% de forma positiva ao voto em Bolsonaro, com significância baixa de
0.113, assim como a significância para esta variável na regressão
linear. O mesmo acontece para a variável de escolaridade com
significância de 0.1953 e efeito positivo de 0.66%. A variável de sexo
que tem por referência as mulheres tem efeito negativo de -5.26% e
p-valor aceitável de 0.0091. A variável de renda na regressão logística
não apresenta nenhum efeito significante sobre o voto em Bolsonaro por
seu valor de coeficiente -0.00% e p-valor 0.8466. Já a avaliação do PT
tem efeito negativo de -5.47% sobre o voto em Bolsonaro com p-valor
0.000. A autoidentificação ideológica tem efeito positivo de 2.62% sobre
o voto no candidato com significância estatística que se retira do
p-valor de 0.0320. Por fim, a variável de religião que tem por
referência a categoria dos católicos, verifica-se que ser evangélico
tem um efeito positivo de 7.35% sobre o voto no candidato analisado em
comparação aos católicos, com significância estatística de 0.0018.
Aqueles que não se identificam em nenhuma religião tem efeito negativo
de -0.25%, mas tal efeito não tem significância estatística visto o
p-valor de 0.9517. Os que se identificam com outras religiões tem efeito
negativo de -8.17% no voto no candidato em relação aos católicos, com
significância estatística de 0.0310. Assim, em geral os resultados da
regressão logística seguem a lógica dos resultados dos coeficientes
apresentados na regressão linear. Isto é, as variáveis de idade,
escolaridade e renda não tem significância estatística para se fazer
inferências sobre as mesmas. Aqueles que não se identificam em nenhuma
religião não tem efeito com significância estatística diverso dos
católicos. Ser mulher, avaliar melhor o PT e se identificar com outras
religiões (quando se compara aos católicos) tem efeito negativo sobre o
voto de Bolsonaro, todos esses efeitos contando com relevância
estatística. Enquanto, se posicionar mais a direita do espectro
político e ser evangélico (quando se compara aos católicos) tem efeito
positivo no voto no candidato avaliado e significância estatística.

### Verifique a quantidade de classificações corretas da regressao logistica e avalie o resultado

``` r
predicted_prob <- predict(regressao_logistica, type = "response")

library(InformationValue)

1 - misClassError(banco$Q12P2_B, 
                  predicted_prob, 
                  threshold = 0.5)
```

    ## [1] 0.8301

``` r
opt_cutoff <- optimalCutoff(banco$Q12P2_B, 
                            predicted_prob)

1 - misClassError(banco$Q12P2_B, 
                  predicted_prob, 
                  threshold = opt_cutoff)
```

    ## [1] 0.8362

O resultado mostra que a previsão do modelo está de acordo com o
resultado das observações no banco de dados em 0.8301, ou seja, 83% das
vezes o modelo acerta os resultados. Para otimizar a quantidade de
acertos do modelo usamos o opt\_cutoff o que aumentou a quantidade de
acertos para 0.8362 ou 83.62%.
