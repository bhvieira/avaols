context("avaols")

# Test that avaols returns an avaols object
test_that("avaols returns an avaols object", {
  X <- data.frame(x1 = 1:10/10, x2 = (11:20)^2/400)
  obj <- avaols(X)
  expect_true(inherits(obj, "avaols"))
})

# Test that avaols fits the model
test_that("avaols fits the model", {
  X <- data.frame(x1 = 1:10/10, x2 = (11:20)^2/400)
  obj <- avaols(X)
  expect_true(!is.null(obj@B))
  expect_true(!is.null(obj@B0))
})

# Test that avaols works with intercept = FALSE
test_that("avaols works with intercept = FALSE", {
  X <- data.frame(x1 = 1:10/10, x2 = (11:20)^2/400)
  obj <- avaols(X, intercept = FALSE)
  expect_true(!is.null(obj@B))
  expect_true(!is.null(obj@B0))
})

# Test that predict returns the correct output
test_that("predict returns the correct output", {
  X <- data.frame(x1 = 1:10/10, x2 = (11:20)^2/400)
  obj <- avaols(X)
  Y <- data.frame(x1 = 21:30/10, x2 = (51:60)^2/400)
  pred <- predict(obj, Y)
  expect_equal(dim(pred), dim(Y))
})

# Test that coef returns the correct output
test_that("coef returns the correct output", {
  X <- data.frame(x1 = 1:10/10, x2 = (11:20)^2/400)
  obj <- avaols(X)
  coefs <- coef(obj)
  expect_equal(dim(coefs), c(ncol(X) + 1, ncol(X)))
})
