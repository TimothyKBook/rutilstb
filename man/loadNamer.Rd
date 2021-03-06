% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadNamer.R
\name{loadNamer}
\alias{loadNamer}
\title{loadNamer}
\usage{
loadNamer(file_path, name, expected_name = NULL)
}
\arguments{
\item{file_path}{The .RData file to load in.}

\item{name}{The name you'd like the .RData object to be loaded in as.}

\item{expected_name}{If you already have an object in the environment with the same name
as the object about to be loaded in, put that character string here.  It will be preserved
while loading in the new object.}
}
\value{

}
\description{
Load objects in an .RData and automatically give it a given name.
}

