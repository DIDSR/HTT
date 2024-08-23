# pilotHTT ########################################################
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
#'      pathologists. If experience == 100, experience is unknown
#'     \item \code{experienceResident} (num) - Number of years in residency
#'      for non-pathologists. If experienceResident == 100, experience is unknown
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
#'   platforms. Please refer to [https://github.com/DIDSR/HTT/blob/main/README.md](https://github.com/DIDSR/HTT/blob/main/README.md).
#'   for more information about the data.
#'
#'   As of 6 May 2022, this data contains 7898 observations of 18 variables.
#'
#    This data is saved as rda and csv files.
#'
NULL

# . #################################################################

# cleanReaders ######################################################
#' @title Information about the readers in this study
#'
#' @name cleanReaders
#'
#' @description
#'   This file contains the information about the readers in this study. It has
#'    been cleaned of PII (names and emails)
#'
#' @return
#'   A data fame with the following (3) variables:
#'   \itemize{
#'    \item \code{readerID} (factor) - ID of participant (profession and ID
#'     number)
#'    \item \code{experience} (num) - Number of years of experience for
#'     pathologists
#'    \item \code{experienceResident} (num) - Number of years in residency for
#'     non-pathologists
#'   }
#'
#' @usage
#'   cleanReaders
#'
#' @details
#'  readerID updated from reader#### to profession### depending on the number
#'   of years of experience and experienceResident
#'
#'  This data is saved as rda and csv files
NULL

# casesHTT ##########################################################
#' @title Original image file names and related information for HTT cases
#'
#' @name casesHTT
#'
#' @description This file contains the original image file names and related information for the HTT cases. The data collected from caMicroscope, eeDAP, and pathPresenter.
#'
#' @usage
#'   casesHTT
#'
#' @details
#'  View the image and scanner information of casesHTT:
#'  \code{\link{scannerInformationCasesHTT}}.
#'
#  \strong{Suggestions from Ashish Sharma: ####}
#  When downloading large quantities of images from box,
#  consider using rclone.org. It’s an OSS that allows you to
#  rsync w/ Box etc. We use it all the time to move stuff from
#  cloud stores to Linux boxes.
#
#  An alternative for storage could be via Google Cloud (not Google Drive).
#  It’d be easy to try.
#  \itemize{
#    \item 1.	Can you create an account on console.cloud.google.com ?
#    \item 2.	It will ask you for a credit card #'  and issue you $300 in free credits.
#    \item   a.	Accept it
#    \item 3.	Send me the email address you used to create this account
#    \item 4.	I will then add you to a bucket where you can upload the images.
#    \item   a.	I can then share those w/ Matt.
#  }
#'
#' @return
#'  The dataframe contains 9 columns:
#'  \itemize{
#'  \item \code{batch} (chr) - Batch number of image annotated by the reader
#'    (8 batches in total)
#'  \item \code{scanYear} (int) - Year when the slide was scanned
#'  \item \code{WSIoriginal} (chr) - New whole case file name of whole slide
#'    image annotated by reader
#'  \item \code{WSInew} (chr) - Original whole case file name of whole slide
#'    image annotated by reader
#'  \item \code{cancerType} (chr) - Type of cancer of slides
#'  \item \code{sampleType} (chr) - Type of tissue sample (biopsy or resection)
#'  \item \code{glassSlideRecieved} (logical) - If the glass slide of the sample
#'    was received by the FDA
#'  \item \code{note} (logical) - Additional notes
#'  \item \code{received} (chr) - Method by which images were received
#'  }
NULL

# roisHTT ###########################################################
#' @title Information about the ROIs in this study
#'
#' @name roisHTT
#'
#' @description
#'   This file contains the information about the regions of interest (ROIs)
#'   in this pilot study. The data frame
#'   includes information about the image file names and the position of
#'   ROIs within the slides.
#'
#' @details
#'   There are 640 ROIs in the pilot study: 64 images x 10 ROIs per image.
#'   ROIs were selected before data collection. Please refer to
#'   \href{https://arxiv.org/abs/2010.06995}{this manuscript}
#'   for information about ROI selection and to see a few samples.
#'
#' @usage
#'   roisHTT
#'
#' @return
#'  The data frame contains 10 columns:
#'  \itemize{
#'  \item \code{task} (chr)- Task Pathologists were asked to complete
#'  \item \code{batch} (factor) - Batch Number
#'  \item \code{WSI} (factor) - Slide number
#'  \item \code{ROI} (factor) - Region of Interest analyzed
#'  \item \code{left, top, width, height} - All Numeric - Indicate the position
#'   of the ROI on the slide
#'  \item \code{widthMicrons and heightMicrons} - Numeric - Indicate the size
#'   of the ROI in Microns
#'  }
NULL

# . #################################################################

# scanner Information CasesHTT ########################################
#' @title Scanner information of \code{\link{casesHTT}}
#'
#' @name scannerInformationCasesHTT
#'
#' @description This documentation includes the scanner information of
#'  \code{\link{casesHTT}}
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

# pilotHTT_RST ########################################################
#' @title Simplified annotation data of the pilot study
#'
#' @name pilotHTT_RST
#'
#' @return
#'   A data frame with the following (10) variables:
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
#'     \item \code{labelROI} (factor) - Label of region of interest
#'      (Intra-Tumoral Stroma, Invasive Margin, Tumor with No Intervening
#'       Stroma, other regions)
#'     \item \code{evaluable} (logical) - Indicates whether the region of interest
#'      is appropriate for sTIL evaluation
#'     \item \code{densityTILs} (num) - Percent of area occupied by lymphocytes
#'      in \code{Intra-Tumoral Stroma}.
#'     \item \code{experience} (num) - Number of years of experience for
#'      pathologists. If experience == 100, experience is unknown
#'     \item \code{experienceResident} (num) - Number of years in residency
#'      for non-pathologists. If experienceResident == 100, experience is unknown
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
#'   platforms. Please refer to [https://github.com/DIDSR/HTT/blob/main/README.md](https://github.com/DIDSR/HTT/blob/main/README.md).
#'   for more information about the data.
#'
#'   As of 6 May 2022, this data contains 7898 observations of 18 variables.
#'
#    This data is saved as rda and csv files.
#'
NULL
