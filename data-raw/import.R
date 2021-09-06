library(tidyverse)

import_delim_path <- function(path, delim, header) {
  type <- readr::cols(.default = readr::col_character())
  file <- readr::read_delim(path, delim, col_types = type, col_names = header,
                            trim_ws = TRUE)
  
  if (nrow(file) * ncol(file)) return(file)
  stop("File is empty")
}

import_delim_file <- function(file, content, info) {
  if (is.null(content)) lhs <- rhs <- 0
  else {
    lhs <- content[1]
    rhs <- content[2]
  }
  
  # validate
  . <- NULL
  end <- ncol(file)
  if (lhs < 1 || lhs > end) lhs <- min(2, end)
  if (rhs < 1 || rhs > end) rhs <- end
  
  # extract
  info <- if (is.null(info) || info < 1 || info > end) character(1)
  else file %>% dplyr::pull(info) %>% replace(is.na(.), "")
  
  # process
  file %>%
    dplyr::select(name = 1, data_ = dplyr::all_of(lhs:rhs)) %>%
    tibble::add_column(info = info)
}

import_annotations_file <- function(anno_file, content, info) {
  anno_file %>%
    import_delim_file(content, info) %>%
    dplyr::rename(anno_ = dplyr::starts_with("data_"))
}

import_annotations <- function(path, delim, header, content = NULL, info = NULL) {
  path %>%
    import_delim_path(delim, header) %>%
    import_annotations_file(content, info)
}

import_database_file <- function(data_file, content, info) {
  none <- as.factor("Not assigned")
  proc <- data_file %>%
    import_delim_file(content, info) %>%
    tibble::add_column(category = none, organism = none)
  
  # extract
  gs_info <- proc %>% dplyr::select(!dplyr::starts_with("data_"))
  gs_genes <- proc %>%
    dplyr::select(dplyr::starts_with("data_")) %>%
    purrr::pmap(c, use.names = F) %>%
    purrr::map(~.[!is.na(.)]) %>%
    purrr::set_names(gs_info$name)
  
  list(gs_genes = gs_genes, gs_info = gs_info)
}

import_database <- function(path, delim, header, content = NULL, info = NULL) {
  path %>%
    import_delim_path(delim, header) %>%
    import_database_file(content, info)
}

annotations <- import_annotations("data-raw/annotations.csv", ",", TRUE, c(2, 15), 17)
database <- import_database("data-raw/database.csv", ",", FALSE)

usethis::use_data(annotations, overwrite = TRUE)
usethis::use_data(database, overwrite = TRUE)
