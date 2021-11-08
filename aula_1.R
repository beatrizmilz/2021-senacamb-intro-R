# Introdução à linguagem R - Script
# Esse script acompanha a apresentação disponível em:
# https://beatrizmilz.github.io/2021-senacamb-intro-R/

# Para executar o código:

# - Clique na linha e aperte Ctrl + Enter

# - Selecione um trecho de código
# e aperte Ctrl + Enter



# Operações matemáticas ---------

2 + 5    # adição

9 - 4    # subtração

5 * 2    # multiplicação

7 / 5    # divisão

9 %% 4   # resto da divisão de 9 por 4

7 %/% 4  # parte inteira da divisão de 7 por 4

8 ^ 2    # potenciação

# Funções matemáticas ------

sqrt(1024) # radiciação

sin(1)  # funções trigonométricas

log(1)  # logaritmo natural (base e)

log10(10) # logaritmo na base 10

exp(0.5) # e^(1/2)

# Objetos -------

minha_idade <- 27

minha_idade

minha_idade + 1

minha_idade # Qual é o resultado esperado?

# Buscando ajuda no R?------------

help(sum)

?sum # equivalente à função help()
??sum # Faz uma pesquisa mais ampla

## Exemplos ---

nome <- "Daenerys Targaryen"
nome

horas_trabalhadas <- 160
horas_trabalhadas

salario <- 3984.23
salario

ativo <- TRUE
ativo

# Funções -------

# Combinar elementos - Função c()
ano_nascimento_irmaos <- c(1993, 1998, 2001,
                           2012, 2012)


# Podemos fazer operações com o resultado
idade_irmaos <- 2020 - ano_nascimento_irmaos
idade_irmaos

# Calculando a média - Função mean()
media_idade_irmaos <- mean(idade_irmaos)
media_idade_irmaos


## Argumento das funções ------

# Arredondar valores - função round()
# help(round)
# round(x, digits = 0)
round(media_idade_irmaos)
round(media_idade_irmaos, digits = 1)

## Outras funções interessantes

# Sortear números

numeros_sorteados <- sample(1:50, 10)
numeros_sorteados

sum(numeros_sorteados)	#Soma
mean(numeros_sorteados)	#Média
median(numeros_sorteados)	# Mediana
var(numeros_sorteados)	# Variância (simples)
sd(numeros_sorteados)	# Desvio Padrão
max(numeros_sorteados)	# Valor máximo
min(numeros_sorteados)	# Valor mínimo


pi # número Pi - com 6 casas decimais

round(pi)	   # Valor arredondado com 0 casas decimais
round(pi, 1) # Valor arredondado com 1 casas decimais
round(pi, 2) # Valor arredondado com 2 casas decimais
round(pi, 3) # Valor arredondado com 3 casas decimais
round(pi, 4) # Valor arredondado com 4 casas decimais
round(pi, 5) # Valor arredondado com 5 casas decimais


# Operadores relacionais ------------


#   Igual a: ==

TRUE == TRUE

TRUE == FALSE

#   Diferente de: !=

TRUE != TRUE

TRUE != FALSE


#   Maior que: >

3 < 5


#   Maior ou igual: >=

10 >= 10

#   Menor que: <

10 < 20

#   Menor ou igual: <=

10 > 10


# Operadores lógicos ----------

## & - E - Para ser verdadeiro, os dois lados
# precisam resultar em TRUE

x <- 5
x >= 3 & x <=7


y <- 2
y >= 3 & y <= 7

## | - OU - Para ser verdadeiro, apenas um dos
# lados precisa ser verdadeiro

y <- 2
y >= 3 | y <=7

y <- 1
y >= 3 | y == 0


## ! - Negação - É o "contrário"

!TRUE

!FALSE


w <- 5
(!w < 4)



# Tipos de dados ------------

# Números ----------

class(3L)

class(3)

class(3.1)

# Lógicos -----------

class(TRUE)

class(FALSE)

TRUE + TRUE + TRUE + FALSE

# Textos  -----------

class("TEXTO")

escola <- c("Fundamental", "Médio", "Superior")
class(escola)

class("3")


# Fatores ---------

# Criando factor
escola_categorias <- factor(c("Fundamental",
                              "Médio", "Superior"))
escola_categorias


class(escola_categorias)

# Exercícios


# 1)Primeiro, tente adivinhar o tipo de dado
# dos objetos abaixo:

cor_favorita <- "rosa"
idade <- 27L
altura <- "1.75"
peso <- 61.1
gosta_brocolis <- TRUE
gosta_carne <- "FALSE"


# 2) Depois de adivinhar o resultado, use a função
# class() e descubra qual é o tipo dos objetos acima.


# class(cor_favorita)
# class(idade)
# class(altura)
# class(peso)
# class(gosta_brocolis)
# class(gosta_carne)

# NA -----------------

NA > 10

10 == NA

NA + 10

NA / 2

NA == NA

# Função is.na() verifica se é NA
vetor_numerico <- c(NA, 1, 5, 2, 5, NA)

is.na(vetor_numerico)

# E se quiser fazer contas com NA?
sum(vetor_numerico)
sum(vetor_numerico, na.rm = TRUE)

# Conversão de classes ---------------

# Funções que começam com as.
# as.numeric()
# as.integer()
# as.logical()
# as.character()
# as.factor()


vetor_logical <- c(TRUE, FALSE, TRUE, FALSE)
as.integer(vetor_logical)
as.numeric(vetor_logical)
as.character(vetor_logical)
as.factor(vetor_logical)


frutas <- c("banana", "maçã", "melancia")
as.integer(frutas)
as.numeric(frutas)
as.character(frutas)
as.factor(frutas)

# Tipos de objetos------------

## Vetores -------

# Para vetores de 1 elemento,
# não é necessário usar a função c()
mes_1 <- "Janeiro"

# Para criar um vetor com mais de 1 elemento,
# utilize a função c()
primeiro_semestre <- c("Janeiro", "Fevereiro", "Março",
                       "Abril", "Maio", "Junho")

# Retorna o comprimento do vetor
# quantos elementos ele tem?
length(primeiro_semestre)


## Data.frames ----------

# Abaixo segue o código para carregar a base que
# vamos usar:
airquality

# Retorna o número de colunas
ncol(airquality)

# Retorna o número de linhas
nrow(airquality)

# Retorna o número de colunas e linhas
dim(airquality)

# Retorna algumas informações sobre a base
str(airquality)
summary(airquality)

# Primeiras 6 linhas de uma tabela
head(airquality)

# Últimas 6 linhas de uma tabela
tail(airquality)

### Dataframes e funções ------------
# Soma
sum(airquality$Ozone, na.rm = TRUE)

# Menor valor encontrado
min(airquality$Ozone, na.rm = TRUE)

# Maior valor encontrado:
max(airquality$Ozone, na.rm = TRUE)


# Média
mean(airquality$Ozone, na.rm = TRUE)

# Mediana
median(airquality$Ozone, na.rm = TRUE)

# Variância
var(airquality$Ozone, na.rm = TRUE)

# Desvio padrão
sd(airquality$Ozone, na.rm = TRUE)



# Instalar pacotes! -------------------

## Instalar pacotes do CRAN ------------

# É necessário usar a função
# install.packages("nome_do_pacote") - USAR ASPAS!

install.packages("tidyverse") # Não execute agora.

# Vai demorar um montão!
# Pode fazer depois, no seu computador.

## Instalar Pacotes do GitHub ----------

# Para isso, é necessário usar uma função do pacote
# devtools.
# Então primeiro é necessário instalar esse pacote:

install.packages("devtools")  # Não execute agora.

# Depois use a função install_github().
# Você deve indicar entre aspas qual é o pacote
# que quer instalar,
# sendo neste padrão: "organizacao/pacote"
# (o pacote pode "ser" de alguma pessoa também)

devtools::install_github("tidyverse/dplyr")  # Não execute agora.


# Carregar pacotes --------------

# Use a função library(pacote), não é necessário
# usar aspas.


library(base)
