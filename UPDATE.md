
## Version 2.0.0
*05/06/2022*

Update the data with the Expert Panel annotations and the 
R Markdown for this manuscript:

* Garcia et al. (2022 - Submitted). "Development of Training Materials for Pathologists to Provide Machine Learning Validation Data of Tumor-Infiltrating Lymphocytes in Breast Cancer," *Cancers*.


Changes include:

1. New `modalityID = "camic-expert"` that denotes the annotations from our 
Expert Panel.
2. Two new batches, `batch = "FDA-HTT-Train001"` and `"FDA-HTT-Train002"`. These
batches contain the ROIs scored by the Expert Panel.
3. New `readerID` of the experts appear as `“expert****”`
4. The R Markdown used to create the figures in the Cancers paper and a
copy of the PDF output are available in the folder 
`inst/extra/20220506-GarciaCancersPaper` to simplify reproducibility of the paper
in case some data formatting changes in the current `pilotHTT` data frame.

## Version 1.0.0
Creation of the HTT Project's Pilot Study annotation dataset.
