# Test R^2

all_trans_estimates = c(103.5,22.4,43.5,102.0,43.0,200.0)
all_truth_estimates = c(103.7,12.4,43.5,103.0,19.0,150.0)

plot(all_truth_estimates,all_trans_estimates)
cor(all_truth_estimates,all_trans_estimates)

fit <- lm(all_truth_estimates ~ all_trans_estimates)
fit
k = summary(fit, correlation = TRUE, method="pearson")
k$r.squared

(k$r.squared)^2

library(Hmisc)
rcorr(all_truth_estimates,all_trans_estimates, type="pearson")


RMSE <- sqrt(mean((all_trans_estimates-all_truth_estimates)^2))

scaled_error <- function(estimate, truth) {
  2 *(estimate - truth)  / (estimate + truth)
}

med_scaled_err = median(abs(scaled_error(all_trans_estimates, all_truth_estimates)))

mean(abs(scaled_error(all_trans_estimates, all_truth_estimates))) 
                        