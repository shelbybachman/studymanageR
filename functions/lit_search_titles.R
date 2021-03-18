########################################
# lit_search_titles() searches pubmed
# based on inputted query
# and returns a csv with results
# written by shelby bachman
# last updated 2021-03-17
########################################

lit_search_titles <- function(query, 
                              pubmed = TRUE,
                              wos = TRUE) {
  
  # query: a list containing your search query
  # with each list element containing groups of terms connected by ORs
  # the individual list elements are separated by ANDs
  # example:
  # query[[1]] <- 'affect OR emotion'
  # query[[2]] <- 'memory'
  # query[[3]] <- 'aging OR older adults'
  # NOTE: you must use booleans in capitals, either AND or OR permitted
  # NOTE: parentheses must surround term(s) separated by AND
  
  ### parse query
  
  ### search pubmed
  res_pm <- RISmed::EUtilsSummary("memory AND aging AND emotion AND selectivity", type = "esearch", 
                               db = "pubmed", datetype = 'pdat', 
                               mindate = 2000, maxdate = 2020, retmax = 500)
  get_pm <- RISmed::EUtilsGet(res_pm)
  d <- RISmed::DOI(get_pm)
  p <- RISmed::PMID(get_pm)
  y <- RISmed::YearPubmed(get_pm)
  a <- RISmed::Author(get_pm)
  a_1 <- vector(mode = 'character', length = length(a))
  for (jj in 1:length(a)) {
   a_1[jj] <- a[[jj]]$LastName[1] 
  }
  t <- RISmed::ArticleTitle(get_pm)
  data_pm <- data.frame(doi = d, pmid = p, year = y, author = a_1, title = t)
  rm(d, p, y, a, t)
  
  ### search web of science
  
  ### pull doi, authors, year, title
  
  
}