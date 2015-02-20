#Cleaning up fixation report data

#Load fixation report into R
fix.report <- read.csv("FixReport.csv", sep="\t")

#Convert each subject ID into a numeric variable
fixation.num <- gsub("hs", "", fix.report[, 1])
fixation.num <- as.numeric(as.character(fixation.num))
fix.report$RECORDING_SESSION_LABEL <- fixation.num

#Convert trial number into a numeric variable
trials.num <- gsub("Trial: ", "", fix.report[, 2])
trials.num <- as.numeric(as.character(trials.num))
fix.report$TRIAL_LABEL <- trials.num

#Keep only last trial for each subject
subfix.report <- fix.report[rev(rownames(fix.report)), ]
duplicates <- duplicated(subfix.report[, 1:2])
subfix.report <- subfix.report[!duplicates, ]

#Create a new data frame containing only cases where subject selected correct target
subfix.report <- subfix.report[rev(rownames(subfix.report)), ]
subfix.report$correct <- subfix.report$CURRENT_FIX_INTEREST_AREA_INDEX == subfix.report$targetcolumn
subfix.report$correct <- as.numeric(subfix.report$correct)

#Represent NAs properly rather than as 999
subfix.report[subfix.report$CURRENT_FIX_INTEREST_AREA_INDEX == 999, 21] <- NA

#Create a new column in our data frame that says how many times the subject picked correctly
#throughout all of their trials
num.repeats <- table(sec.fix.report$TRIAL_LABEL, sec.fix.report$RECORDING_SESSION_LABEL)
repeats.df <- as.data.frame(num.repeats)
correct <- rep(subfix.report$correct, repeats.df$Freq)
fix.report$correct <- correct
