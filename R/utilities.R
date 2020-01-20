#' checkJavaClass
#'
#' check if an object is of the specified Java Class
#'
#' @param jobj Required. A Java Object
#' @param klass Required. A string defining a Java class
#' @return Boolean
checkJavaClass <- function(jobj, klass ) {
  if (is.null(attr(jobj, 'jclass'))) stop("this is not a Java Object")

  for (k in klass ) {
    if (attr(jobj, "jclass") == k) {
      return(TRUE)
    }
  }
  return(FALSE)
}

