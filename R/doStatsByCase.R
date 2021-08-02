# doStatsByCase ###############################################################
#'
#' @title Summarize the scores for each case of a data frame
#'
#' @description
#'  This function creates a one row data frame that summarizes the scores for
#'   each case of an imported data frame (\code{mrmcByCase.cur}).
#'
#' @param mrmcByCase.cur A data frame with the following variables: batch, WSI,
#'  caseID, modalityID, score, labelROI.
#'
#' @return A data frame (one row) with the following (11) variables:
#' \itemize{
#'  \item \code{batch} (factor) - Batch number of image annotated by the reader
#'   (8 batches in total)
#'  \item \code{WSI} (factor) - Whole case file name of whole slide image
#'   annotated by reader
#'  \item \code{caseID} (factor) - ID for region of interest. Includes WSI,
#'   x position of ROI, y position of ROI, and length of ROI
#'  \item \code{modalityID} (factor) - Platform used by viewer (caMicro,
#'   pathPresenter, or eeDAP)
#'  \item \code{nObs} (int) - Total number of observations
#'  \item \code{nObs.na} (int) - Number of observations labeled as not evaluable
#'  ... there is no score (NA)
#'  \item \code{nObs.evaluable} (int) - Number of observations labeled as
#'  evaluable ... a score has been provided
#'  \item \code{scoreMean} (num) - Average percent of area occupied by
#'   lymphocytes in tumor-associated stroma
#'  \item \code{scoreVar} (num) - Variance of the percentages of area occupied
#'   by lymphocytes in tumor-associated stroma
#'  \item \code{CV} (num) - Coefficient of variation of the percent area
#'   occupied by lymphocytes in tumor-associated stroma (sqrt(scoreVar) / scoreMean)
#'  \item \code{labelMajority} (chr) - The majority label of ROI
#'  \item \code{labelEntropy} (num) - The entropy of the observed label distribution
#' }

#' @export
#'
# @examples
doStatsByCase <- function(mrmcByCase.cur) {

  # Grab the key covariates
  batch <- mrmcByCase.cur$batch[1]
  WSI <- mrmcByCase.cur$WSI[1]
  caseID <- mrmcByCase.cur$caseID[1]
  modalityID <- mrmcByCase.cur$modalityID[1]

  # Summarize the distribution of scores
  nObs <- nrow(mrmcByCase.cur)
  nObs.na <- nrow(mrmcByCase.cur[is.na(mrmcByCase.cur$score), ])
  nObs.evaluable <- nObs - nObs.na

  scoreMean <- NA
  scoreVar <- NA
  CV <- NA
  if (nObs.evaluable > 0) {
    scoreMean <- mean(mrmcByCase.cur$score, na.rm = TRUE)
    scoreVar <- stats::var(mrmcByCase.cur$score, na.rm = TRUE)

    if (scoreMean == 0) CV <- -1 else CV <- sqrt(scoreVar) / scoreMean

  }

  # Summarize the distribution of labels
  labelDist <- table(mrmcByCase.cur$labelROI)

  # Determine the names of the columns that correspond to the majority
  labelMajority <- names(which(labelDist == max(labelDist)))
  # There could be multiple columns if there are ties. Combine!
  labelMajority <- paste(labelMajority, collapse = " *AND* ")

  # Determine the entropy (uncertainty/variability) of the label distribution
  labelFreq <- labelDist/sum(labelDist)
  labelEntropy <- labelFreq * log(labelFreq)
  labelEntropy[is.nan(labelEntropy)] <- 0
  labelEntropy <- -sum(labelEntropy)

  # Pack everything in a return list
  resultByCase.cur <- data.frame(

    batch = batch,
    WSI = WSI,
    caseID = caseID,
    modalityID = modalityID,

    nObs = nObs,
    nObs.evaluable = nObs.evaluable,
    nObs.na = nObs.na,
    scoreMean = scoreMean,
    scoreVar = scoreVar,
    CV = CV,
    labelMajority = labelMajority,
    labelEntropy = labelEntropy

  )

  return(resultByCase.cur)

}
