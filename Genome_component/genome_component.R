install.packages("ggplot2")
library(ggplot2)
MM <- read.delim("/Users/LiLei/MorrellLab Dropbox/Li Lei/Brachpodium/B_mexicanum/genome_component/length_for_plot.txt",sep="\t",header=T)
head(MM)
#MM$Species <- factor(MM$Species,levels = MM$Species)
#library(RColorBrewer)
#display.brewer.all()
#ggplot(data = MM, aes(x = factor(Species,levels=unique(Species)), y = Length, fill =factor(Component, levels=unique(Component)))) + geom_bar(stat="identity") + coord_flip()

stc <- ggplot(data = MM, aes(x = factor(Species,levels=unique(Species)), y = Length, 
                             fill =factor(Component, levels=c("Repeat_region","NonLTR_helitron","NonLTR_unknown","NonLTR_LINE_element","TIR_hAT","TIR_Tc1_Mariner","TIR_PIF_Harbinger","TIR_Mutator","TIR_CACTA","LTR_unknown","LTR_Gypsy","LTR_Copia","Intergenic","Intron","Coding")) )) + 
  geom_bar(stat="identity", width=0.4) + coord_flip()+ xlab("") + ylab("") +theme_bw() +
  theme(axis.line.y= element_blank(),
        axis.line.x = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank(),
        legend.text=element_text(size=rel(1.0)),
        axis.text.x = element_text(size = 20,face="bold"),axis.text.y = element_text(size = 20,face="bold.italic")) + guides(fill=guide_legend(title="")) 

stc+scale_fill_manual(values=c("#009900","#ff0040","#ff00bf","#8000ff","#0080ff","#adad85","#9933ff","#66ff33","#d966ff","#00b3b3","#bfff00","#ffff00","#ff8000","#ffbf00","#00bfff"))

ggsave("/Users/LiLei/MorrellLab Dropbox/Li Lei/Brachpodium/B_mexicanum/genome_component/length.pdf", width = 20, height =12)
