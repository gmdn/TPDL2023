library(tidyverse)
library(magick)
library(pdftools)
library(tesseract)
library(png)

volume <- "volume3"

#pdf_file <- paste0(getwd(), "/", volume, "/AlexandreMFRA_I.pdf")
#pdf_info <- pdftools::pdf_info(pdf = pdf_file)
#pdf_pages <- pdf_info$pages
# limit the 
pdf_pages <- 10

path <- paste0(getwd(), '/tessdata')
#tesseract_download("fra", path)
french <- tesseract("fra", datapath = path)

pattern <- "(_ )+|(__)+|(_—)+|(—_)+|(=)+|(._.)+|(…)+|(\\|)+"