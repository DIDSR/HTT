# Two points determine a line.
# y = slope * (x - x1) + y1
# lineFromTwoPoints ###########################################################
#' @title Find the Y value at \code{inputX} of a line from two points
#'
#' @name lineFromTwoPoints
#'
#' @description This function finds the y value at \code{inputX} on a line defined by (\code{x1}, \code{y1}) and (\code{x2}, \code{y2})
#'
#' @param inputX (int) - The point at which to evaluate the line
#' @param x1 (num) - x-value for first point
#' @param y1 (num) - y-value for first point
#' @param x2 (num) - x-value for second point
#' @param y2 (num) - y-value for second point
#'
#' @return The y value of the line at \code{inputX} (num)
#' @export
#'
#' @examples
#' x <- 1:100
#' y <- lineFromTwoPoints(x, 1, 1, 100, 5)
lineFromTwoPoints <- function(inputX, x1, y1, x2, y2) {

  slope <- (y2 - y1) / (x2 - x1)
  outputY <- slope * (inputX - x1) + y1

  return(outputY)

}


# In this file we will compare the data from two readers
# getBlandAltmanWithDuplicates ################################################
#'
#' @title Compare the data from two readers (count duplicates).
#'
#' @description This function compares the scores from two readers. In a sense
#' it treats the comparisons as factors and counts the number of times specific
#' pairs of scores are repeated. This accounting allows a Bland-Altman plot
#' to be created with symbols scaled to the number of times each pair of score
#' is repeated.
#'
#' @param mrmcBRWM A data frame with the following (7) variables:
#' \itemize{
#'  \item \code{caseID} (factor) - ID for region of interest. Includes WSI, x position of ROI, y position of ROI, and length of ROI
#'  \item \code{modalityID.X} (factor) - Platform used by reader X (caMicro, pathPresenter, or eeDAP)
#'  \item \code{readerID.X} (factor) - reader ID of reader X
#'  \item \code{score.X} (num) - scores of reader X
#'  \item \code{readerID.Y} (factor) - reader ID of reader Y
#'  \item \code{modalityID.Y} (factor) - Platform used by reader Y (caMicro, pathPresenter, or eeDAP)
#'  \item \code{score.Y} (num) - scores of reader Y
#' }
#'
#' @return A data frame with the following (5) variables:
#' \itemize{
#'  \item \code{nobs} (int) - A vector of the number of observations
#'  \item \code{x} (num) - scores of reader x
#'  \item \code{y} (num) - scores of reader y
#'  \item \code{xyAvg} (num) - Averages of the scores between the two readers
#'  \item \code{xyDiff} (num) - Differences of the scores between the two readers
#' }
#' @export
#'
#' @examples
#' # Created between-reader, between modality paired data
#' mrmcBRWM <- iMRMC::getBRBM(pilotHTT, "camic", "camic")
#'
#' # Determine the frequency table for paired observations
#' resultBlaAlt <- HTT::getBlandAltmanWithDuplicates(mrmcBRWM)
#'
#' # Show the results
#' head(resultBlaAlt)
#' plot(resultBlaAlt$x, resultBlaAlt$y)
getBlandAltmanWithDuplicates <- function(mrmcBRWM) {

  # Since the data is discrete, there are many observations of specific paired scores.
  # Therefore, we create a frequency table for plotting.
  # Each plot symbol will be proportional to the frequency of observations.
  temp <- table(mrmcBRWM$score.X, mrmcBRWM$score.Y)


  # Find which table results have observations.
  index <- which(temp > 0, arr.ind = TRUE)
  index.x <- index[ , "row"]
  index.y <- index[ , "col"]

  # Create a vector of the number of observations
  nObs <- temp[index]

  # The row and column names are the values of paired scores.
  x <- rownames(temp)
  x <- as.numeric(x[index.x])
  y <- colnames(temp)
  y <- as.numeric(y[index.y])

  # Calculate the average and the difference
  xyAvg <- (x + y)/2
  xyDiff <- x - y

  result <- data.frame(
    nObs = nObs,
    x = x,
    y = y,
    xyAvg = xyAvg,
    xyDiff = xyDiff
  )

  return(result)
}
