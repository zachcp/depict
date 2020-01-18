## Test environments
* local OS X install, R 3.6.0
* ubuntu 14.04 (on travis-ci), R 3.6.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.


## Addressing Issues in a previous upload.


* Thanks, please write package names, software names and API names in
single quotes (e.g. 'Depiction') in your Description. 
  * Done
* Please add a web reference for the 'Depiction' API in your Description
text in the form
<http:...> or <https:...>
with angle brackets for auto-linking and no space after 'http:' and
'https:'.
  * Done
* Please add small executable examples in your Rd-files.
  * Done.  All of the code will run lcoally. The caveat here is that they are wrapped in \dontrun{} blocks due to an issue in during builds where Vignette building and test runnign fails. I believe this is due to the rJava/Java setup during the build step. The code runs as expected in the same environment that is used to build the packge.

## Additional Changes since the previous upload.

* Addition of a vignette.
