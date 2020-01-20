## Test environments
* local OS X install, R 3.6.0
* ubuntu 14.04 (on travis-ci), R 3.6.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Zachary Charlop-Powers <zach.charlop.powers@gmail.com>'

* There is an ERROR in the rHUB Windows build. This is due to rJava being unable to load, an upstream issue. However the `devtools::check_win*` all pass.


## Addressing Issues in the first uploads.

* Add quotes to Package Names in Description. (Done)

* Update http/http references (Done)

* Please add small executable examples in your Rd-files. (Done_)


## Additional Changes since the original upload.

* Addition of a vignette.

* Fix an import clash where rJava::new and methods::new were clashing and preventing proper evaluation example code.

* update example code for all functions

* expand the tests

* remove dependency on rCDK to avoid problem in one of the windows builds

* add Readme.html to .Rbuildignore

* put the `save_image` example code in a \dontrun{} block to avoid saving an image in the build directory.

* example code evaluation added fro CRAN causes a build issue.
  Examples with CPU time > 2.5 times elapsed time
                        user system elapsed ratio
  add_terminal_carbons 2.713  0.237   1.058 2.788
  * moved this code to a \dontrun{} block .

* further modify example code to pass builds. (add_title, highlight_aotm, set_zoom)
  