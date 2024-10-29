# Here we create a data frame naming the pilot study images for download.

# Start with the data
pilotHTT_RST <- HTT::pilotHTT_RST

# Define the name of the collection
collection.name <- rep("Download-HTTpilotImages", nlevels(pilotHTT_RST$WSI))

# Give a description of the collection
collection.description <- rep("Download HTT pilot images.")

# Extract the image file names
slide.filename <- levels(pilotHTT_RST$WSI)

# Give a new name specific to the collection
slide.name <- gsub("-TILS", "download", slide.filename)
slide.name <- gsub(".ndpi", "", slide.name)

# Put it all together
pilotImagesHTT <- data.frame(
  collection.name = collection.name,
  collection.description = collection.description,
  slide.filename = slide.filename,
  slide.name = slide.name
)

# Save the data frame
write.csv(
  pilotImagesHTT,
  file.path("inst", "extdata", "pilotImagesHTT.csv"),
  row.names = FALSE
)
usethis::use_data(pilotImagesHTT, overwrite = TRUE)
