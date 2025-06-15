# load packages
library(tidyverse)
library(effsize)

# read data
data <- read.csv("data_sts2.csv", header = FALSE)

# rename columns (just the ones we care about now)
colnames(data)[1:17] <- c("timestamp", "consent", "career_stage", "age", "gender", 
                          "marital_status", "governorate", "workplace", "specialty", 
                          "psychiatric_meds", "med_names", "chronic_disease", 
                          "disease_name", "disease_onset", "hours_worked", 
                          "depression_score", "depression_severity")

# convert types
data$age <- as.numeric(data$age)
data$hours_worked <- as.numeric(data$hours_worked)
data$depression_score <- as.numeric(data$depression_score)

# fix levels for factors
data$gender <- factor(data$gender, levels = c("Male", "Female", "Other"))
data$depression_severity <- factor(data$depression_severity, 
                                   levels = c("None", "Mild", "Moderate", "Severe"), 
                                   ordered = TRUE)

# remove NA values (for age and depression score only)
data <- data[!is.na(data$age) & !is.na(data$depression_score), ]

# basic stats
print(summary(data$age))
print(summary(data$depression_score))

# gender count
table(data$gender)

# depression severity distribution
table(data$depression_severity)

# t-test for depression score by gender
t.test(depression_score ~ gender, data = data)

# cohen's d
cohen.d(depression_score ~ gender, data = data)

# correlation between age and depression
cor.test(data$age, data$depression_score)

# correlation between hours worked and depression
cor.test(data$hours_worked, data$depression_score, use = "complete.obs")

# barplot: depression severity by gender
ggplot(data, aes(x = depression_severity, fill = gender)) +
  geom_bar(position = "dodge") +
  labs(title = "Depression Severity by Gender", x = "Severity", y = "Count")

# scatterplot: age vs depression
ggplot(data, aes(x = age, y = depression_score, color = gender)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE)

# summary by gender
summary_table <- data %>%
  group_by(gender) %>%
  summarise(
    count = n(),
    avg_age = mean(age, na.rm = TRUE),
    avg_depression = mean(depression_score, na.rm = TRUE)
  )

print(summary_table)

# save summary table
write.csv(summary_table, "summary_by_gender.csv", row.names = FALSE)