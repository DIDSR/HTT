# pilotHTT ##########
#' @title Annotation data
#'
#' @name pilotHTT
#'
#' @return
#'   A data frame with the following (18) variables:
#'   \itemize{
#'     \item{\code{batch} (factor) - Batch number of image annotated by the
#'      reader (10 batches in total)
#'     \itemize{
#'           \item \code{FDA-HTT-batch00x} - Pilot Study annotations
#'           \item \code{FDA-HTT-Train00x} - Expert Panel annotations
#'           }}
#'     \item \code{WSI} (factor) - Whole case file name of whole slide image
#'      annotated by reader
#'     \item \code{caseID} (factor) - ID for region of interest. Includes WSI,
#'      x position of ROI, y position of ROI, and length of ROI
#'     \item{\code{readerID} (factor) - ID for each participant (profession
#'      with ID number)
#'     \itemize{
#'           \item There are four possible professions at the front end of
#'           readerID: pathologist, expert, resident, or unknown.
#'           \item \code{pathologist} - board-certified pathologist
#'           \item \code{expert} - member of the Expert Panel
#'           \item \code{resident} - in residency
#'           \item \code{unknown} - no indicated profession
#'           }}
#'     \item{\code{modalityID} (factor) - Platform used by viewer (caMicro,
#'      pathPresenter, eeDAP, or camic-expert)
#'      \itemize{
#'           \item \code{caMicro} - Digital annotations collected
#'           \item \code{pathPresenter} - Digital annotations collected
#'           \item \code{eeDAP} - Microscope annotations collected
#'           \item \code{camic-expert} - Digital Expert Panel annotations collected
#'            using the caMicroscope platform
#'           }}
#'     \item \code{score} (num) - Percent of area occupied by lymphocytes in
#'      \code{Intra-Tumoral Stroma}. (Same as \code{densityTILs}).
#'     \item \code{experience} (num) - Number of years of experience for
#'      pathologists. If experience == 100, experience is unknown.
#'      If experience == -1, experience is not applicable for the reader.
#'     \item \code{experienceResident} (num) - Number of years in residency
#'      for non-pathologists. If experienceResident == 100, experience is unknown.
#'      If experienceResident == -1, experience is not applicable for the reader.
#'     \item \code{labelROI} (factor) - Label of region of interest
#'      (Intra-Tumoral Stroma, Invasive Margin, Tumor with No Intervening
#'       Stroma, other regions)
#'     \item \code{VTA} (logical) - Indicates whether the region of interest
#'      is appropriate for sTIL evaluation
#'     \item \code{percentStroma} (num) - Percentage of tumor-associated stroma
#'      in region of interest
#'     \item \code{densityTILs} (num) - Percent of area occupied by lymphocytes
#'      in \code{Intra-Tumoral Stroma}. (Same as \code{score})
#'     \item \code{createDate} (POSIXct) - Date and time annotation was created
#'     \item \code{viewerWidth} (num) - Width of image viewed in pixels
#'     \item \code{viewerHeight} (num) - Height of image viewed in pixels
#'     \item \code{viewerMag} (num) - Magnification setting of the viewer when
#'      the data is saved
#'     \item \code{task} (factor) - Version number of platform
#'     \item \code{inputFileName} (chr) - File name of the input file
#' }
#'
#'
#' @description
#'   This file is the aggregate of all clean data from the High-Throughput
#'   Truthing project.
#'   It has been cleaned of PII (names and emails) and other non-essential columns.
#'
#' @usage
#'   pilotHTT
#'
#' @details
#'   This data was collected from the CAmicroscope, PathPresenter, and eeDAP
#'   platforms. Please refer to \href{https://github.com/DIDSR/HTT/blob/main/README.md}{https://github.com/DIDSR/HTT/blob/main/README.md}.
#'   for more information about the data.
#'
#'   As of 6 May 2022, this data contains 7898 observations of 18 variables.
#'
#    This data is saved as rda and csv files.
#'
NULL

# scanner Information CasesHTT ##########
#' @title Scanner information for the cases used in the HTT Pilot Study
#'
#' @name scannerInformationCasesHTT
#'
#' @description This documentation includes the scanner information of
#'  the HTT Pilot Study cases
#'
#'  \strong{Sample information}
#'
#'  The pilot study slides and images were provided by key collaborators
#'  Roberto Salgado and
#'  Denis Larsimont (Chair Department of Pathology, Jules Bordet Institut).
#'  Support staff were
#'  Ligia Craciun (Lead at Tumorbank, Dr Science) and
#'  Sélim-Alex Spinette (Lab tech at Tumorbank).
#'
#'  The data include slides that are either ductal or lobular
#'  breast cancer cases. Differentiating between ductal and lobular
#'  is often obvious. In Belgian, these are denoted as
#'  CCI = carcinome canalaire (ductal) invasive and
#'  CLI = carcinome lobulaire (lobular) invasive.
#'
#'  The data include slides of matching (same patient)
#'  biopsies or surgical resections.
#'
#'  Biopsies are taken before surgery to make a diagnosis.
#'
#'  The slides shared were re-cuts.
#'  The original slides were imaged in 2017 and 2018.
#'  We have 115 images of the slides imaged in 2017, but we don't (yet)
#'  have the information to link these images to the re-cuts.
#'
#'  Slides come from FFPE blocks and H&E staining. Every digital image was
#'   checked.
#'  If the tissue was bent, the process was repeated as needed.
#'
#'  Slide 66: Two tumor nodes are described. The morphologies are similar,
#'  but we cannot define exactly which node was taken at biopsy.
#'
#'  \strong{Scanner information}
#'
#'  Here are the details of the Nanozoomer 2.0-RS (Hamamatsu, Japan) under 40x
#'   magnification single-layer
#'  at the Jules Bordet Institute.
#'
#'  The images were scanned on one scanner, NanoZoomer 2.0-RS C10730 series.
#'  It is the high resolution and high-speed slide scanner that consists of
#'  Slide–feeder, X/Y Stage, Z focus motor, illumination system, optical
#'  components and TDI image sensor, this system realizes 1’ 40’’ / (20x)
#'    per slide (20 mm x 20 mm scanning area). The NanoZoomer-RS system can
#'  automatically load up to 6 glass slides at a 20x or 40x magnification.
#'  All digital images were scanned in single layer at 40x
#'   magnification.
#'
#'  This scanner is equipped with a 3CCD-TDI camera which allow for
#'  brightfield and fluorescence images with only one camera.
#'  Resolution is 0.23um/px at 40x and 0.46um/px at 20x
#'  The system is equipped with a 20x, 0.75NA objective lens, with a 2x relay lens.
#'  The images are always acquired at optical 40x, we do a 2x2 binning on the
#'   camera to have 20x resolution
#'  This offers the advantage of keeping the depth of field of a 20x but with the
#'   resolution of a 40x.
#'  For fluorescence capabilities, the system can host up to 6 excitation filter,
#'   2 dichroic mirrors, and 6 emission filters.
#'  Bordet is equipped to image Dapi/Fitc/Tritc/Cy3/Cy5 and equivalent.
#'
#'  You can download the NDP.view software for free from the Hamamatsu website.
#'
NULL

# pilotHTT_RST ##########
#' @title Simplified annotation data of the pilot study
#'
#' @name pilotHTT_RST
#'
#' @return
#'   A data frame with the following (9) variables:
#'   \itemize{
#'     \item{\code{batch} (factor) - Batch number of image annotated by the
#'      reader (10 batches in total)
#'     \itemize{
#'           \item \code{FDA-HTT-batch00x} - Pilot Study annotations
#'           \item \code{FDA-HTT-Train00x} - Expert Panel annotations
#'           }}
#'     \item \code{WSI} (factor) - Whole case file name of whole slide image
#'      annotated by reader
#'     \item \code{caseID} (factor) - ID for region of interest. Includes WSI,
#'      x position of ROI, y position of ROI, and length of ROI
#'     \item{\code{readerID} (factor) - ID for each participant (profession
#'      with ID number)
#'     \itemize{
#'           \item There are four possible professions at the front end of
#'           readerID: pathologist, expert, resident, or unknown.
#'           \item \code{pathologist} - board-certified pathologist
#'           \item \code{expert} - member of the Expert Panel
#'           \item \code{resident} - in residency
#'           \item \code{unknown} - no indicated profession
#'           }}
#'     \item{\code{modalityID} (factor) - Platform used by viewer (caMicro,
#'      pathPresenter, eeDAP, or camic-expert)
#'      \itemize{
#'           \item \code{caMicro} - Digital annotations collected
#'           \item \code{pathPresenter} - Digital annotations collected
#'           \item \code{eeDAP} - Microscope annotations collected
#'           \item \code{camic-expert} - Digital Expert Panel annotations collected
#'            using the caMicroscope platform
#'           }}
#'     \item \code{evaluable} (logical) - Indicates whether the region of interest
#'      is appropriate for sTIL evaluation
#'     \item \code{densityTILs} (num) - Percent of area occupied by lymphocytes
#'      in \code{Intra-Tumoral Stroma}.
#'     \item \code{experience} (num) - Number of years of experience for
#'      pathologists. If experience == 100, experience is unknown.
#'      If experience == -1, experience is not applicable for the reader.
#'     \item \code{experienceResident} (num) - Number of years in residency
#'      for non-pathologists. If experienceResident == 100, experience is unknown.
#'      If experienceResident == -1, experience is not applicable for the reader.
#' }
#'
#'
#' @description
#'   This file is the aggregate of all clean data from the High-Throughput
#'   Truthing project.
#'   It has been cleaned of PII (names and emails) and other non-essential columns. This is the simplified version of `pilotHTT` meant for the FDA Regulatory Science Tool (RST) Program.
#'
#' @usage
#'   pilotHTT_RST
#'
#' @details
#'   This data was collected from the CAmicroscope, PathPresenter, and eeDAP
#'   platforms. Please refer to \href{https://github.com/DIDSR/HTT/blob/main/README.md}{https://github.com/DIDSR/HTT/blob/main/README.md}.
#'   for more information about the data.
#'
#'   As of 6 May 2022, this data contains 7898 observations of 9 variables.
#'
#    This data is saved as rda and csv files.
#'
NULL

# pilotImagesHTT ##########
#' @title Data frame of names of pilot study images available for download
#'
#' @name pilotImagesHTT
#'
#' @return
#'   A data frame with the following (4) variables:
#'   \itemize{
#'       \item{\code{collection.name} name of the collection:
#'           "Download-HTTpilotImages"}
#'       \item{\code{collection.description} description of the collection:
#'           "Download HTT pilot images."}
#'       \item{\code{slide.filename} filename of the slide}
#'       \item{\code{slide.name} name of the slide to appear to user}
#'   }
#'
#'
#' @description
#'   This data frame is used to define the collection of pilot study images that
#'   are available for download. The data frame is available as an exported
#'   data object and as a human-readable csv file (folder extdata). The files
#'   are available for download from
#'   \href{https://wolf.cci.emory.edu/camic/htt/}{https://wolf.cci.emory.edu/camic/htt/}.
#'
#' @usage
#'   pilotImagesHTT
#'
#' @seealso \link{scannerInformationCasesHTT}
#'
#'
#' @examples
#' # Open and view the data object
#' pilotImagesHTT <- HTT::pilotImagesHTT
#' View(pilotImagesHTT)
#'
#'
#'
NULL
