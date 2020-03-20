# BxPresents v0.01 ####
# Vincent Looten
# Date de création : 2020-03-19
# Date de dernière modification : 2020-03-20
# Text encoding : UTF-8

server <- function(input, output){
  lexique <- readRDS("lexique.RDS")
  
  observeEvent(input$btn, {
    
    if (!interactive()) {
      session$onSessionEnded(function() {
        stopApp()
        q("no")
      })
    }
    
    mot <- input$motgen
    
    letters_good <- unique(str_extract_all(mot, "[a-z]")[[1]])
    letters_bad <- setdiff(letters,letters_good)
    
    lexique0 <- lexique
    for(k in 1:length(letters_bad)){
      lexique0 <- lexique0[-grep(letters_bad[k],lexique0$pur,perl = F,fixed = T),]
    }
    lexique0 <- lexique0[nchar(lexique0$pur)>1,]
    
    lexique0$adj <- 0
    lexique0$adj[grep("adj",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$nom <- 0
    lexique0$nom[grep("nom",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$adj <- 0
    lexique0$adj[grep("adj",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$adv <- 0
    lexique0$adv[grep("adv",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$prep <- 0
    lexique0$prep[grep("prep",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$mg <- 0
    lexique0$mg[grep("mg",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$cjco <- 0
    lexique0$cjco[grep("cjco",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v0 <- 0
    lexique0$v0[grep("v0",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v1 <- 0
    lexique0$v1[grep("v1",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v2 <- 0
    lexique0$v2[grep("v2",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v3 <- 0
    lexique0$v3[grep("v3",lexique0$Étiquettes,perl = F,fixed = T)] <- 1
    lexique0 <- unique(lexique0[,c("Flexion", "Indice.de.fréquence", "pur", "adj", 
                                   "nom", "adv", "prep", "mg", "cjco", "v0", "v1", "v2", "v3","taille")])
    output$nom <- DT::renderDataTable(lexique0[which(lexique0$nom==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$adj <- DT::renderDataTable(lexique0[which(lexique0$adj==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$adv <- DT::renderDataTable(lexique0[which(lexique0$adv==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$prep <- DT::renderDataTable(lexique0[which(lexique0$prep==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$mg <- DT::renderDataTable(lexique0[which(lexique0$mg==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$cjco <- DT::renderDataTable(lexique0[which(lexique0$cjco==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$v0 <- DT::renderDataTable(lexique0[which(lexique0$v0==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$v1 <- DT::renderDataTable(lexique0[which(lexique0$v1==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$v2 <- DT::renderDataTable(lexique0[which(lexique0$v2==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$v3 <- DT::renderDataTable(lexique0[which(lexique0$v3==1),c("Flexion","taille", "Indice.de.fréquence")])
    
  })
  
  
}