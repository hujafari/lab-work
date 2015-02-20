# lab-work

Here are some pieces of code that I wrote while volunteering at the Rayner Eyetracking Lab at UCSD.

Descriptions:
Subjects were shown a specific object, and then asked to pick that same object later in the trial while presented with 5 
other objects while reporting their confidence on a scale from 1-6 in their choice. Data was stored tracking their eye 
movements. One trial corresponded to one object.

accuracy_confidence.r - Calculate the average accuracy of each subject across their trials, their average confidence
                        when they made the correct choice, and their average confidence when they made the incorrect choice.

clean_fix_report.r - Clean up the data report by changing variable to proper formats, taking care of NAs, extracting 
                     only the data we're interested in, etc.
                     
Although I can't upload the original data and the code therefore can't be run, I've also included some of the output from
these files in this folder. All .csv files are comma-delimited.

AccuracyAndConfs.csv - Output of accuracy_confidence.r

ConfidenceNAs.csv - Subjects and trials for which confidence data was not available

FixationNAs.csv - Subjects and trials for which last fixation (area where subject's eyes were looking) was not available

TotalTargetViewingTime.csv - For how many milliseconds in each trial did the subject look at the correct target
