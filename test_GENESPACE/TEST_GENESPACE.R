if (!requireNamespace("devtools", quietly = TRUE))
  install.packages("devtools")
devtools::install_github("jtlovell/GENESPACE", upgrade = F)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("Biostrings", "rtracklayer"))

devtools::install_github("jtlovell/GENESPACE", upgrade = F)
library(GENESPACE)
runwd <- file.path("~/Desktop/testGenespace")
make_exampleDataDir(writeDir = runwd)
gids <- c("human","chimp","rhesus")
gpar <- init_genespace(
  genomeIDs = gids, 
  speciesIDs = gids, 
  versionIDs = gids, 
  ploidy = rep(1,3),
  wd = runwd, 
  gffString = "gff", 
  pepString = "pep",
  path2orthofinder = "orthofinder", 
  path2mcscanx = "/Users/LiLei/softwares/MCScanX",
  rawGenomeDir = file.path(runwd, "rawGenomes"))

parse_annotations(
  gsParam = gpar, 
  gffEntryType = "gene", 
  gffIdColumn = "locus",
  gffStripText = "locus=", 
  headerEntryIndex = 1,
  headerSep = " ", 
  headerStripText = "locus=")


gpar <- run_orthofinder(gsParam = gpar)
gpar <- synteny(gsParam = gpar)
ripdat <- plot_riparianHits(gpar)
pg <- pangenome(gpar)



runwd <- file.path("/Users/LiLei/Projects/B_mex/runGenespace")
#make_exampleDataDir(writeDir = runwd)
gids <- c("Osat","Bsyl","Bstacei","Bmex","ABR113","Bhyb26","Bdist","Barb")
gpar <- init_genespace(
  genomeIDs = gids, 
  speciesIDs = gids, 
  versionIDs = gids, 
  outgroup = "Osat",
  ploidy = c(1,1,1,2,2,2,1,1),
  wd = runwd, 
  gffString = "gff", 
  pepString = "pep",
  path2orthofinder = "orthofinder", 
  path2mcscanx = "/Users/LiLei/softwares/MCScanX",
  rawGenomeDir = file.path(runwd, "rawGenomes"))


parse_annotations(
  gsParam = gpar, 
  gffEntryType = "gene", 
  gffIdColumn = "Name",
  gffStripText = "Name=", 
  headerEntryIndex = 4,
  headerSep = " ", 
  headerStripText = "locus=")
#troubleshoot = TRUE,

gpar <- run_orthofinder(gsParam = gpar)
gpar$params$nCores <- 1 #since there is an error happened. debug
system("ls -l /Users/LiLei/Projects/B_mex/SplitSubgenome/orthofinder/Results_Jun01/WorkingDirectory/")

gpar <- synteny(gsParam = gpar )
pg <- pangenome(gpar)

ripdat <- plot_riparianHits(gpar,refGenome = "Osat",
                            genomeIDs = c("Osat","Bsyl","Bstacei","Bmex","ABR113","Bhyb26","Bdist","Barb"),
                            verbose = F)


###run the whole set and see what is going on 
runwd <- file.path("/Users/LiLei/Projects/B_mex/SplitSubgenome")
#make_exampleDataDir(writeDir = runwd)
gids <- c("Osat","Bsyl","Bstacei","BmexU","BmexP","ABR113S","ABR113D","Bhyb26S","Bhyb26D","Bdist","Barb")
gpar <- init_genespace(
  genomeIDs = gids, 
  speciesIDs = gids, 
  versionIDs = gids, 
  outgroup = NULL,
  ploidy = rep(1,11),
  wd = runwd, 
  gffString = "gff", 
  pepString = "pep",
  path2orthofinder = "orthofinder", 
  path2mcscanx = "/Users/LiLei/softwares/MCScanX",
  rawGenomeDir = file.path(runwd, "rawGenomes"))


parse_annotations(
  gsParam = gpar, 
  gffEntryType = "gene", 
  gffIdColumn = "Name",
  gffStripText = "Name=", 
  headerEntryIndex = 4,
  headerSep = " ", 
  headerStripText = "locus=")
#troubleshoot = TRUE,

gpar <- run_orthofinder(gsParam = gpar)
gpar <- synteny(gsParam = gpar)
ripdat <- plot_riparianHits(gpar,refGenome = "Osat",
                            genomeIDs = c("Bsyl","Bstacei","BmexU","BmexP","ABR113S","ABR113D","Bhyb26S","Bhyb26D","Bdist","Barb"),
                            verbose = F)
pg <- pangenome(gpar)

#debug the code!!!!!
library(GENESPACE)
runwd <- file.path("/Users/LiLei/Projects/B_mex/debug")
#make_exampleDataDir(writeDir = runwd)
gids <- c("Osat","Bsyl","Bstacei","BmexU","BmexP","ABR113S","ABR113D","Bhyb26S","Bhyb26D","Bdist","Barb")
gpar <- init_genespace(
  genomeIDs = gids, 
  speciesIDs = gids, 
  versionIDs = gids,
  orthofinderInBlk = F, 
  ploidy = rep(1,11),
  wd = runwd, 
  gffString = "gff", 
  pepString = "pep",
  path2orthofinder = "orthofinder", 
  path2mcscanx = "/Users/LiLei/softwares/MCScanX",
  rawGenomeDir = file.path(runwd, "rawGenomes"))

  parse_phytozome(gpar)

gpar <- run_orthofinder(gsParam = gpar)
gpar <- synteny(gsParam = gpar)
ripdat <- plot_riparianHits(gpar,refGenome = "Osat",
                            genomeIDs = c("Osat","Bsyl","Bstacei","BmexU","BmexP","ABR113S","ABR113D","Bhyb26S","Bhyb26D","Bdist","Barb"),
                            verbose = F)
pg <- pangenome(gpar)
