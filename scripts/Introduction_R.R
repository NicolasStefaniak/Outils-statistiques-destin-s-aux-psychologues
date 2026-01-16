###################################
###      Introduction à       R####
###################################




# Utiliser R comme une calculatrice ---------------------------------------


5+3 # Addition 
5-3 # Soustraction 
5*3 # multiplication 
5/3 # division 
5^3 # exposant. Donc, ici, 5 exposant 3





# Les fonctions de base ---------------------------------------



getwd() # permet d'obtenir le répertoire de travail
dir()  # permet d'obtenir la liste des fichiers dans le répertoire de travail 

# Ligne de commande permettant de préciser le répertoire de travail
setwd(dir="C:/Users/Nicolas/Documents/livre de statistiques/Introduction") # Attention que "Nicolas" est mon nom et que vous devez adapter ce chemin d'accès à votre ordinateur

install.packages(pkgs ="readxl") # installation du package readxl
install.packages("dplyr") # installation du package dplyr

library(readxl) # chargement du package readxl 
library(dplyr) # chargement du package dplyr 

?setwd # recherche de l'aide pour la fonction setwd en utilisant le point d'interrogation 
help(install.packages) # recherche de l'aide pour la fonction install.packagesen utilisant la fonction help

# cherche l'aide d'une fonction appelée describe dans n'importe quel package installé sur votre ordinateur, même s'il n'est pas chargé. 
??describe 

# La création d'objets ---------------------------------------

a<-5 # créer un objet appelé a et ayant comme valeur 5
3 ->b # créer un objet appelé b et ayant comme valeur 3
c=a+b # créer un objet appelé c et ayant comme valeur la somme de a et b

a # appeler l'objet a, renvoie 5
b # appeler l'objet b, renvoie 3
c # appeler l'objet c, renvoie 8

# Illustration du côté arbitraire des noms 
ficus<-5
Xmen<-5
HarryPotter<-5
ficus
Xmen
HarryPotter

Harrypotter # Harrypotter avec un "p" minuscule n'existe pas et renvoie un message d'erreur



Ma valeur cinq<-5 # renvoie un message d'erreur
Mavaleurcinq<-5 # ne renvoie pas de message d'erreur 
Ma_valeur_cinq<-5 # ne renvoie pas de message d'erreur 
Ma.valeur.cinq<-5 # ne renvoie pas de message d'erreur 

élève<-"Jean"
élève


# Quelques exemples de ce qu'il ne faut pas faire 
interprete(ma.fonction)<- 5 # ne fonctionne pas et renvoie le message d'erreur indiquant que cette fonction ne peut être trouvée
c'est_pas_terrible<-5 # l'apostrophe pose souci 
ceci+cela+non+plus<-5 # le '+' est interprété comme une opération mathématique, de même s'il y avait '-','/','*','^'. 
pas_d_egal=erreur<-5 # mettre un "=" dans le nom d'un objet entraîne aussi une erreur. 

ls() # connaître la liste des objets dans la mémoire de R.


# La nature des objets ---------------------------------------


logique<-TRUE # l'alternative est FALSE
logique2<-F # TRUE et FALSE peuvent être résumés par T et F
class(logique) # indique que c'est une valeur logique
class(logique2) # indique que c'est une valeur logique


numerique<-2.3 # valeur numérique avec virgule. Remarquez que le séparateur de décimale est un point
numerique.sans.virgule<-5 # valeur numérique sans virgule.
entier <-as.integer(5) # valeur qui sera considérée comme un entier par R 
class(numerique)
class(numerique.sans.virgule)
class(entier)

chaine_textuelle1<-"hello world" # remarquez la présence de guillemets doubles
chaine_textuelle2<-'hello world' # remarquez la présence de guillemets simples
class(chaine_textuelle1)
class(chaine_textuelle2)



facteur<-as.factor("hello world" )
class(facteur)

numerique.f<-as.factor(numerique )
class(numerique.f)


as.numeric(numerique.f) # transformation d'un facteur en numérique, renvoie ici la valeur de 1. 



numerique.f<-as.character(numerique.f) # étape intermédiaire consistant à transformer le facteur en une chaîne de caractère
as.numeric(numerique.f) # transformation de la chaîne de caractère en numérique, ce qui renvoie 2.3

as.logical(1) # une valeur numérique transformée en valeur logique vaut toujours vrai si elle est différente de 0
as.logical(-1)# une valeur numérique transformée en valeur logique vaut toujours vrai si elle est différente de 0
as.logical(0) # une valeur numérique transformée en valeur logique vaut toujours faux si elle est égale 0
as.logical("hello world") # renvoie NA, pour not available car une valeur textuelle n'est pas interprétable en termes logiques. 
as.logical(facteur)# renvoie NA, pour not available car une valeur textuelle n'est pas interprétable en termes logiques.

# Les différents types d'objets ---------------------------------------

# Le vecteur qui est un ensemble de données de même nature ayant une seule dimension
notes<-c(12,13,9, 8, 15, 18, 4, 11, 13) # Création d'un vecteur avec 10 valeurs 
notes
mean(notes) # calcul de la moyenne des notes

mot_de_fin<-c("Cordialement", "respectueusement", "amicalement", "amitiés", "bonne journée","bien à toi","bien à vous")
mot_de_fin

c("a",1) # remarquez les guillemets dans la sortie de résultats autour du 1, indiquant qu'il est interprété comme une chaîne de caractères. 


1:5 # crée une séquence de chiffres de 1 à 5
rep(x=1, times = 9) # répète 9 fois le chiffre 1 
seq(from = 1, to = 9, by = 2) # crée une séquence allant de 1 à 9 en ayant un écart de 2 à chaque fois
gl(n= 2, k = 5 , labels = c("condition 1", "condition 2")) # crée un facteur ayant 2 modalités, chacune étant répétée 5 fois. 



matrice<-matrix(data = 1:9, # les données sont une séquence de chiffres allant de 1 à 9
                nrow = 3, # elles doivent être réparties dans 3 lignes
                ncol = 3, # et dans 3 colonnes - un des deux arguments peut être omis puisque si on a le nombre de lignes on a le nombre de colonnes
                byrow = F) # logique qui permet d'indiquer si on veut que les valeurs soient organisées par ligne ou par colonne. Ici, par colonne

## Notez que j'ai commenté chacun des arguments à l'intérieur de la fonction 
## et que la fonction a été utilisée sur plusieurs lignes pour plus de lisibilité. 



sexe<-c("Homme", "Femme","Homme", "Femme") # création d'un vecteur avec des chaînes de caractères, par exemple, le sexe des personnes. 
taille<-c(176,173,180,165) # création d'un vecteur avec des valeurs numériques, par exemple la taille des personnes

dt<-data.frame(sexe=sexe, taille=taille) # création d'un data.frame avec les deux variables 
dt
dt_tbl<-tibble(dt) # on utilise ici la fonction tibble pour transformer notre dataframe en tibble mais vous n'aurez normalement jamais à utiliser cette fonction. 
dt_tbl

str(dt)


class(dt_tbl) # est considéré comme un tibble (mais aussi comme un data.frame)
dt_tbl<-as.data.frame(dt_tbl) # on transforme le tibble en data.frame 
class(dt_tbl) # est considéré uniquement comme un data.frame 



ma.liste<-list(# on crée un liste des objets de taille différentes 
  dataframe = dt, # on ajoute un dataframe 
  vecteur = notes, # un vecteur 
  matrice = matrice, # une matrice 
  valeur = logique2) # et une valeur unique. On peut évidemment continuer
ma.liste


dt$sexe 
ma.liste$vecteur




# Importer des données ----------------------------------------------------

# importer un fichier excel 

# permet d'avoir la liste des fichiers dans le dossier de travail avec de s'assurer que le fichier est présent
dir() 
# permet de lister les feuilles de calculs dans le fichier cible
excel_sheets("semantic_priming.xlsx") 
# importation du fichier
data.xls<-read_excel(path = "semantic_priming.xlsx", sheet = "tout_direct")
# Présentation des 10 premières observations et des premières variables
data.xls

# voir l'intégralité des données 
View(data.xls)

# importer un fichier csv
data.csv<-read.csv2(file = "semantic_priming.csv", 
                    header = T,
                    sep = ";", # valeurs possibles "", "\tab" ou ","
                    dec =".", # valeurs possibles "." ou ","
                    na.string = "NA",
                    check.names=T)


# Préparer les données ----------------------------------------------------

## Sélectionner les variables d'intérêt
data.et1<-data.xls%>%dplyr::select( Subject, Attribute1,Attribute2,CATEGORIE,
                             Running, TextDisplay6.RT,RC)

## Sélectionner des observations sur la base d'une chaîne de caractères. 

unique(data.et1$Running)# indique le étiquettes individuelles pour une variable qualitative ou un facteur 

# sélectionner les observations dans les données data.et1, dans la variable Running, qui ne sont pas "essais"
data.et2<-filter(data.et1, Running!="essais") 

# vérification du nombre d'observations avant et après la sélection 
dim(data.et1) # 7400 observations 
dim(data.et2) # 7200 observations 

## Sélectionner des observations sur la base d'une chaîne de caractères. 

# indique le étiquettes individuelles pour une variable qualitative ou un facteur 
unique(data.et2$CATEGORIE) # contre, pseudo, rempl et SEMANTIQUE

# crée une table avec le nombre d'observations par sujet et par catégorie 
table(data.et2$Subject, data.et2$CATEGORIE)

# Calcul du pourcentage de réponses correctes 
RC_percent <- data.et2 %>% # le résultat sera stocké dans RC percent et on effectue des opérations sur data.et2
  group_by(Subject, CATEGORIE )%>% # un regroupe les données par les modalités des variables Subject et CATEGORIE
  summarise(perc_RC = mean(RC)*100 ) # On résume les données en calculant le pourcentage de réponses correctes

# Sélection des réponses correctes uniquement

table(data.et2$RC) # il y a 5679 observations correctes 
data.et4<-filter(data.et2, RC==1) # on sélectionne les observations pour lesquelles la réponse est correcte 
dim(data.et4) # on obtient effectivement 5679 observations

# Sélection des observations qui ne sont pas les réponses anticipées ou inattentives
data.et5<-data.et4  %>%
  filter(TextDisplay6.RT>200) %>% # on conserve les temps supérieurs à 200 ms
  filter(TextDisplay6.RT<2000)  # on conserve les temps inférieurs à 2000 ms


# On fait la moyenne des temps de réaction par participant et par condition 
data.et6 <- data.et5 %>% # le résultat sera stocké dans data.et6 et on effectue des opérations sur data.et5
  group_by(Subject, CATEGORIE )%>% # un regroupe les données par les modalités des variables Subject et CATEGORIE
  summarise(M_TR = mean(TextDisplay6.RT) ) # On fait la moyenne des temps de réaction par participant et par condition


# on refait un seul jeu de données avec les réponses correctes et les temps de réaction 


data_final<-left_join(data.et6, RC_percent, by=c("Subject"="Subject","CATEGORIE"="CATEGORIE" ))

