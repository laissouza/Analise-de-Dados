# Utilizando o banco world do pacote poliscidata, faça um histograma que também 
#indique a média  e um boxplot da variável gini10.

# Descreva o que você pode observar a partir deles.
library(tidyverse)
library(poliscidata)
banco <- world

ggplot(banco, aes(gini10)) +
  geom_histogram()+
  geom_vline(aes(xintercept = mean(gini10, na.rm = T)))

# O histograma apresenta a contagem de dados do gini10 com a média em cerca de 
# 40.O maior número de variáveis tem gini entre 35 e 40, sendo 15 as variáveis 
# com gini de 35.

ggplot(banco, aes(gini10)) + 
  geom_boxplot()

# No boxplot é possível verificar o valor mínimo de 25 e valor máximo de 64. 
# O primeiro quartil se posiciona por voltar de 33, o segundo (que representa a 
# mediana) por volta de 39 e o terceiro quartil por volta de 47.

###############################################################################

# Utilizando as funções de manipulação de dados da aula passada,
# faça uma tabela que sumarize a media (função mean), 
# mediana (funcao median) e o desvio padrão (fundao sd) da 
# renda per capta (variável gdppcap08), agrupada por tipo de regime 
# (variável democ).
#
# Explique a diferença entre valores das médias e medianas.
#
# Ilustre com a explicação com gráfico de boxplot.
#
# Os dados corroboram a hipótese da relação entre democracia
# e desempenho economico?

banco %>%
  group_by(democ) %>%
summarise (media = mean(gdppcap08, na.rm = TRUE),
          mediana = median(gdppcap08, na.rm = TRUE),
          desvio_padrao = sd(gdppcap08, na.rm = TRUE)
          )

# As médias são as médias aritméticas do conjunto de valores das variáveis.
# Calculada pela soma de todos os valores divida pelo número de variáveis.
# No caso da tabela a média da renda per capita dos países não democráticos é de 
# 9243, enquanto a média de renda per capita de países democráticos é de 16351.
# As medianas são os valores presentes na posição que separa a metade dos menores
# valores da metade dos maiores valores, localizada no segundo quartil. 
# No caso dos países não democráticos a mediana se encontra em 4388, já para os 
# países democráticos se encontra em 11660.

ggplot(banco, aes(x = gdppcap08, y = democ)) + 
  geom_boxplot()

# Pela análise do gráfico é possível verificar que os países democráticos têm 
# maior renda per capita que países não democráticos. Sendo possível inferir
# que o sistema democrático contribui para um melhor desempenho econômico.

################################################################################
#Carregue o banco states que está no pacote poliscidata 
# Mantenha apenas as variáveis obama2012, conpct_m, hs_or_more,
# prcapinc, blkpct10, south, religiosity3, state

banco1 <- states %>%
select (obama2012, conpct_m, hs_or_more, prcapinc, 
        blkpct10, south, religiosity3, state)

################################################################################
#Carregue o banco nes que está no pacote poliscidata
# Mantenha apenas as variáveis obama_vote, ftgr_cons, dem_educ3,
# income5, black, south, relig_imp, sample_state

banco2 <- nes %>%
  select(obama_vote,ftgr_cons, dem_educ3, income5, 
         black, south, relig_imp, sample_state)

################################################################################
# As variáveis medem os mesmos conceitos, voto no obama em 2012, 
# conservadorismo, educação, renda, cor, norte-sul, 
# religiosidade e estado. A diferença é que o nes é um banco de
# dados com surveys individuais e o states é um banco de dados
# com informações por estado
#
# Faça um gráfico para cada banco representando o nível de
# conservadorismo. Comente as conclusões que podemos ter
# a partir deles sobre o perfil do eleitorado estadunidense.
# Para ajudar, vocês podem ter mais informações sobre os bancos
# de dados digitando ?states e ?nes, para ter uma descrição das
# variáveis

?states
?nes

ggplot(banco1, aes(conpct_m)) +
  geom_density()

ggplot(banco2, aes(ftgr_cons)) +
  geom_density()

# A partir das curvas de densidade é possivel concluir que o eleitorado 
# estadunidense tem um alto nível de conservadorismo nos estados formando uma 
# curva normal. No entanto, a análise dos surveys individuais aponta pra um 
# baixo número de indivíduos com alto nível de conservadorismo formando um pico 
# na curva de densidade. Enquanto a uma maior distribuição de níveis medianos de 
# conservadorismo entre o restante de indivíduos.

################################################################################
# Qual é o tipo de gráfico apropriado para descrever a variável
# de voto em obama nos dois bancos de dados?
# Justifique e elabore os gráficos

# Para o banco de dados dos estados, pela variável do voto em Obama ser contínua,
# o melhor tipo de gráfico para ilustrá-la seria o histograma ou a curva de 
# densidade. Já no banco de dados individual, pela variavel do voto em Obama ser
# representada em 0 ou 1 que pode ser categorizada em "Não" ou "Sim", o melhor 
# tipo de gráfico para descrevê-la seria o gráfico de barras.

ggplot(banco1, aes(obama2012)) +
  geom_density()

ggplot(banco2, aes(obama_vote)) +
  geom_bar(na.rm = T)

################################################################################
# Crie dois bancos de dados a partir do banco nes, um apenas com
# respondentes negros e outro com não-negros. A partir disso, faça
# dois gráficos com a proporção de votos no obama.
# O que você pode afirmar a partir dos gráficos?
# Você diria que existe uma relação entre voto em Obama e cor?

res_negros <- banco2 %>%
  filter(black == "Yes")

ggplot(res_negros, aes(obama_vote)) +
  geom_bar(na.rm = T)

res_n_negros <- banco2 %>%
  filter(black != "Yes")

ggplot(res_n_negros, aes(obama_vote)) +
  geom_bar(na.rm = T)

# O gráfico que apresenta os respondentes negros mostra que uma ínfima parte da
# população negra não votou em Obama. Sendo praticamente a totalidade de votos
# de negros para Obama. Já o gráfico sobre os respondentes não negros, mostra uma
# divisão quase igualitária entre os que não votaram em Obama e os que votaram.
# Assim, é possível inferir que existe sim, uma relação entre o voto em Obama
# e a cor da pele. Pois a população negra votou em bloco em Obama, enquanto a 
# não negra se dividiu na metade que votou e metade que não votou em Obama.


################################################################################
# A partir do banco de dados states, faça uma comparação semelhante.
# Faça um gráfico com as porcentagens de votos em Obama para estados
# que estão acima da mediana da porcentagem de população negra nos estados,
# e outro gráfico com as porcentagens de votos em Obama para os estados
# que estão abaixo da mediana de população negra.
# O que você pode afirmar a partir dos gráficos?
# Podemos chegar a mesma conclusão anterior?

ac_med <- banco1 %>%
  filter (blkpct10 > median(blkpct10))

ggplot(ac_med, aes(obama2012)) +
  geom_histogram()

ggplot(ac_med, aes(obama2012)) +
  geom_density()

ab_med <- banco1 %>%
  filter (blkpct10 < median (blkpct10))

ggplot(ab_med, aes(obama2012)) +
  geom_histogram()

ggplot(ab_med, aes(obama2012)) +
  geom_density()

# Para os estados com porcentagem maior de negros a distribuição de votos em 
# Obama é maior, sendo significativa pra maior parte dos estados. Para os 
# estados com porcentagem menor de negros a maioria dos estados tem pouca 
# ocorrência de votos em Obama. No entanto, há uma disparidade em um dos estados
# o Havaí, que é o estado em que Obama nasceu o que explica a alta porcentagem
# de votos. De modo geral, é possível concluir que os gráficos sobre os estados
# confirmam os dados dos surveys de indivíduos, visto que há explicação 
# plausível para a ocorrência da disparidade. 

################################################################################
# A partir da varíavel X do banco df abaixo
df <- data.frame(x = cos(seq(-50,50,0.5)))
# Faça os tipos de gráficos que representem esse tipo de variável
# comentando as diferenças entre elas e qual seria a mais adequada

ggplot(df, aes(x)) +
  geom_histogram()

ggplot(df, aes(x)) +
  geom_density()

ggplot(df, aes(x)) + 
  geom_boxplot()

ggplot(df, aes(x = "", y = x)) + 
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75))

install.packages("ggbeeswarm")
library(ggbeeswarm)

ggplot(df, aes("",x)) +
  geom_beeswarm()

# Para se verificar a ocorrência (ou contagem) das variáveis podemos utilizar os
# gráficos de tipo histograma e de curva de densidade. No caso das variáveis do
# df, a melhor escolha seria o histograma que proporciona uma visualização mais 
# detalhada da distribuição das variáveis. A cruva de densidade não proporciona
# a mesma visualização por suavizar demais as discrepâncias;
# Para fazer a checagem das posições da variáveis (quartis) a melhor escolha de 
# gráficos seria o boxplot e o tipo violino, ambos de fácil visualização. 
# O boxplot, no entanto é o mais explícito em relação a identificação de valores
# e posições das variáveis;
# O gráfico de pontos parece não ser uma boa escolha, pois é de difícil 
# visualização das variáveis e suas posições, pois os pontos se encontram muito
# próximos um do outro o que não permite uma análise detalhada dos dados.

################################################################################
# responsa as questões teóricas abaixo

# Observar a figura 1.2 do livro Fundamentals of Political Research e fazer o 
# mesmo esquema para o trabalho final de vocês.

#Cred. da Mídia Tradicional--rel. negativa---> Cred. da Mídia Alternativa
#      |                                                            |
#     |                                                            |
#(operacionalização)                                     (operacionalização)
#    |                                                            |
#   |                                                            |
#Nível de credibilidade--Hipótese--> Nível de credibilidade da mídia alternativa
#(Surveys - %)                                            (Surveys %)

# Qual é a disponibilidade de dados para sua pesquisa? Já existem bancos de dados
# prontos? Você tem acesso a eles? Caso a última pergunta seja positiva, 
# responda o exercício 4 do capítulo 5 

# Bancos de dados:
  
# Latino Barômetro: 
  
#1)	Confiança no Judiciário (1.- A lot of confidence 2.- Some confidence 
# 3.- Little confidence 4.- No confidence at all -1-.- Don´t know -2-.- No answer
# /Refused -3-.- Not applicable -4-.- Not asked ) - Variável categórica;

#2)	Credibilidade da mídia (How much confidence do you have that they operate to
# improve our quality of life: Media 1.- A lot of confidence 2.- Some confidence 
# 3.- Little confidence 4.- No confidence at all -1-.- Don´t know -2-.- No answer
# /Refused -3-.- Not applicable -4-.- Not asked) - Variável categórica;

#3)	Informação sobre assuntos políticos (Cómo se informa de los asuntos políticos
# * Los amigos * Compañeros de trabajo * Mis compañeros de estudio * Por la radio 
# * Por los diarios/revistas * Medios electrónicos/internet * Por la televisión *
# * Facebook * Twitter * Youtube * Otro * - Ninguno 0.- Not mentioned; 
# * 1.- Mentioned -4-.- Not asked) - Variável Categórica;

#4)	Benefícios da Tecnologia (Do you think that technology is beneficial or 
# harmful to your use? 1.- Beneficial 2.- Harmful 8.- Do not know enough to say 
# -1-.- Don´t know -2-.- No answer -3-.- Not applicable -4-.- Not asked -5-.
# - Missing) - Variável Categórica;

#5)	Credibilidade do Judiciário (Groups of people-acts of corruption: Judges and
# magistrates 1.- None 2.- Some 3.- Almost every 4.- Everyone -1-.- Don't know -
# 2-.- No answer -4-.- Not asked) - Variável Categórica;

#6)	Corrupção no Poder Judiciário (Groups of people-acts of corruption: Judges 
# and magistrates 1.- None 2.- Some 3.- Almost every 4.- Everyone -1-.- Don't 
# know -2-.- No answer -4-.- Not asked) - Variável Categórica;


# V-dem:
  
#1)	Politização da Mídia Mainstream (Print/broadcast media critical - Question: 
# Of the major print and broadcast outlets, how many routinely criticize the 
# government? Responses: 0: None. 1: Only a few marginal outlets. 2: Some 
# important outlets routinely criticize the government but there are other 
# important outlets that never do. 3: All major media outlets criticize the 
# government at least occasionally.) - Variável Categórica;

#2)	Perspectivas Políticas da Mídia (Print/broadcast media perspectives - 
# Question: Do the major print and broadcast media represent a wide range of 
# political perspectives? Responses: 0: The major media represent only the 
# government's perspective. 1: The major media represent only the perspectives 
# of the government and a governmentapproved, semi-official opposition party. 
# 2: The major media represent a variety of political perspectives but they 
# systematically ignore at least one political perspective that is important in 
# this society. 3: All perspectives that are important in this society are 
# represented in at least one of the major media) - Variável Categórica;

#3)	Censura da Mídia (Media self-censorship - Question: Is there self-censorship
# among journalists when reporting on issues that the government considers 
# politically sensitive? Responses: 0: Self-censorship is complete and thorough.
# 1: Self-censorship is common but incomplete. 2: There is self-censorship on a 
# few highly sensitive political issues but not on moderately sensitive issues. 
# 3: There is little or no self-censorship among journalists) - Variável 
# Categórica;

#4)	Parcialidade da Mídia (Media bias - Question: Is there media bias against 
# opposition parties or candidates? Clarification: We ask you to take particular
# care in rating the year-to-year variation on this question if media bias tends
# to increase or decrease in election years. Coverage can be considered "more or
# less impartial" when the media as a whole present a mix of positive and 
# negative coverage of each party or candidate. Responses: 0: The print and 
# broadcast media cover only the official party or candidates, or have no 
# political coverage, or there are no opposition parties or candidates to cover.
# 1: The print and broadcast media cover more than just the official party or 
# candidates but all the opposition parties or candidates receive only negative 
# coverage. 2: The print and broadcast media cover some opposition parties or 
# candidates more or less impartially, but they give only negative or no 
# coverage to at least one newsworthy party or candidate. 3: The print and 
# broadcast media cover opposition parties or candidates more or less 
# impartially, but they give an exaggerated amount of coverage to the governing 
# party or candidates. 4: The print and broadcast media cover all newsworthy 
# parties and candidates more or less impartially and in proportion to their 
# newsworthiness) - Variável Categórica;

#5)	Corrupção da Mídia (Media corrupt - Question: Do journalists, publishers, or
# broadcasters accept payments in exchange for altering news coverage? Responses:
# 0: The media are so closely directed by the government that any such payments 
# would be either unnecessary to ensure pro-government coverage or ineffective 
# in producing anti-government coverage. 1: Journalists, publishers, and 
# broadcasters routinely alter news coverage in exchange for payments. 2: It is 
# common, but not routine, for journalists, publishers, and broadcasters to 
# alter news coverage in exchange for payments. 3: It is not normal for 
# journalists, publishers, and broadcasters to alter news coverage in exchange 
# for payments, but it happens occasionally, without anyone being punished. 4: 
# Journalists, publishers, and broadcasters rarely alter news coverage in 
# exchange for payments, and if it becomes known, someone is punished for it.) -
# Variável Categórica;

#6)	Governo e Internet (Government Internet filtering capacity. Question: 
# Independent of whether it actually does so in practice, does the government 
# have the technical capacity to censor information (text, audio, images, or 
# video) on the Internet by filtering (blocking access to certain websites) if 
# it decided to? Responses: 0: The government lacks any capacity to block access
# to any sites on the Internet. 1: The government has limited capacity to block 
# access to a few sites on the Internet. 2: The government has adequate capacity
# to block access to most, but not all, specific sites on the Internet if it 
# wanted to. 3: The government has the capacity to block access to any sites on 
# the Internet if it wanted to) - Variável Categórica;

#7)	Filtro do Governo na Internet (Government Internet filtering in practice. 
# Question: How frequently does the government censor political information 
# (text, audio, images, or video) on the Internet by filtering (blocking access 
# to certain websites)? Responses: 0: Extremely often. It is a regular practice 
# for the government to remove political content, except to sites that are 
# pro-government. 1: Often. The government commonly removes online political 
# content, except sites that are pro-government. 2: Sometimes. The government 
# successfully removes about half of the critical online political content. 
# 3: Rarely. There have been only a few occasions on which the government 
# removed political content. 4: Never, or almost never. The government allows 
# Internet access that is unrestricted, with the exceptions mentioned in the 
# clarifications section.) - Variável Categórica;

#8)	Governo e redes sociais (Government social media alternatives. Question: 
# How prevalent is the usage of social media platforms that are wholly 
# controlled by either the government or its agents in this country? Responses: 
# TOC 301 Digital Society Survey 6.2 Digital Media Freedom 0: Essentially all 
# social media usage takes place on platforms controlled by the state. 1: Most 
# usage of social media is on state-controlled platforms, although some groups 
# use nonstate-controlled alternatives. 2: There is significant usage of both 
# state-controlled and non-state-controlled social media platforms. 3: While 
# some state-controlled social media platforms exist, their usage only represents
# a small share of social media usage in the country. 4: Practically no one uses
# state-controlled social media platforms.) - Variável Categórica;

#9)	Monitoramento pelo Governo de redes sociais (Government social media 
# monitoring. Question: How comprehensive is the surveillance of political 
# content in social media by the government or its agents? Responses: 0: 
# Extremely comprehensive. The government surveils virtually all content on 
# social media. 1: Mostly comprehensive. The government surveils most content on
# social media, with comprehensive monitoring of most key political issues. 2: 
# Somewhat comprehensive. The government does not universally surveil social 
# media but can be expected to surveil key political issues about half the time.
# 3: Limited. The government only surveils political content on social media on 
# a limited basis. 4: Not at all, or almost not at all. The government does not 
# surveil political content on social media, with the exceptions mentioned in 
# the clarifications section.) - Variável Categórica;

#10)	Censura de redes sociais (Government social media censorship in practice. 
# Question: To what degree does the government censor political content (i.e., 
# deleting or filtering specific posts for political reasons) on social media in
# practice? Responses: 0: The government simply blocks all social media platforms.
# 1: The government successfully censors all social media with political content.
# 2: The government successfully censors a significant portion of political 
# content on social media, though not all of it. 3: The government only censors 
# social media with political content that deals with especially sensitive issues.
# 4: The government does not censor political social media content, with the 
# exceptions mentioned in the clarifications section.) - Variável Categórica;

#11)	Capacidade de segurança cibernética pelo Governo (Government cyber security
# capacity. Question: Does the government have sufficiently technologically 
# skilled staff and resources to mitigate harm from cyber-security threats? 
# Responses: 0: No. The government does not have the capacity to counter even 
# unsophisticated cyber security threats. 1: Not really. The government has the 
# resources to combat only unsophisticated cyber attacks. 2: Somewhat. The 
# government has the resources to combat moderately sophisticated cyber attacks.
# 3: Mostly. The government has the resources to combat most sophisticated cyber
# attacks. 4: Yes. The government has the resources to combat sophisticated cyber
# attacks, even those launched by highly skilled actors.) - Variável Categórica;

#12)	Proteção por difamação (Defamation protection, Question: Does the legal 
# framework provide protection against defamatory online content, or hate 
# speech? Responses: 0: No. The law provides no protection against Internet 
# defamation and hate speech. 1: Not really. The law provides a weak protection 
# and to very limited range of circumstances. 2: Somewhat. The law provides some
# protection against Internet defamation and hate speech but in limited 
# circumstances, or only to particular groups of people. 3: Mostly. The law 
# provides protection against Internet defamation and hate speech under many 
# circumstances, and to most groups of people. 4: Yes. The law provides 
# comprehensive protection against Internet defamation and hate speech.) 
# Variável Categórica;

#13)	Perspectivas de Mídia Online (Online media perspectives. Question: Do the 
# major domestic online media outlets represent a wide range of political 
# perspectives? Responses: 0: The major domestic online media outlets represent 
# only the government's perspective. 1: The major domestic online media outlets 
# represent only the perspectives of the government and a government approved, 
# semi-official opposition party. 2: The major domestic online media outlets 
# represent a variety of political perspectives but they systematically ignore 
# at least one political perspective that is important in this society. 3: All 
# perspectives that are important in this society are represented in at least 
# one of the major domestic online media outlets. 4: All perspectives that are 
# important in this society are represented in many major domestic online media 
# outlets.) - Variável Categórica;

#14)	Fragmentação da mídia online (Online media fractionalization. Question: 
# Do the major domestic online media outlets give a similar presentation of 
# major (political) news? Responses: 0: No. The major domestic online media 
# outlets give opposing presentation of major events. 1: Not really. The major 
# domestic online media outlets differ greatly in the presentation of major 
# events. 2: Sometimes. The major domestic online media outlets give a similar 
# presentation of major events about half the time. 3: Mostly. The major 
# domestic online media outlets mostly give a similar presentation of major 
# events. 4: Yes. Although there are small differences in representation, the 
# major domestic online media outlets give a similar presentation of major 
# events.) - Variável Categórica;

#15)	Tipos de Organização por meio de redes sociais (Types of organization 
# through social media. Question: What types of offline political action are 
# most commonly mobilized on social media? Clarification: Multiple selection. 
# Choose all that apply. Responses: 0: Petition signing [v2smorgtypes_0] 1: 
# Voter turnout [v2smorgtypes_1] 2: Street protests [v2smorgtypes_2] TOC 309 
# Digital Society Survey 6.5 Social Cleavages 3: Strikes/labor actions 
# [v2smorgtypes_3] 4: Riots [v2smorgtypes_4] 5: Organized rebellion 
# v2smorgtypes_5] 6: Vigilante Justice (e.g., mob lynching, stalking harassment)
# [v2smorgtypes_6] 7: Terrorism [v2smorgtypes_7] 8: Ethnic cleansing/genocide 
# [v2smorgtypes_8] 9: Other (specify in the next question))- Variável Categórica;


#16)	Partidos Políticos e Discurso de Ódio (Political parties hate speech. 
# Question: How often do major political parties use hate speech as part of 
# their rhetoric? Clarification: Hate speech is any speech that is intended 
# to insult, offend, or intimidate members of specific groups, defined by race,
# religion, sexual orientation, national origin, disability, or similar trait. 
# Responses: 0: Extremely often. 1: Often. 2: Sometimes. 3: Rarely. 4: Never, 
# or almost never.) - Variável Categórica;

#17)	Polarização da sociedade (Polarization of Society. Question: How would you
# characterize the differences of opinions on major political issues in this 
# society? Clarification: While plurality of views exists in all societies, we 
# are interested in knowing the extent to which these differences in opinions 
# result in major clashes of views and polarization or, alternatively, whether 
# there is general agreement on the general direction this society should 
# develop. Responses: 0: Serious polarization. There are serious differences in
# opinions in society on almost all key political issues, which result in major 
# clashes of views. 1: Moderate polarization. There are differences in opinions 
# in society on many key political issues, which result in moderate clashes of 
# views. 2: Medium polarization. Differences in opinions are noticeable on about
# half of the key political issues, resulting in some clashes of views. 3: 
# Limited polarization. There are differences in opinions on only a few key 
# political issues, resulting in few clashes of views. 4: No polarization. 
# There are differences in opinions but there is a general agreement on the 
# direction for key political issues.) - Variável Categórica.

# A partir dos exercícios anteriores, escreva sobre a confiabilidade e validade 
# de suas variáveis.

# Devido à maioria dos dados sobre credibilidade poderem ser somente medidos 
# através de surveys qualitativos em que perguntas são feitas à indivíduos de 
# determinado território a validade e confiabilidade dos dados fica prejudicada. 
# No entanto, os surveys servem de termômetro para medir como a população se 
# posiciona em relação a determinado assunto. Portanto, apesar dos dados 
# coletados não serem totalmente confiáveis são válidos para verificar situação 
# empírica de credibilidade da mídia.

# Qual seria a forma ideal e mais adequada de operacionalizar suas variáveis para
# testar sua hipótese?

# Por serem variáveis categóricas a operacionalização dos dados deverá se dar 
# conceitualmente, comparando os níveis de credibilidade para cada mídia e 
# inferindo conclusões a partir do arcabouço teórico, com a utilização de 
# gráficos de barras para ilustrar os dados analisados.
