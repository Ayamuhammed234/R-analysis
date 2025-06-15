# Depression Score Analysis

This is an R script that analyzes depression scores collected through a survey. The goal was to explore how depression relates to variables like gender, age, and hours worked.

## What’s in this project

- `analysis.R`: Main R script that:
  - Loads and cleans the dataset
  - Calculates summary stats
  - Runs t-tests and correlations
  - Creates basic plots
  - Exports a summary table

## Data

The dataset (`data_sts2.csv`) includes:
- Age, gender, hours worked
- Depression scores (numeric)
- Depression severity (None to Severe)
- Other background info (career stage, governorate, etc.)


##  R Packages used

- `tidyverse`: For data manipulation and plotting
- `effsize`: For Cohen's d effect size

##  Outputs

- Bar plot: Depression severity by gender
- Scatter plot: Age vs depression score
- Summary table (saved as `summary_by_gender.csv`)


## How to run

Make sure you have `tidyverse` and `effsize` installed:

```r
install.packages("tidyverse")
install.packages("effsize")
