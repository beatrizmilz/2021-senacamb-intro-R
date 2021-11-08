# Instalar pacotes necessários -------------------------------------------

# install.packages("devtools")
# devtools::install_github('brunomioto/reservatoriosBR')

# Carregar pacotes -------------------------------------------------------
library(reservatoriosBR)
library(dplyr)
library(magrittr)

# Buscar tabela de reservatórios ------------------------------------------


reservatorios <- reservatoriosBR::tabela_reservatorios()

readr::write_csv2(reservatorios, file = "dados/nomes_reservatorios.csv")


# Filtrar reservatórios do sistema Cantareira -----------------------------


reservatorios_cantareira <- reservatorios %>%
  dplyr::filter(sistema == "cantareira")


# Buscar dados para todos os reservatórios do sistema Cantareira ----------

dados_reservatorios_cantareira <- purrr::map_dfr(reservatorios_cantareira$codigo,
                                                 reservatorio_sin)


# Exportar os dados em um .csv ---------------------------------------------

readr::write_csv2(dados_reservatorios_cantareira,
                  file = "dados/dados_reservatorios_cantareira.csv")
