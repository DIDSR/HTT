# agreeDensityBRBM ##################################################
#' @title Create and analyze paired-reader data
#'
#' @details This function compares and analyzes the paired scores of all pairs
#' of readers for every annotated region of interest (\code{caseID}).
#'
#'   The input data frame is filtered according to \code{modalityLabel}. Then,
#'   the function pairs the "between-reader data" and filters it according to
#'   \code{subgroupLabel}. Then for each pair of readers, the function calculates
#'   summary statistics, including the average squared differences of the
#'   \code{score}s.
#'
#' @param mrmcDF (data.frame) - Data frame for analysis
#' @param modalityLabel (chr) - Platform used by the readers. Possible
#'   values:("1: camic", "2: eedap", "3: pathp", "4: all", or "5: all panel")
#' @param subgroupLabel (chr) - Range of scores analyzed by readers.
#'   Possible Values: ("1: all considered", "2: avg. less than or equal to 10",
#'   "3: avg. greater than 10 and less than or equal to 40", "4: avg. greater
#'   than 40", "5: score.X equal to zero")
#'
#' @return A large list that contains the following elements:
#' \itemize{
#'  \item \code{modalityLabel} (chr) - Platform used by the readers
#'  \item \code{subgroupLabel} (chr) - Range of scores analyzed by readers
#'  \item \code{modalityID} (chr) - Platform used to analyze slides
#'  \item \code{nR} (int) - Number of total readers
#'  \item \code{readers} (chr) - readerID of all readers
#'  \item \code{xlim.filter} (num) - Range of scores (1-100) analyzed by readers
#'  \item \code{mrmcDF} (data frame) - Data frame that contains the annotation
#'    data filtered according to \code{modalityLabel}. This will be
#'    \code{\link{pilotHTT}} or some filtered version
#'  \item \code{mrmcBRWM} (data frame) -  Data frame that compares the scores
#'    of all paired readers for the same annotated region of interest (caseID).
#'    Data contains the following variables:
#'  \enumerate{
#'    \item \code{caseID} (fact) - ID for region of interest
#'    \item \code{readerID.X} (fact) - readerID of reader X
#'    \item \code{modalityID.X} (fact) - modality used by reader X
#'    \item \code{score.X} (num) - score by reader X
#'    \item \code{readerID.Y} (fact) - readerID of reader Y
#'    \item \code{modalityID.Y} (fact) - modality used by reader Y
#'    \item \code{score.Y} (num) - score by reader Y
#'  }
#'  \item \code{resultsBRWM} (data.frame) - Data containing the average squared
#'    difference for all pairs of readers. Data contains the following variables:
#'  \enumerate{
#'    \item \code{modalityID} (chr) - modality used used to annotate ROI
#'    \item \code{readerID.1} (chr) - readerID of reader 1
#'    \item \code{readerID.2} (chr) - readerID of reader 2
#'    \item \code{nObs} (num) - number of paired observations
#'    \item \code{MSD} (num) - Average of the \code{score}s' squared differences
#'  }
#'
#' }
#'
#' @export
#'
#' @examples
#' results <- agreeDensityBRBM(HTT::pilotHTT)
#' str(results)

agreeDensityBRBM <- function(
  mrmcDF,
  modalityLabel = "5: all panel",
  subgroupLabel = "1: all considered"
) {

  # Filter by modality label #################################################
  if (modalityLabel == "1: camic") {
    modalityID <- "camic"
    mrmcDF <- mrmcDF[mrmcDF$modalityID == "camic", ]

  } else if (modalityLabel == "2: eedap") {
    modalityID <- "eedap"
    mrmcDF <- mrmcDF[mrmcDF$modalityID == "eedap", ]

  } else if (modalityLabel == "3: pathp") {
    modalityID <- "pathp"
    mrmcDF <- mrmcDF[mrmcDF$modalityID == "pathp", ]

  } else if (modalityLabel == "4: all") {

    modalityID <- "all"

    # Preserve the original modality and create an "all" modality
    # modalityID column is column with "all"
    # mrmcDF$modalityID.orig is column with original modalityID

    mrmcDF$modalityID.orig <- mrmcDF$modalityID
    mrmcDF$modalityID <- "all"
    mrmcDF$modalityID <- factor(mrmcDF$modalityID)

    # Some readers acted on more than one modality. Keep their data separate.
    mrmcDF$readerID.orig <- mrmcDF$readerID
    mrmcDF$readerID <- paste(mrmcDF$readerID, mrmcDF$modalityID.orig, sep = ".")
    mrmcDF$readerID <- factor(mrmcDF$readerID)

  } else if (modalityLabel == "5: all panel") {

    modalityID <- "all"

    # Preserve the original modality and create an "all" modality
    mrmcDF$modalityID.orig <- mrmcDF$modalityID
    mrmcDF$modalityID <- "all"
    mrmcDF$modalityID <- factor(mrmcDF$modalityID)

    # Some readers acted on more than one modality. Keep their data separate.
    mrmcDF$readerID.orig <- mrmcDF$readerID
    mrmcDF$readerID <- paste(mrmcDF$readerID, mrmcDF$modalityID.orig, sep = ".")
    mrmcDF$readerID <- factor(mrmcDF$readerID)

    # Now limit data to the panel
    reader.panel <- c(
      "pathologist4776.pathp",
      "pathologist5857.camic",
      "resident4237.camic",
      "unknown1105.camic"
    )
    mrmcDF <- mrmcDF[mrmcDF$readerID %in% reader.panel, ]
    mrmcDF$readerID <- factor(mrmcDF$readerID)

  } else {
    print(paste("Input modalityID is", modalityID))
    desc <- paste("modalityID is not one of the choices: all, camic, eedap, pathp")
    stop(desc)
  }

  # Filter out rows with NA
  mrmcDF <- mrmcDF[!is.na(mrmcDF$score), ]



  # doStatsByCase #############################################################
  # The results will be used to filter by subgroupLabel

  # Split the data by caseID
  mrmcByCase <- split(mrmcDF, mrmcDF$caseID)

  # Calculate the stats by case
  statsByCase <- lapply(mrmcByCase, HTT::doStatsByCase)
  statsByCaseDF <- do.call(rbind, statsByCase)

  # Filter out missing data (data without enough observations for calculating
  # the mean or variance)
  index <- !is.na(statsByCaseDF$scoreVar)
  statsByCaseDF <- statsByCaseDF[index, ]



  # Get between-reader data ###################################################
  # Each row contains:
  #   caseID,
  #   readerID.X, modalityID.X, score.X
  #   readerID.Y, modalityID.Y, score.Y
  mrmcBRWM <- iMRMC::getBRBM(mrmcDF, modality.X = modalityID, modality.Y = modalityID)



  # Filter by subgroupLabel ###################################################
  # subgroupLabel <- "1: all considered"
  # subgroupLabel <- "2: avg. less than or equal to 10"
  # subgroupLabel <- "3: avg. greater than 10 and less than or equal to 40"
  # subgroupLabel <- "4: avg. greater than 40"
  # subgroupLabel <- "5: score.X equal to zero"
  if (subgroupLabel == "1: all considered") {
    xlim.filter <- c(0, 100)

  } else if (subgroupLabel == "2: avg. less than or equal to 10") {

    # Filter in data with scores <= 10
    index <- statsByCaseDF$scoreMean <= 10
    cases <- statsByCaseDF[index, "caseID"]

    mrmcDF <- mrmcDF[mrmcDF$caseID %in% cases, ]
    mrmcBRWM <- mrmcBRWM[mrmcBRWM$caseID %in% cases, ]

    xlim.filter <- c(0, 10)

  } else if (subgroupLabel == "3: avg. greater than 10 and less than or equal to 40") {

    # Filter in data with scores > 10 and scores <= 40
    index <- statsByCaseDF$scoreMean > 10 & statsByCaseDF$scoreMean <= 40
    cases <- statsByCaseDF[index, "caseID"]

    mrmcDF <- mrmcDF[mrmcDF$caseID %in% cases, ]
    mrmcBRWM <- mrmcBRWM[mrmcBRWM$caseID %in% cases, ]

    xlim.filter <- c(10, 40)

  } else if (subgroupLabel == "4: avg. greater than 40") {

    # Filter in data with scores > 40
    index <- statsByCaseDF$scoreMean > 40
    cases <- statsByCaseDF[index, "caseID"]

    mrmcDF <- mrmcDF[mrmcDF$caseID %in% cases, ]
    mrmcBRWM <- mrmcBRWM[mrmcBRWM$caseID %in% cases, ]

    xlim.filter <- c(40, 100)

  } else if (subgroupLabel == "5: score.X equal to zero") {
    index.TF <- mrmcBRWM$score.X == 0
    mrmcBRWM <- mrmcBRWM[ index.TF, ]
    xlim.filter <- c(0, 1)

  }

  # if (subgroupLabel == "1: all considered") {
  #   xlim.filter <- c(0, 100)
  # } else if (subgroupLabel == "2: avg. less than or equal to 10") {
  #   index.TF <- (mrmcBRWM$score.X + mrmcBRWM$score.Y)/2 <= 10
  #   mrmcBRWM <- mrmcBRWM[ index.TF, ]
  #
  #   xlim.filter <- c(0, 10)
  # } else if (subgroupLabel == "3: avg. greater than 10 and less than or equal to 40") {
  #   index.TF <- (mrmcBRWM$score.X + mrmcBRWM$score.Y)/2 > 10
  #   mrmcBRWM <- mrmcBRWM[ index.TF, ]
  #
  #   index.TF <- (mrmcBRWM$score.X + mrmcBRWM$score.Y)/2 <= 40
  #   mrmcBRWM <- mrmcBRWM[ index.TF, ]
  #
  #   xlim.filter <- c(10, 40)
  # } else if (subgroupLabel == "4: avg. greater than 40") {
  #   index.TF <- (mrmcBRWM$score.X + mrmcBRWM$score.Y)/2 > 40
  #   mrmcBRWM <- mrmcBRWM[ index.TF, ]
  #
  #   xlim.filter <- c(40, 100)
  # } else if (subgroupLabel == "5: score.X equal to zero") {
  #   index.TF <- mrmcBRWM$score.X == 0
  #   mrmcBRWM <- mrmcBRWM[ index.TF, ]
  #   xlim.filter <- c(0, 1)
  # }
  #
  # if (subgroupLabel == "equal to zero")
  #   mrmcBRWM <- mrmcBRWM[ mrmcBRWM$score.X == 0, ]
  #
  # if (subgroupLabel == "all considered")
  #   xlim.filter <- c(0, 100)
  #
  # if (subgroupLabel == "less than or equal to 10") {
  #   mrmcBRWM <- mrmcBRWM[ mrmcBRWM$score.X <= 10, ]
  #   xlim.filter <- c(0, 10)
  # }
  #
  # if (subgroupLabel == "greater than 10 and less than or equal to 40") {
  #   mrmcBRWM <- mrmcBRWM[ mrmcBRWM$score.X > 10, ]
  #   mrmcBRWM <- mrmcBRWM[ mrmcBRWM$score.X <= 40, ]
  #   xlim.filter <- c(10, 40)
  # }
  #
  # if (subgroupLabel == "greater than 40") {
  #   mrmcBRWM <- mrmcBRWM[ mrmcBRWM$score.X > 40, ]
  #   xlim.filter <- c(40, 100)
  # }



  # doAvgDelta2 -> resultsBRWM ###############################################
  # Let's split the data by the pairs of readers. The result is a list.
  # Each element of the list corresponds to a pair of readers.
  # Each element of the list is a data frame of cases read by the pair of readers.
  # Some elements of the list are empty because the readers don't read the same cases.
  # The list may be redundant. It contains the pair (reader1 x modality1, reader2 x modality2)
  mrmcByRRWM <- split(mrmcBRWM, list(mrmcBRWM$readerID.X, mrmcBRWM$readerID.Y))

  # These two vectors mimic how the readers are paired in mrmcByRRWM
  nR <- nlevels(mrmcDF$readerID)
  readers <- levels(mrmcDF$readerID)
  desc1 <- rep(levels(mrmcDF$readerID), nR)
  desc2 <- rep(levels(mrmcDF$readerID), each = nR)
  # Quick equality test
  all(paste(desc1, desc2, sep = ".") == names(mrmcByRRWM))

  # For each pair of readers, calculate the average squared differences
  doAvgDelta2 <- function(mrmcByRRWM.cur) {

    nObs <- nrow(mrmcByRRWM.cur)

    if (nObs == 0) return(data.frame(nObs = 0, MSD = NA))

    # Take the differences
    delta <- (mrmcByRRWM.cur$score.X - mrmcByRRWM.cur$score.Y)
    # Square the differences
    delta2 <- delta^2
    # Average the squared differences
    MSD <- sum(delta2)/nObs

    result <- data.frame(nObs = nObs, MSD = MSD)

    return(result)
  }

  # Calculate the average squared difference for all pairs of readers
  resultsByRRWM <- lapply(mrmcByRRWM, doAvgDelta2)
  resultsBRWM <- do.call("rbind", resultsByRRWM)

  # Add columns identifying the modality and reader
  resultsBRWM <- cbind(
    modalityID = rep(modalityID, nR*nR),
    readerID.1 = desc1,
    readerID.2 = desc2,
    resultsBRWM
  )



  # Return ####################################################################
  return(list(
    modalityLabel = modalityLabel,
    subgroupLabel = subgroupLabel,
    modalityID = modalityID,
    nR = nR,
    readers = readers,
    xlim.filter = xlim.filter,
    mrmcDF = mrmcDF,
    mrmcBRWM = mrmcBRWM,
    resultsBRWM = resultsBRWM
  ))

}
