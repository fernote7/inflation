#' @title Accumulate (3 months) and annualize
#'
#' @description !! DESCREVER
#'
#' @param x Time series
#' @param anual Should the series be annualized?
#'
#' @author Talitha Speranza \email{talitha.speranza@fgv.br}, Fernando Teixeira \email{fernando.teixeira@fgv.br}, Daiane Marcolino \email{daiane.marcolino@fgv.br}

geom3 <- function(x, anual = F){
    # x: ts
    n <- length(x)
    data <- data.frame(x, y = rep(NA, n), w = rep(NA, n), z = rep(NA, n), row.names = 1:n)
    colnames(data)[1] <- "x"
    data$y <- data$x/100 + 1

    for(i in n:3){
        data[i,"w"] <-  data$y[i]*data$y[i-1]*data$y[i-2]
    }
    data[,"w"] <- data[,"w"]^(1/3)
    if(anual){data[,"w"] <- data[,"w"]^12}
    data$z <- (data$w - 1)*100
    st <- ts(data$z, start = start(x), end = end(x), frequency = 12)
    st
}
