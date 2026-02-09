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





# Premières analyses  -----------------------------------------------------

## Astruce 
## la fonction ci-dessous permet d'importer toutes les feuilles excel en une seule fois.
## on peut évidement les importer une à la fois 






read_excel_allsheets <- function(filename, tibble = FALSE) {
  # I prefer straight data.frames
  # but if you like tidyverse tibbles (the default with read_excel)
  # then just pass tibble = TRUE
  sheets <- readxl::excel_sheets(filename)
  x <- lapply(sheets, function(X) readxl::read_excel(filename, sheet = X))
  if(!tibble) x <- lapply(x, as.data.frame)
  names(x) <- sheets
  x
}




data<-read_excel_allsheets( "Donnees_premieres_analyses-1.xlsx")

## Packages requis pour les analyses 

install.packages("reshape2")
install.packages("afex")
install.packages("ppcor")

library(psych)
library(reshape2)
library(afex)
library(ppcor)

## Feuille logique

logique<-data$logique

L# la fonction pour les corrélation est corTest du package 'psych'
cor.test(
  x = logique$logique, #nom de la variable dans le jeu de données qui sera en abcisse
  y = logique$temps,#nom de la variable dans le jeu de données qui sera en ordonné
  method ="pearson" # indique le type de corrélation. Ici Bravais-Pearson mais Spearman permet d'avoir le rho de Spearman
          )


## Engagement
engagement_cptmtal<-data$engagement_cptmtal

# on commence par faire une table sur les données 

t1<-table(engagement_cptmtal$Tech,engagement_cptmtal$Cptmt )
t1


# on  obtient le chi carré avec la fonction chisq.test

chi.out<-chisq.test(tab)
chi.out

# Feuille A_I

A_I<-data$A_I

## il faut d'abord transformer les données en un format long avec la fonction melt du package reshape2
## pour cela on va rajouter un identifiant pour chaque observation avec la fonction paste0


# ici on crée une chaîne de caractère avec la lettre p pour participant et le nombre de lignes (nrow) qu'il y a dans A_I
# on stocke cela dans une variable appelée ID
A_I$ID<-paste0("P", 
               1:nrow(A_I)) 


AI_long<-melt(data = A_I, # le jeu de données qu'on veut faire passer en format long
              id.vars=c("ID", "TYPE") , # les variables qui ne sont PAS en mesure répétée
              variable.name ="Blocs", # le nom de la variable indépendante 
              value.name ="Temps" # le nom de la variable dépendante
              )

##on utilise la fonction aov_4 cu package afex 
## la formule prend la forme VD~VI + identifiant 
## pour indiquer une emsure répétée, on fait VI|identifiant
# ici la variable identifiant est ID

aov_4( Temps~ Blocs|ID, # on crée la formule : on prédit le temps par les temps par les blocs, et les blocs sont en mesure répétées
     data = AI_long # nom du jeu de données 
       )


# Feuille impact professionnel 

# test de McNemar - impact professionnel
impact_professionnel<-data$impact_professionnel

# on commence, comme pour chi² par faire une table 

# mais ici, il faut faire la pondération par les effectifs 
# la fonction est un peu technique, mais l'idée est de comptabiliser (sum) 
# le nombre d'observations dans chacune des combinaisons des deux variables (à l'annonce et à 6 mois)

t1<-tapply(impact_professionnel$Fréquence, # la variable effectifs 
           list(impact_professionnel$A_l_annonce, impact_professionnel$Six_mois_après_annonce),
           sum, 
           na.rm=T) # indique qu'on supprime les valeurs manquante s'il y en a

mcnemar.test(t1)



# Feuille TOLD
# t de Student pour échantillons indépendants



TOLD<-data$TOLD

t.test(TOLD ~ groupe, # le modèle selon la logique VD~VI 
       data =TOLD ) # le nom du jeu de données




# Feuille plausibilité - corrélation  de spearman 

plausibilite<-data$plausibilité

cor.test(
  x = plausibilite$Plaus, #nom de la variable dans le jeu de données qui sera en abcisse
  y = plausibilite$collab,#nom de la variable dans le jeu de données qui sera en ordonné
  method ="spearman" # indique le type de corrélation. Ici  Spearman mais  pearson permet d'avoir le r de Bravais-Pearson
)




# Feuille lunettes - anova factorielle

lunettes<-data$lunettes

# il n'y a pas de variables identifiant les participants, il faut l'ajouter

lunettes$ID<-paste0("p", 1:nrow(lunettes))

# pour s'assurer que r comprenne que ce sont des facteurs et non des valeurs textes quelconque
# on transforme toutes les variables d'intérêt en facteur
# on ne l'a pas fait pour l'anova à mesure répétée car cela a été fait automatiquement en passant en format long

lunettes$lunettes<-factor(lunettes$lunettes)
lunettes$contact<-factor(lunettes$contact)
lunettes$ID<-factor(lunettes$ID)

# on fait le modèle avec une logique VD ~ VI1*VI2 + (1|variable aléatoire)
# la variable aléatoire est ID 
aov_4(temps ~ lunettes*contact + (1|ID) , data = lunettes)


# Feuille détresse - corrélation partielle de Spearman

detresse<-data$détresse

## on fait la corrélation partielle avec la fonction ppcor du package 

pcor.test(x = detresse$detresse,  # variable en abscisse
          y =detresse$coping, # variable en ordonnée
          z = detresse$age, # variable à contrôler (on peut en mettre plusieurs)
          method ="spearman") # spearman indique un rho partiel de Spearman, pearson indique un r partiel de Bravais-Pearson





# Feuille métamémoire - t de Student comparaison à une norme
## norme = 10 

metamemoire<-data$métamémoire
## !! l'importation multiple ne corrige pas les noms invalides de variables
# les noms de variables ne peuvent pas commencer par des chiffres
## nécessite une correction manuelle. 
## le nouveau nom ne correspond pas nécessairement au codage réalisé par easieR
names(metamemoire)<-c("x4ans", "x5ans")

# t de Student pour échantillons appariés

t.test(metamemoire$x4ans,
       metamemoire$x5ans,
       paired=T) ## le fait d'indiquer "paired =T" préciser que c'est apparié

# il faut noter qu'ici, on a un format large, pour échantillons appariés, on n'utilise pas une formule du type : VD~VI



## t de student comparaison à un norme 

t.test(metamemoire$x4ans,
       mu=10) ## mu représente la valeur de la norme



# feuille bonheur - anova simple

bonheur<-data$bonheur

bonheur$ID<-paste0("p", 1:nrow(bonheur))

# pour s'assurer que r comprenne que ce sont des facteurs et non des valeurs textes quelconque
# on transforme toutes les variables d'intérêt en facteur
# on ne l'a pas fait pour l'anova à mesure répétée car cela a été fait automatiquement en passant en format long

bonheur$etudes<-factor(bonheur$etudes)

bonheur$ID<-factor(bonheur$ID)

# on fait le modèle avec une logique VD ~ VI1*VI2 + (1|variable aléatoire)
# la variable aléatoire est ID 
aov_4(bonheur ~ etudes + (1|ID) , data = bonheur)








#Feuille Pub - chi² d'ajustement

pub<-data$pub

# on commence par faire la table 
# la description de cette fonctions est explcicité sur l'exercice impact prof
t1<-tapply(pub$Effectifs, pub$Publicité, sum, na.rm=T)

# on fait le test du chi. Il faut préciser le modèle avec l'argument "p"

chisq.test(t1, p=c(.25,.25,.25,.25))

