#
# Fittiing Hill equation
#
# Itoshi NIKAIDO <dritoshi@gmail.com>
#

# make demo data
L  <- c(1:100)
n  <- 2
Kd <- 10
y  <- L^n / (Kd + L^n) + rnorm(100, 0, 0.01)

# conf
output <- "results/hill.pdf"

# initial
n.init  <- 1
Kd.init <- 1

# fitting Hill equation
y.nls <- nls(y ~ L^n / (Kd + L^n), start = c(n = n.init, Kd = Kd.init))

# extract fitting data
y.nls.summary <- summary(y.nls)
y.nls.n       <- y.nls.summary$param[1]
y.nls.Kd      <- y.nls.summary$param[2]
y.nls.predict <- predict(y.nls)
results <- cbind(y, y.nls.predict)

# legend prep.
legend.x <- median(L) - sd(L)
legend.y <- median(y.nls.predict) - 4 * sd(y.nls.predict)
legnend.str.data <- paste(
  "Data (n = ",
  n,
  ", Kd = ",
  Kd,
  ")",
  sep =""
)
legnend.str.predict <- paste(
  "Prediction (n = ",
  round(y.nls.n, 2),
  ", Kd = ",
  round(y.nls.Kd, 2),
  ")",
  sep =""
)

# output graph
pdf(output)
matplot(results, type="l")
legend(
  legend.x, legend.y,
  c(legnend.str.data, legnend.str.predict),
  col = c(1,2),
  lwd = 1
)
dev.off()
