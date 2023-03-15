## All-vs-All Ordinary Least Squares (AVAOLS) Regression
## Author: Bruno Hebling Vieira

# new S4 class for simultaneous regression
setClass("avaols", representation(
    X = "data.frame",
    B = "matrix",
    B0 = "matrix"
))

# method for printing simultaneous regression
setMethod("show", signature(object = "avaols"), function(object) {
    "Method for printing simultaneous regression"
    print(object@B)
    print(object@B0)
})

# generic function for fitting simultaneous regression
setGeneric("fit", function(object, intercept = TRUE) standardGeneric("fit"))

# method for fitting simultaneous regression
setMethod("fit", signature(object = "avaols"), function(object, intercept = TRUE) {
    "Method for fitting simultaneous regression"
    X <- object@X
    k <- ncol(X)
    mu <- colMeans(X)
    X <- t(t(X) - mu)
    Sigma <- t(X) %*% X
    # Omega = solve(Sigma)
    # use QR decomposition to solve the linear system
    Omega <- solve(qr(Sigma))
    B <- diag(1, k, k) - Omega %*% diag(1 / diag(Omega))
    if (intercept) {
        B0 <- mu %*% (diag(1, k, k) - B)
    } else {
        B0 <- matrix(0, 1, k)
    }
    object@B <- B
    object@B0 <- B0
    return(object)
})

# method for predicting simultaneous regression
#' @export
setMethod("predict", signature(object = "avaols"), function(object, newdata, ...) {
    "Method for predicting simultaneous regression"
    # if newdata is null, use the original data
    if (is.null(newdata)) {
        newdata <- object@X
    }
    # if newdata is a data frame, convert it to a matrix
    if (is.data.frame(newdata)) {
        newdata <- as.matrix(newdata)
    }
    B <- object@B
    B0 <- object@B0
    return(t(t(newdata %*% B) + c(B0)))
})

#' @export
setMethod("coef", signature(object = "avaols"), function(object) {
    "Method for returning the coefficients of simultaneous regression"
    B <- object@B
    B0 <- object@B0
    coefs <- rbind(B0, B)
    rownames(coefs) <- c("Intercept", colnames(object@X))
    colnames(coefs) <- colnames(object@X)
    return(coefs)
})

#' All-vs-All Ordinary Least Squares (AVAOLS) Regression
#'
#' This function performs an All-vs-All Ordinary Least Squares (AVAOLS) Regression
#' using the input matrix X.
#' The model is fitted in one step using the QR decomposition, instead of naively fitting model for each columns separately.
#'
#' @param X a matrix or data frame of predictors
#' @param intercept a logical value indicating whether or not to include an intercept in the model. Default is TRUE.
#'
#' @return an object of class "avaols" containing the following components:
#' \item{X}{a copy of the input data frame}
#' \item{B}{a matrix of coefficients}
#' \item{B0}{a matrix of intercepts}
#'
#' @examples
#' X <- data.frame(matrix(rnorm(100), ncol = 5))
#' avaols(X)
#' @export
avaols <- function(X, intercept = TRUE) {
    "All-vs-All Ordinary Least Squares (AVAOLS) Regression"
    obj <- new("avaols", X = X)
    # fit the model
    obj <- fit(obj, intercept = intercept)
    return(obj)
}