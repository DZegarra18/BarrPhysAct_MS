library(dplyr)
library(stringr)
library(irr)
library(vcd)
#Filtrar y tidy csv
tiab <- read.csv("../Data/Screening/BarrPhysAct_Screening_Tiab.csv")

decisions <- tiab|>
            select(notes)
decisions <-  decisions |> 
            mutate(
              Mateo = str_match(notes, '"Mateo"=>"([^"]+)"')[,2],
              Daniel = str_match(notes, '"Daniel"=>"([^"]+)"')[,2]
            ) |> 
            select(Mateo, Daniel)

decisions$Mateo <- as.factor(decisions$Mateo)
decisions$Daniel <- as.factor(decisions$Daniel)

write.csv(decisions, "../Screening/BarrPhysAct_Screening_Tiab_decisions.csv")

#tabla de decisiones
table <- table(decisions$Mateo, decisions$Dani); table

#calcular kappa
kappa_tiab <- kappa2(decisions[, c("Mateo", "Daniel")]); kappa_tiab

kappa_vcd_tiab <- Kappa(table); kappa_vcd_tiab
confint(kappa_vcd_tiab)


