# Big Data na Prática - Análise de Séries Temporais no Mercado Financeiro

#Pacote Utilizado

# http://www.quantmod.com


# Instalar e carregar os pacotes
install.packages("quantmod")
install.packages("xts")
install.packages("moments")
library(quantmod)
library(xts)
library(moments)


# Seleção do período de análise
# Conversão para formato de data
startDate = as.Date("2010-01-21")
endDate = as.Date("2022-05-01")


# Download dos dados do período
# rds é um arquivo, espécie de banco de dados, caso dê erro na primeira linha de código
# Utilize a de baixo
?getSymbols
getSymbols("AAPL", src = "yahoo", from = startDate, to = endDate, auto.assign = T)
# AAPL = readRDS("AAPL.rds")


# Checando o tipo de dado retornado
class(AAPL)
is.xts(AAPL)


# Mostra os primeiros registros para as ações da Petrobras
head(AAPL)
View(AAPL)


# Analisando os dados de fechamento 
# Utilizando Slicing, pegando todas as linhas mas apenas essa coluna
AAPL.Close <- AAPL[, "AAPL.Close"]
is.xts(AAPL.Close)
?Cl
head(Cl(AAPL),5)


# Agora, vamos plotar o gráfico da Apple
# Gráfico de candlestick 
?candleChart
candleChart(AAPL)


# Plot do fechamento
plot(AAPL.Close, main = "Fechamento Diário Ações Apple",
     col = "blue", xlab = "Data", ylab = "Preço", major.ticks = 'months',
     minor.ticks = FALSE)


# Adicionado as bandas de bollinger ao gráfico, com média de 20 períodos e 2 desvios
# Bollinger Band
# Como o desvio padrão é uma medida de volatilidade, 
# Bollinger Bands ajustam-se às condições de mercado. Mercados mais voláteis, 
# possuem as bandas mais distantes da média, enquanto mercados menso voláteis possuem as
# bancas mais próximas da média
?addBBands
addBBands(n = 20, sd = 2)


# Adicionando o indicador ADX, média 11 do tipo exponencial
?addADX
addADX(n = 11, maType = "EMA")


# Calculando logs diários
?log
AAPL.ret <- diff(log(AAPL.Close), lag = 1)


# Remove valores NA na prosição 1
AAPL.ret <- AAPL.ret[-1] 


# Plotar a taxa de retorno
plot(AAPL.ret, main = "Fechamento Diário das Ações da Apple",
     col = "blue", xlab = "Data", ylab = "Retorno", major.ticks = 'months',
     minor.ticks = FALSE)


# Calculando algumas medidas estatísticas
# Obs: Apenas da cotação de fechamento
statNames <- c("Mean", "Standard Deviation", "Skewness", "Kurtosis")
AAPL.stats <- c(mean(AAPL.ret), sd(AAPL.ret), skewness(AAPL.ret), kurtosis(AAPL.ret))
names(AAPL.stats) <- statNames
AAPL.stats


# Salvando os dados em um arquivo .rds (arquivo em formato binário do R)
# getSymbols("AAPL", src = 'yahoo')
saveRDS(AAPL, file = "AAPL.rds") # Salva os dados em formato binário
Aple = readRDS("AAPL.rds")
dir()
head(Aple)








