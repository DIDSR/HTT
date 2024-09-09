## Merge not collected information from
## casesHTT into pilotHTT
## Then, remove casesHTT and pilotHTT from package

# Load Data ####
load("C:/000-github/HTT/data/casesHTT.rda")
load("C:/000-github/HTT/data/pilotHTT.rda")

# Create new pilotHTT ####
pilotHTTnew <- pilotHTT

pilotHTTnew$WSI <- as.character(pilotHTTnew$WSI)

# Merge columns from casesHTT into pilotHTT ####
# Cols to merge: scanYear, WSIoriginal, cancerType,
# sampleType, glassSlideReceived

# scanYear
pilotHTTnew$scanYear <- NA
for(i in 1:nrow(pilotHTTnew)) {
  wsi <- pilotHTTnew[i, "WSI"]
  pilotHTTnew[i, "scanYear"] <- casesHTT[casesHTT$WSInew == wsi, "scanYear"]
}

# WSIoriginal
pilotHTTnew$WSIoriginal <- NA
for(i in 1:nrow(pilotHTTnew)) {
  wsi <- pilotHTTnew[i, "WSI"]
  pilotHTTnew[i, "WSIoriginal"] <- casesHTT[casesHTT$WSInew == wsi, "WSIoriginal"]
}

# cancerType
pilotHTTnew$cancerType <- NA
for(i in 1:nrow(pilotHTTnew)) {
  wsi <- pilotHTTnew[i, "WSI"]
  pilotHTTnew[i, "cancerType"] <- casesHTT[casesHTT$WSInew == wsi, "cancerType"]
}

# sampleType
pilotHTTnew$sampleType <- NA
for(i in 1:nrow(pilotHTTnew)) {
  wsi <- pilotHTTnew[i, "WSI"]
  pilotHTTnew[i, "sampleType"] <- casesHTT[casesHTT$WSInew == wsi, "sampleType"]
}

# glassSlideReceived
pilotHTTnew$glassSlideReceived <- NA
for(i in 1:nrow(pilotHTTnew)) {
  wsi <- pilotHTTnew[i, "WSI"]
  pilotHTTnew[i, "glassSlideReceived"] <- casesHTT[casesHTT$WSInew == wsi, "glassSlideReceived"]
}

# Save new data ####
pilotHTT <- pilotHTTnew

# Save data (.rda)
usethis::use_data(pilotHTT, overwrite = TRUE)

# Save data (.csv)
write.csv(
  pilotHTT_RST,
  "inst/extdata/pilotHTT.csv",
  row.names = FALSE, quote = FALSE
)
