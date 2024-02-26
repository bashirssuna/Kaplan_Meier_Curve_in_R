#Install required packages

#install.packages(c("tidyverse", "survminer", "survival"))

library(tidyverse)
library(survminer)
library(survival)

#load dataset
data("myeloma")

#Rename dataset (optionsl)
tutorial <- myeloma

#see column names
colnames(tutorial)

#fit a survival function for the whole data
fit1 <- survfit(Surv(time, event)~1, data = tutorial)

#create the KM curve for the fitted data
ggsurvplot(fit1, data = tutorial)

#You can add a median survival line, a risk table plus labels
Kmcurve1 <- ggsurvplot(fit1, data = tutorial, # nolint
                       surv.median.line = "hv", # Add medians survival
                       
                       # Change legends: title & labels
                       legend.title = "Kaplan Meier Survival Curve",
                       
                       # Add risk table
                       risk.table = T,
                       tables.height = 0.2,
                       tables.theme = theme_cleantable(),
                       
                       # Color palettes. Use custom color: c("#E7B800", "#2E9FDF"),
                       # or brewer color (e.g.: "Dark2"), or ggsci color (e.g.: "jco")
                       palette = c("#ed9a9a"),
                       ggtheme = theme_bw() # Change ggplot2 theme
)

print (Kmcurve1)

#fit survival data for the categorical variable
fit <- survfit(Surv(time, event) ~ chr1q21_status, data= tutorial) 

#plot the KM curve 
ggsurvplot(fit, data = tutorial)

#Add median survival time line, 95%CI and Pvalue to the comparison
Kmchr <- ggsurvplot(fit, data = tutorial,
                    surv.median.line = "hv", # Add medians survival
                    
                    # Change legends: title & labels
                    legend.title = "chromosome type",
                    legend.labs = c("2", "3", "4+"),
                    # Add p-value and tervals
                    pval = TRUE,
                    
                    conf.int = F,
                    # Add risk table
                    risk.table = F,
                    tables.height = 0.2,
                    tables.theme = theme_cleantable(),
                    
                    # Color palettes. Use custom color: c("#E7B800", "#2E9FDF"),
                    # or brewer color (e.g.: "Dark2"), or ggsci color (e.g.: "jco")
                    palette = c("#E7B800", "#2E9FDF", "#FF0000"),
                    ggtheme = theme_bw() # Change ggplot2 theme
)


print(Kmchr)

# Change font size, style and color at the same time
ggsurvplot(fit, data = tutorial,  main = "Survival curve",
           font.main = c(16, "bold", "darkblue"),
           font.x = c(14, "bold.italic", "red"),
           font.y = c(14, "bold.italic", "darkred"),
           font.tickslab = c(12, "plain", "darkgreen"))
