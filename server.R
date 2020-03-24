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
    
    if(input$optionbxp=="Belle absente"){
      letters_bad <- unique(str_extract_all(mot, "[a-z]")[[1]])
      letters_good <- setdiff(letters,letters_bad)
    }
    if(input$optionbxp=="N-vocalisme"){
      letters_bad <- setdiff(c("a","e","i","o","u","y"),input$voyelles_good)
      letters_good <- setdiff(letters,letters_bad)
    }
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
    lexique0$cjco[grep("cj",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v0 <- 0
    lexique0$v0[grep("v0",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v1 <- 0
    lexique0$v1[grep("v1",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v2 <- 0
    lexique0$v2[grep("v2",lexique0$Étiquettes,perl = F,fixed = T)] <- 1 
    lexique0$v3 <- 0
    lexique0$v3[grep("v3",lexique0$Étiquettes,perl = F,fixed = T)] <- 1
    lexique0$prn <- 0
    listeprn <- unique(c(grep("prn",lexique0$Étiquettes,perl = F,fixed = T),grep("patr",lexique0$Étiquettes,perl = F,fixed = T),grep("npr",lexique0$Étiquettes,perl = F,fixed = T)))
    lexique0$prn[listeprn] <- 1
    
    lexique0 <- unique(lexique0[,c("Flexion", "Indice.de.fréquence", "pur", "adj", 
                                   "nom", "adv", "prep", "mg", "cjco", "v0", "v1", "v2", "v3", "prn","taille")])
    liste <- which(lexique0$nom==1 | lexique0$adj==1 | lexique0$adv==1 | lexique0$prep==1 | lexique0$mg==1 | lexique0$cjco==1 | lexique0$v0==1 | lexique0$v1==1 | lexique0$v2==1 | lexique0$v3==1 | lexique0$prn==1)
    output$nbr_mot <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[liste,])),"</h3>")})
    output$nom <- DT::renderDataTable(lexique0[which(lexique0$nom==1),c("Flexion","taille", "Indice.de.fréquence")], options = list(pageLength = 20, autoWidth = TRUE))
    output$nbr_nom <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$nom==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$adj <- DT::renderDataTable(lexique0[which(lexique0$adj==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_adj <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$adj==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$adv <- DT::renderDataTable(lexique0[which(lexique0$adv==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_adv <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$adv==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$prep <- DT::renderDataTable(lexique0[which(lexique0$prep==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_prep <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$prep==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$mg <- DT::renderDataTable(lexique0[which(lexique0$mg==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_mg <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$mg==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$cjco <- DT::renderDataTable(lexique0[which(lexique0$cjco==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_cjco <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$cjco==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$v0 <- DT::renderDataTable(lexique0[which(lexique0$v0==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_v0 <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$v0==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$v1 <- DT::renderDataTable(lexique0[which(lexique0$v1==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_v1 <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$v1==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$v2 <- DT::renderDataTable(lexique0[which(lexique0$v2==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_v2 <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$v2==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$v3 <- DT::renderDataTable(lexique0[which(lexique0$v3==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_v3 <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$v3==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    output$prn <- DT::renderDataTable(lexique0[which(lexique0$prn==1),c("Flexion","taille", "Indice.de.fréquence")])
    output$nbr_prn <- renderUI({HTML("<h3>Nombre de mots : ",paste0(nrow(lexique0[which(lexique0$prn==1),c("Flexion","taille", "Indice.de.fréquence")])),"</h3>")})
    
  })
  
  
}