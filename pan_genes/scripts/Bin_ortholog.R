#Written by Li Lei 2022/10/18 in Alameda and adapted from Virgina's script from https://github.com/vtartaglio/Scarlett_et_al_2022/blob/master/fig3/bin_orthogroups.R
library(ggplot2)
library(data.table)
library(UpSetR)

get_og_comp <- function(myog) {
  return(DT[synOG==myog]$genome)
}

#setwd("/home/virginia/Documents/school/vogelLab/notebook/2021")
dat <- read.csv('/Users/LiLei/Projects/B_mex/debug/results/gffWithOgs.txt', sep='\t', stringsAsFactors = FALSE, header = TRUE)
DT <- as.data.table(dat)     
head(DT)
nrow(dat)

#takes about a minute
ogkey <- lapply(unique(dat$synOG), function(myog) get_og_comp(myog))
names(ogkey) <- unique(dat$synOG)
length(ogkey)
head(ogkey)
#Check which syntenic orthogroups have this combination of genomes represented
#Does not depend on the earlier syn_orth_ stuff so you can just skip to here 
conserved <- lapply(ogkey, function(genomes) all(c("BmexP","BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes))
length(conserved)
head(conserved)
abs_BmexP <- lapply(ogkey, function(genomes) (all(c("BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("BmexP" %in% genomes)))
abs_BmexU <- lapply(ogkey, function(genomes) (all(c("BmexP","ABR113D", "ABR113S",  "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("BmexU" %in% genomes)))
abs_Bhyb26D <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S",  "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("Bhyb26D" %in% genomes)))
length(abs_Bhyb26D)
abs_Bhyb26S <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S",  "Bhyb26D", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("Bhyb26S" %in% genomes)))
abs_ABR113D <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("ABR113D" %in% genomes)))
abs_ABR113S <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU", "ABR113D", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("ABR113S" %in% genomes)))
abs_Bd21 <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bsyl","Barb","Osat") %in% genomes) & !("Bdist" %in% genomes)))
abs_Bstacei <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S","Bdist", "Bsyl","Barb","Osat") %in% genomes) & !("Bstacei" %in% genomes)))
abs_Bsyl <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist","Barb","Osat") %in% genomes) & !("Bsyl" %in% genomes)))
abs_Barb <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist","Bsyl","Osat") %in% genomes) & !("Barb" %in% genomes)))
abs_rice <- lapply(ogkey, function(genomes) (all(c("BmexP","BmexU","ABR113D", "ABR113S", "Bhyb26D", "Bhyb26S", "Bstacei", "Bdist", "Bsyl","Barb") %in% genomes) & !("Osat" %in% genomes)))

input = c(
  'BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113D&ABR113S&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_rice)),
  'Osativa&BmexP&Bhyb26D&Bhyb26S&ABR113D&ABR113S&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_BmexP)),
  'Osativa&BmexU&Bhyb26D&Bhyb26S&ABR113D&ABR113S&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_BmexU)),
  'Osativa&BmexP&BmexU&Bhyb26S&ABR113D&ABR113S&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_Bhyb26D)),
  'Osativa&BmexP&BmexU&Bhyb26D&ABR113D&ABR113S&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_Bhyb26S)),
  'Osativa&BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113S&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_ABR113D)),
  'Osativa&BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113D&Bd21&ABR114&Bsyl&Barb'=sum(unlist(abs_ABR113S)),
  'Osativa&BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113D&ABR113S&ABR114&Bsyl&Barb'=sum(unlist(abs_Bd21)),
  'Osativa&BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113D&ABR113S&Bd21&Bsyl&Barb'=sum(unlist(abs_Bstacei)),
  'Osativa&BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113D&ABR113S&ABR114&Bd21&Barb'=sum(unlist(abs_Bsyl)),
  'Osativa&BmexP&BmexU&Bhyb26D&Bhyb26S&ABR113D&ABR113S&Bd21&ABR114&Bd21'=sum(unlist(abs_Barb))
)

pdf("/Users/LiLei/Projects/B_mex/nov2_upset.pdf", width = 22,height = 15)
upset(fromExpression(input),
      nsets=11,
      mb.ratio = c(0.60, 0.40), 
      order.by = "freq",
      decreasing=T,
      point.size = 7,
      line.size = 0.8,
      #text.scale=c(2.3, 2.25, 0.5, 0.5, 2.25, 3.25),
      #c(intersection size title, intersection size tick labels, set size title, set size tick labels, set names, numbers above bars)
      text.scale=5,
      mainbar.y.label = "Number of Orthogroups",
      set_size.show=F,
      set_size.scale_max=0.5)
dev.off()

############## Get homeologs for the two polyploids ##############  
has_homeos <- function(string1, string2, testvec) {
  return(sum(testvec %in% string1)== 1 & sum(testvec %in% string2) == 1) #true or false: one and only one occurrence of each string
}
get_homeos <- function(string1, string2, mysynOg) {
  minidf <- DT[which(DT$synOg==mysynOg),]
  homeo1 <- minidf[which(minidf$genome==string1),]$id
  homeo2 <- minidf[which(minidf$genome==string2),]$id
  return(c(homeo1, homeo2))
}

synOGs_w_ABR113_homeos <- unname(which(unlist(lapply(ogkey, function(genomes) has_homeos("ABR113D", "ABR113S", genomes)))))
synOGs_w_Bhyb26_homeos <- unname(which(unlist(lapply(ogkey, function(genomes) has_homeos("Bhyb26D", "Bhyb26S", genomes)))))
synOGs_w_Bmex_homeos <- unname(which(unlist(lapply(ogkey, function(genomes) has_homeos("BmexP", "BmexU", genomes)))))

Bhyb26homeos <- t(as.data.frame(lapply(synOGs_w_Bhyb26_homeos, function(n) get_homeos("Bhyb26D", "Bhyb26S", n)), stringsAsFactors = F))
ABR113homeos <- t(as.data.frame(lapply(synOGs_w_ABR113_homeos, function(n) get_homeos("ABR113D", "ABR113S", n)), stringsAsFactors = F))
Bmexhomeos <- t(as.data.frame(lapply(synOGs_w_Bmex_homeos, function(n) get_homeos("BmexP", "BmexU", n)), stringsAsFactors = F))
write.table(ABR113homeos, file="/Users/LiLei/Projects/B_mex/ABR113_homeologs.tsv", col.names = FALSE, row.names = FALSE, quote = FALSE, sep = "\t")
write.table(Bhyb26homeos, file="/Users/LiLei/Projects/B_mex/Bhyb26_homeologs.tsv", col.names = FALSE, row.names = FALSE, quote = FALSE, sep = "\t")
write.table(Bmexhomeos, file="/Users/LiLei/Projects/B_mex/Bmex_homeologs.tsv", col.names = FALSE, row.names = FALSE, quote = FALSE, sep = "\t")

##################################################################




############## Test for significance of biased gene loss ############## 
get_total_genes_in_subg <- function(mygenome) {
  return(
    length(unique(
      DT[which(DT$genome==mygenome),]$id
    ))
  )
}

#Bhyb26
contingency_table <- data.frame("D"=c(sum(unlist(abs_Bhyb26D)), get_total_genes_in_subg("Bhyb26D")), "S"=c(sum(unlist(abs_Bhyb26S)), get_total_genes_in_subg("Bhyb26S")), row.names=c("lost", "total"))
chisq.test(contingency_table)
#Pearson's Chi-squared test with Yates' continuity correction

#data:  contingency_table
#X-squared = 9.0744, df = 1, p-value = 0.002592
#Just curious
contingency_table <- data.frame("D"=c(sum(unlist(abs_Bhyb26D)),sum(unlist(conserved))), "S"=c(sum(unlist(abs_Bhyb26S)), sum(unlist(conserved))), row.names=c("lost", "total"))
chisq.test(contingency_table)

#Pearson's Chi-squared test with Yates' continuity correction

#data:  contingency_table
#X-squared = 10.672, df = 1, p-value = 0.001088

#ABR113
contingency_table <- data.frame("D"=c(sum(unlist(abs_ABR113D)), get_total_genes_in_subg("ABR113D")), "S"=c(sum(unlist(abs_ABR113S)), get_total_genes_in_subg("ABR113S")), row.names=c("lost", "total"))
chisq.test(contingency_table)
#Pearson's Chi-squared test with Yates' continuity correction

#data:  contingency_table
#X-squared = 2.2071, df = 1, p-value = 0.1374

#diploids
contingency_table <- data.frame("D"=c(sum(unlist(abs_Bd21)), get_total_genes_in_subg("Bdistachyon")), "S"=c(sum(unlist(abs_Bstacei)), get_total_genes_in_subg("Bstacei")), row.names=c("lost", "total"))
chisq.test(contingency_table)
#Pearson's Chi-squared test with Yates' continuity correction

#data:  contingency_table
#X-squared = 14275, df = 1, p-value < 2.2e-16

#Warning message:
#  In chisq.test(contingency_table) :
#  Chi-squared approximation may be incorrect
#Bmex
contingency_table <- data.frame("P"=c(sum(unlist(abs_BmexP)), get_total_genes_in_subg("BmexP")), "U"=c(sum(unlist(abs_BmexU)), get_total_genes_in_subg("BmexU")), row.names=c("lost", "total"))
chisq.test(contingency_table)
#Pearson's Chi-squared test with Yates' continuity correction

#data:  contingency_table
#X-squared = 7.7427, df = 1, p-value = 0.005393

##################################################################




############## Create lostgenes file for pseudogene pipeline ############## 

Ddf <- as.data.frame(unlist(abs_BmexP))
Ddf <- rownames(Ddf)[which(Ddf[,1]==TRUE)]
Sdf <- as.data.frame(unlist(abs_BmexU))
Sdf <- rownames(Sdf)[which(Sdf[,1]==TRUE)]
Ddf <- data.frame(synOg=Ddf, missing_subgenome="BmexP", stringsAsFactors = F)
Sdf <- data.frame(synOg=Sdf, missing_subgenome="BmexU", stringsAsFactors = F)
final <- rbind(Ddf, Sdf)
write.table(final, file="/Users/LiLei/Projects/B_mex/lostgenes.txt", row.names = FALSE, col.names=TRUE, quote=FALSE, sep="\t")
##################################################################


############## Create conservedgenes file for pseudogene pipeline ############## 

#Here we can see how many orthogroups fall into each category
sum(unlist(conserved))
sum(unlist(abs_Bhyb26D))
sum(unlist(abs_Bhyb26S))
sum(unlist(abs_ABR113D))
sum(unlist(abs_ABR113S))
sum(unlist(abs_Bd21))
sum(unlist(abs_Bstacei))
sum(unlist(abs_rice))


alldf <- as.data.frame(unlist(conserved))
allvec <- rownames(alldf)[which(alldf[,1]==TRUE)]
DTslim <- DT[which(DT$synOg %in% allvec)]

one_gene_per_genome <- function(mysynOg) {
  mini <- DTslim[synOg==mysynOg,]
  t <- table(mini$genome)
  if(sum(sapply(c('Bhyb26D', 'Bhyb26S', 'Bdistachyon', 'Bstacei'), function(g) unlist(unname(t[names(t)==g]))))==4) {
    return(TRUE)
  }else{
    return(FALSE)
  }
}

#Takes about 6 minutes
tokeep <- sapply(allvec, function(s) one_gene_per_genome(s))
tokeep2 <- tokeep[which(tokeep==TRUE)]

get_minidfs <- function(mysynOg) {
  return( DTslim[synOg==mysynOg,] )
}
#Takes another 6 or 7 minutes
df_list <- lapply(names(tokeep2), function(s) get_minidfs(s))

gene_data <- lapply(df_list, function(m) {
  return(c(
    unique(m$synOg),
    unlist(unname(m[m$genome=="Bdistachyon", 'id'])),
    unlist(unname(m[m$genome=="Bhyb26D", 'id'])),
    unlist(unname(m[m$genome=="Bhyb26S", 'id'])),
    unlist(unname(m[m$genome=="Bstacei", 'id']))
  ))
})

final_gene_data <- do.call(rbind.data.frame, gene_data)
names(final_gene_data) <- c("synOg", "Bdgene", "Bhyb26Dgene", "Bhyb26Sgene", "Bsgene")
write.table(final_gene_data, file="conservedgenes.txt", row.names = FALSE, col.names=TRUE, quote=FALSE, sep="\t")

save.image(file="/home/virginia/Desktop/bin_orthogroups.RData")

##################################################################
