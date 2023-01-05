simLR <- function(n) {
	x <- matrix(rnorm(1e6 * n), 1e6, n)
	b <- rnorm(n)
	y <- drop(x %*% b) + rnorm(n)
	b <- solve(crossprod(x), crossprod(x, y))
}

cat("-------------------------------------------\n")
cat("La_library : ", La_library(),"\n")
cat("extSoftVersion()[\"BLAS\"]: ", extSoftVersion()["BLAS"], "\n")

start_time <- Sys.time()
simLR(100)
print(Sys.time() - start_time)
cat("-------------------------------------------\n")