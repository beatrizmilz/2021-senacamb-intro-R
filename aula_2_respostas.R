# Resposta dos exercícios -------------------------------------------------
# CARREGUE O PACOTE ANTES!

library(tidyverse)

# 1)
reservatorios_bruto <- read_csv2("dados/nomes_reservatorios.csv")

# 2)
glimpse(reservatorios_bruto) # dar uma olhada na base

# > glimpse(reservatorios_bruto) # dar uma olhada na base
# Rows: 804
# Columns: 12
# $ sistema               <chr> "nordeste_semiarido", "nordeste_semiarido", "nordeste_s…
# $ codigo                <dbl> 12001, 12002, 12003, 12004, 12005, 12006, 12007, 12008,…
# $ reservatorio          <chr> "25 DE MARÇO", "ABÓBORAS", "ACARAPE DO MEIO", "ACARAÚ M…
# $ res_latitude          <dbl> -6.110896, -8.087024, -4.193478, -3.506032, -7.441694, …
# $ res_longitude         <dbl> -38.21660, -39.42927, -38.79930, -40.27861, -35.56103, …
# $ municipio             <chr> "PAU DOS FERROS", "PARNAMIRIM", "REDENÇÃO", "MASSAPÊ", …
# $ codigo_municipio_ibge <dbl> 2409407, 2610400, 2311603, 2308005, 2507200, 2310803, 2…
# $ estado_nome           <chr> "Rio Grande do Norte", "Pernambuco", "Ceará", "Ceará", …
# $ estado_sigla          <chr> "RN", "PE", "CE", "CE", "PB", "CE", "BA", "BA", "BA", "…
# $ rio                   <chr> "RIACHO CAJAZEIRAS", "RIO SÃO DOMINGOS", "RIO PACOTI", …
# $ sub_bacia             <chr> "APODI/MOSSORÓ", "TERRA NOVA", "METROPOLITANA", "ACARAÚ…
# $ bacia                 <chr> "APODI/MOSSORÓ", "TERRA NOVA", "METROPOLITANA", "ACARAÚ…


# 3) a)
reservatorios <- reservatorios_bruto %>%
  # alterar o código do município e o código do reservatório para texto
  mutate(codigo_municipio_ibge = as.character(codigo_municipio_ibge),
         codigo = as.character(codigo))

# 3) b)
glimpse(reservatorios)


# 4) a) menor volume util
dados_cantareira <- read_csv2("dados/dados_reservatorios_cantareira.csv")

dados_cantareira %>%
  select(data, reservatorio, volume_util_percentual) %>%
  filter(reservatorio == "Atibainha") %>%
  arrange(volume_util_percentual)


# 4) b) maior volume util
dados_cantareira %>%
  select(data, reservatorio, volume_util_percentual) %>%
  filter(reservatorio == "Atibainha") %>%
  arrange(desc(volume_util_percentual))

# 5) a)
# usando os dados de reservatorios
numero_reservatorios_por_estado <- reservatorios %>%
  # agrupe por estado (a coluna se chama estado_sigla)
  group_by(estado_sigla) %>%
  # busque os nomes distintos/únicos de reservatórios
  distinct(reservatorio) %>%
  # faça uma contagem do número de linhas
  summarise(contagem = n()) %>%
  # ordene de forma decrescente pelo número de linhas
  arrange(desc(contagem))

# b)
writexl::write_xlsx(numero_reservatorios_por_estado,
                    "dados_exportados/numero_reservatorios_por_estado.xlsx")

