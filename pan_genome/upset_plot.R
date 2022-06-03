install.packages("UpSetR")
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")

library(UpSetR)
library(ComplexHeatmap)

data <- read.delim(file="~/Projects/B_mex/SplitSubgenome/orthofinder/Results_Jun03/Orthogroups/orth_missing_gene_matrix.upset", header = T, sep = "\t")
head(data)

pdf(file = "~/Projects/B_mex/SplitSubgenome/orthofinder/Results_Jun03/Orthogroups/upset_orth_missing.pdf",width = 22,height = 13)
#upset(data,sets = c("Sbicolor","OsativaKitaake","PhalliiHAL","Bsylvaticum","Bstacei","Bdistachyon"), order.by = c("degree"), mainbar.y.label="Orthologous clusters in each intersection",sets.x.label
#="Orthologous clusters in each species",text.scale=2.5,point.size=7)
my_data <- data[, c(11,7,8,1,2,5,6,9,10,3)]
m <- make_comb_mat(my_data)

UpSet(m, 
      pt_size = unit(7, "mm"), 
      lwd = 5,
      set_order = c("Osat","BmexP","BmexU","ABR113D","ABR113S","Bhyb26D","Bhyb26S","Bstacei","Bsyl","Barb"),
      top_annotation = upset_top_annotation(
        m,
        height = unit(20, "cm"),
        axis_param = list(at = c(0, 200, 400,600),
        labels = c("0", "200", "400","600")),
        bar_width = 0.3,
        gp = gpar(fill = "black"),
      ),
      right_annotation = upset_right_annotation(m, 
                                                gp = grid::gpar(fill = "black",cex=2,fontsize = 10),
                                                bar_width = 0.5,
                                                width = unit(20, "cm"),
      )
)
dev.off()

pdf(file = "~/MorrellLab Dropbox/Li Lei/Brachpodium/sylvaticum/Version2_Lovell/ortho_dbs/orthodbs_round2/upset_orth_figureS.pdf",width = 13,height = 25)

UpSet(t(m),
      pt_size = unit(6, "mm"), 
      lwd = 3,
      set_order = c("Bdistachyon","Bstacei","Bsylvaticum","OsativaKitaake","Sbicolor","PhalliiHAL"),
      top_annotation = upset_top_annotation(
        t(m),
        height = unit(15, "cm"),
        bar_width = 0.3,
        gp = gpar(fill = "black"),
      ),
      right_annotation = upset_right_annotation(t(m), 
                                                gp = grid::gpar(fill = "black",cex=2,fontsize = 10),
                                                bar_width = 0.5,
                                                width = unit(20, "cm"),
      )
)
dev.off()



?decorate_annotation
?axis_param
setsBarColors <- c('black','black', 'black', '#EA4335', 'black', 'black')
upset(my_data,
      nsets=6,
      nintersects=1000,
      sets = c("PhalliiHAL","Sbicolor","OsativaKitaake","Bsylvaticum","Bstacei","Bdistachyon"),
      keep.order = TRUE,
      sets.bar.color=setsBarColors
)
#upset(data,
#      nsets=6,
#      nintersects=1000,
#      sets = c("PhalliiHAL","Bsylvaticum","Sbicolor","Bstacei","Bdistachyon","OsativaKitaake"), 
#      keep.order = TRUE, 
#      mainbar.y.label="Orthologous clusters in each intersection",
#      sets.x.label="Orthologous clusters in each species",
#      text.scale=2.5,
#      point.size=7,
#      sets.bar.color=setsBarColors,
#      queries = list(list(query = intersects,params = list("Bstacei","Bdistachyon","OsativaKitaake"), color ='#FBBC05' , active = T),
#                     list(query = intersects,params = list("PhalliiHAL","Bsylvaticum"), color ='#4285F4' , active = T))
#)

dev.off()

