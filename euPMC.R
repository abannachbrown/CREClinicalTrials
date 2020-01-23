


### Install packages
install.packages("devtools")
install.packages("remotes")
library('remotes')
remotes::install_github("sachsmc/rclinicaltrials", pkgType="source")
library(rclinicaltrials)

install.packages("rcrossref")
library(rcrossref)


## what can you search for
browseURL(advanced_search_terms["cond", "help"])
head(advanced_search_terms)




## CROSSREF

### add email address
file.edit("~/.Renviron")
# crossref_email= "name@example.com"

##### europepmc

install.packages("europepmc")
library(europepmc)



# function epmc_ftxt retrieves full texts
# (IN_EPMC:y) AND (PUB_TYPE:"Clinical Trial, Phase IV" OR PUB_TYPE:"Clinical Trial, Phase I" OR PUB_TYPE:"Clinical Trial" OR PUB_TYPE:"Clinical Trial, Phase II" OR PUB_TYPE:"Clinical Trial, Phase III")


clinical_trialSearch <- europepmc::epmc_search(query = '(IN_EPMC:y) AND (OPEN_ACCESS:y) AND (PUB_TYPE:"Clinical Trial, Phase IV" OR PUB_TYPE:"Clinical Trial, Phase I" OR PUB_TYPE:"Clinical Trial" OR PUB_TYPE:"Clinical Trial, Phase II" OR PUB_TYPE:"Clinical Trial, Phase III")', limit = 10)


# ids <- ifelse(clinical_trialSearch$source=="pmc", clinical_trialSearch$pmcid, NA) 



# works with 1 ID 
ID<-clinical_trialSearch$pmcid[1]
full_textEG <- epmc_ftxt(ext_id = clinical_trialSearch$pmcid)


## does not work in a for loop for several IDs
ids <- clinical_trialSearch$pmcid

for (i in seq_along(ids)){
  full_texts <- europepmc::epmc_ftxt(ext_id = i)
}


# nor this
plyr::ldply(ids, function(x) {
  europepmc::epmc_ftxt(paste0("ext_id =", x))
  
})

library(tidyverse)

remotes::install_github("ropensci/tidypmc")
## dunno why tidypmc is not working

devtools::install_github("ropensci/crminer")


###### fulltext package testing
install.packages("fulltext")
library(fulltext)


CTs <-ft_search(query = "((PUB_TYPE:Clinical Trial) AND (OPEN_ACCESS:y) AND (IN_EPMC:y)",  from='europmc', limit = 100)

names(CTs)


CTs_crossref <- CTs$crossref
CTs_eupmc <- CTs$europmc

CT_eupmc_doi <- CTs_eupmc$data$doi

out <- ft_get(CTs_eupmc)



###### parse euPMC

library(readr)







