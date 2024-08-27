# Edit pilotHTT data for RST
# Remove extra columns and rename colnames for clarity


# Load data ####
load("C:/000-github/HTT/inst/extra/pilotHTT-RST/pilotHTT-rst-20220506.rda")

pilotHTT_RST <- pilotHTT

# Remove extra columns ####
# Remove: score, createDate, task, inputFileName,
  # percentStroma (40% missing), viewerHeight (21% missing),
  # viewerWidth (21% missing), viewerMag (31% missing)
  # labelROI

pilotHTT_RST <- subset(pilotHTT_RST, select = -score)
pilotHTT_RST <- subset(pilotHTT_RST, select = -createDate)
pilotHTT_RST <- subset(pilotHTT_RST, select = -task)
pilotHTT_RST <- subset(pilotHTT_RST, select = -inputFileName)
pilotHTT_RST <- subset(pilotHTT_RST, select = -percentStroma)
pilotHTT_RST <- subset(pilotHTT_RST, select = -viewerHeight)
pilotHTT_RST <- subset(pilotHTT_RST, select = -viewerWidth)
pilotHTT_RST <- subset(pilotHTT_RST, select = -viewerMag)
pilotHTT_RST <- subset(pilotHTT_RST, select = -labelROI)

# Rename colnames ####
# VTA -> evaluable
names(pilotHTT_RST)[names(pilotHTT_RST) == "VTA"] <- "evaluable"

# Reorder columns ####
colOrder <- c("batch", "WSI", "caseID", "readerID", "modalityID",
              "evaluable", "densityTILs",
              "experience", "experienceResident")

pilotHTT_RST <- pilotHTT_RST[, colOrder]


# Save Data ####
# Save data (.rda)
usethis::use_data(pilotHTT_RST, overwrite = TRUE)

# Save data (.csv)
write.csv(
  pilotHTT_RST,
  "inst/extra/pilotHTT-RST/pilotHTT_RST.csv",
  row.names = FALSE, quote = FALSE
)


