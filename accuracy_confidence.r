# Calculates percent of responses correct by subject and finds
# average confidence when correct and when incorrect
#
# Hussain Jafari

TRIAL_THRESHOLD <- 60

fix.report <- read.csv("FixReport.csv", sep="\t")

# Replace TRIAL_LABEL col with numeric values
trials.num <- gsub("Trial: ", "", fix.report[,2])
trials.num <- as.numeric(as.character(trials.num))
fix.report$TRIAL_LABEL <- trials.num

# Only keep trials above TRIAL_THRESHOLD
fix.report <- fix.report[fix.report$TRIAL_LABEL > TRIAL_THRESHOLD, ]

# Reverse rows 
fix.report <- fix.report[rev(rownames(fix.report)), ]
# Index which rows are duplicates for both subject and trial
duplicates.bool <- duplicated(fix.report[, 1:2])
# Delete duplicates, keeping only last fixation for each trial
fix.report <- fix.report[!duplicates.bool, ]
#Reverse again to keep ascending order
fix.report <- fix.report[rev(rownames(fix.report)), ]

# Replace subject label with numeric values
subject.num <- gsub("hs", "", fix.report$RECORDING_SESSION_LABEL)
subject.num <- as.numeric(as.character(subject.num))
fix.report$RECORDING_SESSION_LABEL <- subject.num

#Replace values of (-)999 in relevant columns
fix.report[fix.report$CURRENT_FIX_INTEREST_AREA_INDEX == 999, 3] <- NA
fix.report[fix.report$confidence == -999, 20] <- NA

# Append a column saying whether subject responded correctly 
correct <- fix.report$CURRENT_FIX_INTEREST_AREA_INDEX == fix.report$targetcolumn
fix.report$correct <- as.numeric(correct)

# Calculate average percent correct by subject
avg.accuracy <- aggregate(fix.report$correct, list(fix.report$RECORDING_SESSION_LABEL), mean, na.rm=T)

# Calculate confidence separately for correct and incorrect responses
trials.correct <- fix.report[fix.report$correct == 1, ]
trials.incorrect <- fix.report[fix.report$correct == 0, ]
conf.correct <- aggregate(trials.correct$confidence, list(trials.correct$RECORDING_SESSION_LABEL), mean, na.rm=T)
conf.incorrect <- aggregate(trials.incorrect$confidence, list(trials.incorrect$RECORDING_SESSION_LABEL), mean, na.rm=T)

#Combine results into table
table <- cbind(avg.accuracy, conf.correct, conf.incorrect)
table <- table[, c(2,4,6)]
colnames(table) <- c("accuracy", "correct.conf", "incorrect.conf")

