library(xml2)
library(rvest)
library(stringr)

# Amazon Vacuums scrapping

pag = "s?k=aspiradora&page=2&__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&qid=1566666064&ref=sr_pg_2"
list_pages = c(1:10)
pag <- str_replace(pag, "page=2", paste0("page=",list_pages))
pag <- str_replace(pag, "sr_pg_2", paste0("sr_pg_",list_pages))
pages <- paste0("https://www.amazon.es/",pag)


gettinglinks <- function(url){
  selector <- "div:nth-child(2) > div.sg-col-4-of-12.sg-col-8-of-16.sg-col-16-of-24.sg-col-12-of-20.sg-col-24-of-32.sg-col.sg-col-28-of-36.sg-col-20-of-28 > div > div:nth-child(1) > div > div > div:nth-child(1) > h2 > a"
  page <- read_html(url)
  noding <- html_nodes(page,selector)
  node_link <- html_attr(noding, "href")
  node_link
}

vacuums_links <- sapply(pages, gettinglinks)
partial_links <- as.vector(vacuums_links)
real_vacuums_links <- paste0("https://www.amazon.es/",partial_links)


get_article <- function(url){
  print('Starting fetching page...')
  print(url)
  name <- "#productTitle"
  website <- read_html(url)
  name_node <-html_node(website, name)
  name_text <- html_text(name_node)
  name_text <- str_remove_all(name_text,"\n")
  name_text <- str_remove(name_text,'\\s*')
  name_text <- str_remove(name_text,"(\\s)*$")
  
  
  opinions <-"#acrCustomerReviewText"
  opinions_node <-html_node(website, opinions)
  opinions_text <- html_text(opinions_node)
  
  price<-"#priceblock_ourprice"
  price_node <-html_node(website, price)
  price_text <- html_text(price_node)
  
  weight <- 0
  dimen <- 0
  volu <- 0
  pow <- 0
  
  table <- "#prodDetails > div > div.column.col1 > div > div.content.pdClearfix > div > div > table"
  table_nodes <- html_node(website, table)
  res_table = 0
  if(!is.na(table_nodes)){
    table_tab <- html_table(table_nodes)
    class(table_tab)
    val <- table_tab$X2
    res_table <- data.frame(t(val))
    table_name <-table_tab$X1
    colnames(res_table) <- table_name
  }
  
  if(res_table == 0){
    weight <- -1
    dimen <- -1
    volu <- -1
    pow <- -1
    print('Vacuum page fetched with errors!')
  }
  else{
    weight<- as.character(res_table$`Peso del producto`)
    if(length(weight) == 0) weight <- "-1"
    dimen<- as.character(res_table$`Dimensiones del producto` )
    if(length(dimen) == 0) dimen <- "-1"
    volu<- as.character(res_table$Volumen)
    if(length(volu) == 0) volu <- "-1"
    pow<- as.character(res_table$Potencia)
    if(length(pow) == 0) pow <- "-1"
    print('Vacuum page succesfully fetched!')
  }
  article <- c(name_text, price_text,opinions_text,as.character(weight),as.character(dimen),as.character(volu),as.character(pow))
  article 
  
}
 

raw_data <- sapply(real_vacuums_links,get_article)
raw_data <- as.data.frame(raw_data)
raw_data <- t(raw_data)
colnames(raw_data)<- c("Name","Price","Opinions","Product_Weight","Product_Dimensions","Volume","Power")

write.csv(raw_data,'raw_data.csv')

