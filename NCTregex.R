## clinical trials regex


# NCT00000419 - NCT plus 8 digit number


# install.packages("stringr")
library(stringr)


# modifiers
# $ * + . ? [ ] ^ { } | ( ) \

# ^  start of string
# $  end of string
# .  any character except new line
# *  0 or more
# +  1 or more
# ?  0 or 1
# |  or (alternative patterns)
# {} quantifier brackets: exactly {n}; at least {n,}; between {n,m}
# () group patterns together
# \  escape character (needs to be escaped itself in R: \\)
# [] character class brackets (not to be confused with R's subsetting brackets!)


test_abstract <- "Background The StopDia study is based on the convincing scientific evidence that type 2 diabetes (T2D) and its comorbidities can be prevented by a healthy lifestyle. The need for additional research is based on the fact that the attempts to translate scientific evidence into actions in the real-world health care have not led to permanent and cost-effective models to prevent T2D. The specific aims of the StopDia study following the Reach, Effectiveness, Adoption, Implementation, and Maintenance (RE-AIM) framework are to 1) improve the Reach of individuals at increased risk, 2) evaluate the Effectiveness and cost-effectiveness of the digital lifestyle intervention and the digital and face-to-face group lifestyle intervention in comparison to routine care in a randomized controlled trial (RCT), and 3) evaluate the Adoption and Implementation of the StopDia model by the participants and the health care organizations at society level. Finally, we will address the Maintenance of the lifestyle changes at participant level and that of the program at organisatory level after the RCT. Methods The StopDia study is carried out in the primary health care system as part of the routine actions of three provinces in Finland, including Northern Savo, Southern Carelia, and Päijät-Häme. We estimate that one fifth of adults aged 18–70 years living in these areas are at increased risk of T2D. We recruit the participants using the StopDia Digital Screening Tool, including questions from the Finnish Diabetes Risk Score (FINDRISC). About 3000 individuals at increased risk of T2D (FINDRISC ≥12 or a history of gestational diabetes, impaired fasting glucose, or impaired glucose tolerance) participate in the one-year randomized controlled trial. We monitor lifestyle factors using the StopDia Digital Questionnaire and metabolism using laboratory tests performed as part of routine actions in the health care system.Trial registration ClinicalTials.gov. Identifier: NCT03156478 . Date of registration 17.5.2017.Keywords Type 2 diabetes, Lifestyle intervention, Prevention, Randomized controlled trial, Digital health behavior change intervention, Scalability, Effectiveness"


# \b means word boundary - if there are formatting issues 
# this may prevent the regex picking up NCT
grep(pattern = "\\b(NCT|ISRCTN)[0-9]{8}\\b", test_abstract, value = FALSE)

str_extract(test_abstract, "\\b(NCT|ISRCTN)[0-9]{8}\\b") 
# ISRCTN

## pan africa trials
# e.g PACTR201606001679337

## for each row in dataframe 

# search pubmed with isrctn [si] to find all ISRCTN

install.packages("devtools")
library(devtools)
install_github("sachsmc/rclinicaltrials")
library(rclinicaltrials)

head(advanced_search_terms)

# number of completed trials
clinicaltrials_count(query = c("recr=Completed", "ALL"))


y <- clinicaltrials_download(query = 'recr=Completed', count = 10, include_results = TRUE)

## next stepps 28/01/2020 - either download all the clinical trials info and put into mongodb
## or put 
download_xml(url, file = basename(url), quiet = TRUE, mode = "wb",
             handle = curl::new_handle())
