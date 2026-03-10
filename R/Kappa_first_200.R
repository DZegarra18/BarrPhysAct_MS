library(dplyr)
library(stringr)
library(irr)

#Filtrar y tidy csv
articles_first_200 <- read.csv("../Data/Screening/articles_first_200.csv")

decisions <- articles_first_200|>
            select(notes)
decisions <-  decisions |> 
            mutate(
              Mateo = str_match(notes, '"Mateo"=>"([^"]+)"')[,2],
              Daniel = str_match(notes, '"Daniel"=>"([^"]+)"')[,2]
            ) |> 
            select(Mateo, Daniel)

decisions$Mateo <- as.factor(decisions$Mateo)
decisions$Daniel <- as.factor(decisions$Daniel)

#calcular kappa
kappa2(decisions[, c("Mateo", "Daniel")])
