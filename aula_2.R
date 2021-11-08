# Aula 2 ------------------------------------------------------------------
# Objetivos: apresentar algumas funções básicas
# que fazem parte do tidyverse

# Carregar pacotes --------------------------------------------------------
library(tidyverse)


# Importar (ler) os dados -------------------------------------------------

dados <- read_csv2("dados/dados_reservatorios_cantareira.csv")


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

# 1) IMPORTAÇÃO - Leia a base de dados nomes_reservatorios.csv
# essa base está na pasta dados/
# e salve em um objeto chamado reservatorios_bruto



# 2) Observe a base usando glimpse(). Quantas colunas a base tem?
# Quantas linhas a base tem?





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
    -vazao_vertida_m3_s,-vazao_turbinada_m3_s,-vazao_natural_m3_s,-vazao_incremental_m3_s
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


# Exercícios --------------------------------------------------------------


# 3) ARRUMAÇÃO. Identifique 2 possíveis necessidades de correções
# no tipo de dado armazenado nas colunas da base.
# Com mutate(), faça as correções e salve em um objeto
# chamado reservatorios.
# com a função glimpse(), verifique se está correto.





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

# 4b)  o contrário? E em qual ano esteve com os maiores niveis de
# volume util percentual?



## group_by() ------------------------------------------


dados_mes_ano <- dados %>%
  mutate(mes = lubridate::month(data),
         ano= lubridate::year(data))

# agrupar por uma variável
dados_mes_ano %>%
  group_by(reservatorio)

# agrupar por mais de uma variável
dados_mes_ano %>%
  group_by(reservatorio,  ano, mes)

## summarize() -----------------------------


dados %>%
  # contar linhas!
  summarise(n = n())

dados %>%
  # calcular a média de volume util considerando a base toda!
  summarise(media_volume_util_percentual = mean(volume_util_percentual))


# podemos fazer uma sumarização
dados_mes_ano %>%
  # agrupar por duas variáveis
  group_by(reservatorio, mes_ano) %>%
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
  ungroup()

# Exportar a base dados_mensais ------

write_csv2(dados_mensais,
           "dados_exportados/dados_cantareira_mensais.csv")

writexl::write_xlsx(dados_mensais,
                    "dados_exportados/dados_cantareira_mensais.xlsx")




# Exercícios --------------------------------------------------------------



# Resposta dos exercícios -------------------------------------------------

# 1)
reservatorios_bruto <- read_csv2("dados/nomes_reservatorios.csv")

# 2)
glimpse(reservatorios_bruto) # dar uma olhada na base
nrow(reservatorios_bruto) # número de linhas
ncol(reservatorios_bruto) # número de colunas


# 3)
reservatorios <- reservatorios_bruto %>%
  mutate(codigo_municipio_ibge = as.character(codigo_municipio_ibge),
         codigo = as.character(codigo))

glimpse(reservatorios)


# 4) a)

dados %>%
  select(data, reservatorio, volume_util_percentual) %>%
  filter(reservatorio == "Atibainha") %>%
  arrange(volume_util_percentual)


# 4) b)
dados %>%
  select(data, reservatorio, volume_util_percentual) %>%
  filter(reservatorio == "Atibainha") %>%
  arrange(desc(volume_util_percentual))



reservatorios %>%
  group_by(estado_sigla, reservatorio) %>%
  summarise(contagem = n()) %>%
  arrange(desc(contagem))


