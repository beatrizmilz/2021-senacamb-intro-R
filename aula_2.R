# Aula 2 ------------------------------------------------------------------
# Objetivos: apresentar algumas funções básicas
# que fazem parte do tidyverse

# Carregar pacotes --------------------------------------------------------
# install.packages("tidyverse")
library(tidyverse)


# Importar (ler) os dados -------------------------------------------------

dados <- read_csv2("dados/dados_reservatorios_cantareira.csv")

# Dados do pacote reservatoriosBR
# https://brunomioto.github.io/reservatoriosBR/


# Observar a base ---------------------------------

# número de linhas
nrow(dados)

# número de colunas
ncol(dados)

# função View() - cuidado com bases grandes!

View(dados)

# resumo: quais são as principais colunas/dados no nosso arquivo?
glimpse(dados)


# Conceito importante: pipe %>% - usamos isso para usar funções
# sequencialmente! Assim fica mais fácil de entender a ordem.

dados %>% glimpse()

# Exercícios --------------------------------------------------------------

# 1) Leia a base de dados nomes_reservatorios.csv
# essa base está na pasta dados/
# e salve em um objeto chamado reservatorios_bruto



# 2) Observe a base reservatorios_bruto usando glimpse().
# Quantas colunas a base tem?
# Quantas linhas a base tem?
# Quais são as colunas da base?





# Arrumar a base de dados! -----------
# Com o que vimos de resultado do glimpse(),
# Precisamos pensar o que é interessante remover/alterar
# na base de dados para que esteja pronta para uso.

# 1) Remover colunas que não tem nenhum valor.

# 2) O código do reservatório está armazenado como número
# porém faz sentido armazenar como texto.


# Funções de manipulação ------------

## select() ------------------------------------------------
# para selecionar colunas --------
# isso afeta o número de colunas na base!
# podemos escrever de várias formas!

# Nesse exemplo: remover as colunas que não tem conteúdo

# apenas escrevendo as colunas que queremos selecionar
dados %>%
  select(
    data,
    codigo_reservatorio,
    reservatorio,
    cota_m,
    afluencia_m3_s,
    defluencia_m3_s,
    volume_util_percentual
  )

# usando : para criar sequências
dados %>%
  select(data:defluencia_m3_s, volume_util_percentual)

# usando - para remover colunas

dados %>%
  select(
    -vazao_vertida_m3_s,
    -vazao_turbinada_m3_s,
    -vazao_natural_m3_s,
    -vazao_incremental_m3_s
  )



## mutate() ----------------------------------

# podemos fazer operações usando colunas que já existem na base,
# e criar novas colunas!

dados %>%
  select(data, reservatorio, afluencia_m3_s, defluencia_m3_s) %>%
  mutate(saldo_afluencia = afluencia_m3_s - defluencia_m3_s)


# também podemos alterar colunas pré-existentes
dados %>%
  # transformar o codigo do reservatório em um texto
  mutate(codigo_reservatorio = as.character(codigo_reservatorio))


## Com esses conceitos, podemos pensar em como tratar
# as questões de arrumação da base dados!

# salvar o resultado: precisamos usar o sinal
# de atribuição <-

dados_arrumados <- dados %>%
  # selecionar as colunas que desejamos
  select(data:defluencia_m3_s, volume_util_percentual) %>%
  # transformar o codigo do reservatório em um texto
  mutate(codigo_reservatorio = as.character(codigo_reservatorio))

# ver os dados
glimpse(dados_arrumados)

# Exercícios --------------------------------------------------------------


# 3)  a) Identifique 2 possíveis necessidades de correções
# no tipo de dado armazenado nas colunas da base.
# Com mutate(), faça as correções e salve em um objeto
# chamado reservatorios.



# 3) b) com a função glimpse(), verifique se o resultado está correto.



## filter() ----------
# Podemos filtrar os dados. isso vai afetar o número de linhas!

# quero apenas as linhas onde reservatório seja igual à Atibainha
dados %>%
  filter(reservatorio == "Atibainha")

# e se eu quiser tudo que NÃO seja do reservatório Atibainha?

dados %>%
  filter(reservatorio != "Atibainha")


# podemos usar operadores!
# quero apenas as linhas onde a data seja maior ou igual à 1 de janeiro de 2021
# (ou seja, quero dados de 2021)
dados %>%
  filter(data >= "2021-01-01")


# operador %in% para filtrar valores que fazem parte de um conjunto
dados %>%
  filter(reservatorio %in% c("Paiva Castro", "Atibainha"))


## arrange() -------------
# podemos reordenar a base!
# por exemplo:

# ordenar de forma crescente
dados %>%
  arrange(data)

# ordenar de forma decrescente
dados %>%
  arrange(desc(data))


# Exercícios --------------------------------------------------------------

# 4) a) Em qual ano o reservatório atibainha
# esteve com o menor volume util percentual?

# 4 b)  o contrário? E em qual ano esteve com os maiores niveis de
# volume util percentual?



## group_by() ------------------------------------------

# criando as colunas mes e ano
dados_mes_ano <- dados_arrumados %>%
  mutate(mes = lubridate::month(data),
         ano = lubridate::year(data))

dados_mes_ano %>%
  distinct(reservatorio)



# agrupar por uma variável
dados_mes_ano %>%
  group_by(reservatorio)

# agrupar por mais de uma variável
dados_mes_ano %>%
  group_by(reservatorio,  ano, mes)

## summarize() -----------------------------


dados %>%
  # contar linhas!
  summarise(numero_de_linhas = n())

dados %>%
  # calcular a média de volume util considerando a base toda!
  summarise(media_volume_util_percentual = mean(volume_util_percentual))

# começando a unir group_by e summarise
dados %>%
  group_by(reservatorio) %>%
  summarise(numero_de_linhas = n())


# podemos fazer uma sumarização
dados_mes_ano %>%
  # agrupar por duas variáveis
  group_by(reservatorio, ano, mes) %>%
  # calcular a média de volume util considerando cada mes/ano e reservatorio
  summarise(media_volume_util_percentual = mean(volume_util_percentual)) %>%
  # remover os grupos
  ungroup()



# Mas também podemos fazer várias sumarizações
dados_mensais <- dados_mes_ano %>%
  group_by(reservatorio, ano, mes) %>%
  summarise(
    media_volume_util_percentual = mean(volume_util_percentual),
    soma_afluencia = sum(afluencia_m3_s),
    soma_defluencia = sum(defluencia_m3_s)
  ) %>%
  mutate(saldo = soma_afluencia - soma_defluencia) %>%
  # remover os grupos
  ungroup() %>%
  arrange(saldo)

# distinct() valores únicos! ---------

# remove linhas repetidas
dados %>% distinct()


# remove linhas repetidas
dados %>% distinct(reservatorio)

# Exportar a base dados_mensais ------

# exportar um csv2
write_csv2(dados_mensais,
           "dados_exportados/dados_cantareira_mensais.csv")


# exportar um arquivo excel
writexl::write_xlsx(dados_mensais,
                    "dados_exportados/dados_cantareira_mensais.xlsx")


# Exercícios/DESAFIO --------------------------------------------------------------
# 5)  Vamos buscar o número de reservatórios por estado,
# salvar em um objeto, e salvar o resultado no nosso computador
# em um arquivo excel!

# a) Faça uma sequência usando pipe, onde:
# usando os dados de reservatorios
  numero_reservatorios_por_estado <- reservatorios %>%
# agrupe por estado (a coluna se chama estado_sigla)
  ....   %>%
# busque os nomes distintos/únicos de reservatórios
  ....   %>%
# faça uma contagem do número de linhas
  ....   %>%
# ordene de forma decrescente pelo número de linhas
  ....


# b) Salve em um excel

......(numero_reservatorios_por_estado,
                    "dados_exportados/numero_reservatorios_por_estado.xlsx")

# Abra no seu computador o arquivo, para ver o resultado!
