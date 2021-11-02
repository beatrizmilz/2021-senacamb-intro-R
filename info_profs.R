library(magrittr)
tibble::tribble(
  ~ url_foto,
  ~ nome,
  ~ atividade,
  ~ url_github,
  ~ url_twitter,
  ~ url_facebook,
  ~ url_site,
  ~ mini_bio
) %>%


  # Infos BEA
  tibble::add_row(
    url_foto = "https://beatrizmilz.com/about/sidebar/avatar.jpeg",
    nome = "Beatriz Milz",
    atividade = "Docente",
    url_github = "https://github.com/beatrizmilz",
    url_twitter = "https://twitter.com/BeaMilz",
    url_site = "https://beatrizmilz.com/",
    mini_bio = "- Doutoranda em Ciência Ambiental na
    Universidade de São Paulo (PROCAM/IEE/USP). <br>
    - Instrutora de tidyverse certificada pela RStudio.<br>
    - Co-organizadora da R-Ladies São Paulo, uma comunidade que tem como
    objetivo promover a diversidade de gênero na comunidade da linguagem R. <br>
    "
  ) %>%



  readr::write_rds("info_profs.Rds")
