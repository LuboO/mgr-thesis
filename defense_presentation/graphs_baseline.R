ALPHA = 0.01
TRIALS = 1000

append_expected = function(observed, n) {
  rval = c()
  for (obs in seq(0, length(observed) - 1, by=1)) {
   p_obs = dbinom(obs, n, ALPHA)
   rval = c(rval, p_obs * TRIALS)
  }
  return (c(observed, rval))
}

calc_chisquare = function(dataset, test_count) {
  # Grouping the tail to avoid skewed chi-square
  obs = c()
  exp = c()
  cumulative_obs = 0
  cumulative_exp = 0
  for (fail in seq(length(dataset) - 1, 0, by=-1)) {
    cumulative_obs = cumulative_obs + dataset[fail + 1]
    cumulative_exp = cumulative_exp + (dbinom(fail, test_count, ALPHA) * TRIALS)
    if (cumulative_exp >= 5) {
      obs = c(obs, cumulative_obs)
      cumulative_obs = 0
      exp = c(exp, cumulative_exp)
      cumulative_exp = 0
    }
  }
  
  chi_stat = 0
  for(i in seq(1, length(obs))) {
    chi_stat = chi_stat + ((obs[i] - exp[i])^2)/exp[i]
  }
  rval = pchisq(chi_stat, length(obs) - 1, lower.tail = FALSE)
  return(rval)
}

batt = "Dieharder (corrected)"
test_count = 27
vals = c(780, 195, 24, 1)
 
batt = "Dieharder (original)"
test_count = 110
vals = c(460, 331, 147, 44, 11, 5, 1, 1)
#  
# batt = "NIST STS (corrected)"
# test_count = 15
# vals = c(806, 174, 17, 3)
#   
# batt = "NIST STS (original)"
# test_count = 188
# vals = c(143, 267, 260, 178, 92, 40, 17, 3)
#   
# batt = "TU01 Small Crush (corrected)"
# test_count = 10
# vals = c(904, 88, 8)
#  
# batt = "TU01 Small Crush (original)"
# test_count = 15
# vals = c(861, 127, 11, 1)
# 
# batt = "TU01 Crush (corrected)"
# test_count = 32
# vals = c(694, 246, 56, 4)
# 
# batt = "TU01 Crush (original)"
# test_count = 186
# vals = c(177, 264, 243, 151, 94, 37, 23, 6, 5)
# 
# batt = "TU01 Rabbit (corrected)"
# test_count = 16
# vals = c(747, 222, 31)
# 
# batt = "TU01 Rabbit (original)"
# test_count = 58
# vals = c(530, 327, 101, 29, 8, 4, 1)
# 
# batt = "TU01 Alphabit (corrected)"
# test_count = 4
# vals = c(929, 69, 2)
#  
# batt = "TU01 Alphabit (original)"
# test_count = 33
# vals = c(733, 191, 46, 20, 4, 4, 1, 0, 1)
# 
# batt = "TU01 Block Alphabit (corrected)"
# test_count = 4
# vals = c(872, 122, 5, 1)
#  
# batt = "TU01 Block Alphabit (original)"
# test_count = 198
# vals = c(182, 246, 199, 145, 101, 46, 23, 16, 18, 8, 5, 7, 1, 2, 1)

chisquare_p_val = calc_chisquare(vals, test_count)

vals = append_expected(vals, test_count)
cols = length(vals)/2
vals = matrix(vals, ncol=cols, byrow=TRUE, dimnames=list(c("Observed", "Expected"), 
                                                         seq(0, cols - 1)))
mp = barplot(vals, 
             #main=paste0(batt, ", ", test_count, " tests\nChi-Square statistic p-value = ", format(chisquare_p_val, digits = 3)), 
             main = bquote(atop(paste(.(batt), ", ", .(test_count), " tests"), 
                                paste(chi^2, " statistic p-value = ", .(format(chisquare_p_val, digits = 3))))),
             ylab="Occurences", 
             xlab="Failure count",
             #border = NA,
             col=c(rgb(236/256, 226/256, 240/256), 
                   rgb(28/256, 144/256, 153/256)), 
             beside=TRUE, ylim = c(0, max(vals) + 200), 
             legend.text = TRUE, space = rep(c(0.2, 0), cols), args.legend = list(x="topright", bty = "n"))

text(mp, vals + (max(vals) + 200)/30, cex = 1, labels=round(vals, digits = 0))
