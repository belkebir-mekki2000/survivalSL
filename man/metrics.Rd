\name{metrics}
\alias{metrics}

\title{
Metrics to Evaluate the Prognostic Capacities
}

\description{
Compute several metrics to evaluate the prognostic capacities with time-to-event data.
}

\usage{
metrics(metric, times, failures, data,
survivals.matrix, hazards.matrix=NULL,prediction.times,
pro.time=NULL, ROC.precision=seq(.01, .99, by=.01))
}



\arguments{
 \item{metric}{The metric to compute. See details.}
  \item{times}{The name of the variable related to the numeric vector with the follow-up times.}
  \item{failures}{The name of the variable related to the numeric vector with the event indicators (0=right censored, 1=event).}
  \item{data}{A data frame for in which to look for the variables related to the status of the follow-up time (\code{times}) and the event (\code{failures}).}
  \item{survivals.matrix}{A matrix with the predictions of survivals of each subject (lines) for each prognostic times (columns).}
  \item{hazards.matrix}{A matrix with the predictions of hazards of each subject (lines) for each prognostic times (columns).}
  \item{prediction.times}{A vector of numeric values with the times of the \code{predictions} (same length than the number of columns of \code{prediction.matrix}).}
  \item{pro.time}{This optional value of prognostic time represents the maximum delay for which the capacity of the variable is evaluated. The same unit than the one used in the argument times. Not used for the following metrics: "ll", "ibs", and "ibll". Default value is the time at which half of the subjects are still at risk.}
   \item{ROC.precision}{An optional argument with the percentiles (between 0 and 1) of the prognostic variable used for computing each point of the time dependent ROC curve. Only used when \code{metric="auc"}. 0 (min) and 1 (max) are not allowed. By default, the precision is \code{seq(.01,.99,.01)}.}
 }

\details{
The following metrics can be used: "bs" for the Brier score at the prognostic time \code{pro.time}, "p_ci" and "uno_ci" for the concordance index at the prognostic time \code{pro.time} (Pencina and Uno versions), "ll" for the log-likelihood, "ibs" for the integrated Brier score up to the last observed time in the training data, "ibll" for the integrated binomial log-likelihood up to the last observed time in the training data, "ribs" for the restricted integrated Brier score up to the prognostic time \code{pro.time}, "ribll" for the restricted integrated binomial log-likelihood up to the prognostic time \code{pro.time}, "bll" for the binomial log-likelihood, "auc" for the area under the time-dependent ROC curve up to the prognostic time \code{pro.time}.
}

\value{
A numeric value with the metric estimation.
}

\examples{

data("dataDIVAT2")


# The estimation of the model

formula<-Surv(times,failures) ~ age + hla + retransplant + ecd
model <- LIB_COXridge(formula, data=dataDIVAT2, lambda=.1)

# The apparent AUC 
metrics(metric="auc", times="times",
failures="failures", data=dataDIVAT2,
  survivals.matrix=model$predictions,
  hazards.matrix=NULL, prediction.times=model$times)

# The integrated Brier score up to 10 years post-transplanation
metrics(metric="ribs", times="times", failures="failures",
data=dataDIVAT2,
  survivals.matrix=model$predictions,
  hazards.matrix=NULL, prediction.times=model$times, pro.time=10)
}

\keyword{Metrics}

