##############################################
#####    TD de Statistiques L3          ######
##############################################


# Installation des packages -----------------------------------------------
install.packages("psych")
install.packages("readxl")

# Chargement des packages
library("psych")
library("readxl")

# Statistiques descriptives -----------------------------------------------

# importation des données

TD2 <- read_excel("C:/mon.repertoire/Cours de statistiques appliquées - L3/TD2/stat_descriptives.xlsx")
str(TD2)

# réalisations des statistiques descriptives pour l'ensemble des variables sans notion de groupes

psych::describe(TD2)

psych::describeBy(A+B+E~D, data=TD2)

psych::describeBy(C~y, data=TD2)
psych::describeBy(A+C~X+y, data=TD2)
tapply(TD2$C, TD2$y, var)

var(TD2$G)
# ou un peu différent de (en raison des erreurs d'arrondi) :
psych::describe(TD2$G)
1476 ^2

