#' depiction
#'
#' create the CDK depiction generator object. this holds the vizual
#' parameters that can them be applied to an object using
#' the \code{depict} command.
#'
#' @import rcdklibs
#' @export
#' @examples
#' 
#' pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' 
#' depiction() %>%
#'   set_size(600,600) %>%
#'   set_zoom(3) %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#'
depiction <- function() {
  .jnew("org/openscience/cdk/depict/DepictionGenerator")
}
#' color atoms
#'
#' @param dg Required. A DepictionGenerator
#' @importFrom  rJava .jcall
#' @export
#' @examples 
#' 
#' pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' 
#' depiction() %>%
#'   set_size(600,600) %>%
#'   set_zoom(3) %>%
#'   color_atoms() %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#'   
#' 
color_atoms <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("color_atoms requires a Depiction Generator")
  }
  .jcall(dg, "Lorg/openscience/cdk/depict/DepictionGenerator;", "withAtomColors")
}
#' outerglow
#' 
#' apply outerglow to a depiction generator created by \code{depict}
#'
#' @param dg Required. a Depiction Generator
#' @importFrom  rJava .jcall
#' @export
#' @examples 
#' 
#' pen    <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' lactam <- match_smarts("C1(=O)NCC1", pen)
#' atms   <- pen$atoms()
#' bnds   <- pen$bonds()
#' color  <- J("java.awt.Color") 
#' 
#' dep <- depiction() %>%
#'   set_size(600,600) %>%
#'   set_zoom(3) %>%
#'   highlight_atoms(atms, color$LIGHT_GRAY) %>%
#'   highlight_atoms(bnds, color$LIGHT_GRAY) %>%
#'   highlight_atoms(lactam, color$RED)
#'
#' dep %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#' 
#' dep %>%
#'   outerglow() %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#'   
outerglow <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("outerglow requires a Depiction Generator")
  }
  .jcall(dg, "Lorg/openscience/cdk/depict/DepictionGenerator;", "withOuterGlowHighlight")
}
#' set_size
#'
#' set canvas size for depictiongenerator
#' 
#' 
#' @param dg Required. a Depiction Generator
#' @param width Required. width
#' @param height Required. height
#' @export
#' @examples 
#' 
#' pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' 
#' depiction() %>%
#'   set_size(600, 600) %>%
#'   set_zoom(3) %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#' 
set_size <- function(dg, width, height) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("set_size requires a Depiction Generator")
  }
  
  dg$withSize(width,height)
}
#' add_title
#'
#' add a title to the depiction. Uses names from the input files.
#' 
#' @param dg Required. a Depiction Generator
#' @export
#' @examples 
#' pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' 
#' depiction() %>%
#'   set_size(600, 600) %>%
#'   set_zoom(3) %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#'   
add_title <- function(dg) {
  
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_title requires a Depiction Generator")
  }
  
  dg$withMolTitle()
}
#' add terminal carbons
#'
#' @param dg Required. a Depiction Generator
#' @importFrom  rJava .jcall
#' @export
#' @examples 
#' 
#' pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' 
#' depiction() %>%
#'   set_size(600, 600) %>%
#'   set_zoom(3) %>%
#'   add_terminal_carbons() %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#'   
add_terminal_carbons <- function(dg) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("add_terminal_carbons requires a Depiction Generator")
  }
  .jcall(dg, "Lorg/openscience/cdk/depict/DepictionGenerator;", "withTerminalCarbons")
}

#' depict
#'
#' convert a \code{depiction} into an image.
#'
#' @param dg Required. A Depiction Generator
#' @param mol Required. An AtomContainer
#' @export
#' @examples
#' 
#' pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' dep  <- depiction() 
#' depict(dep, pen)
#' 
depict <- function(dg, mol) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("depict requires a Depiction Generator")
  }
  
  if (!checkJavaClass(mol, c("org/openscience/cdk/AtomContainer",
                             "org/openscience/cdk/silent/AtomContainer"))) {
    stop("depict requires an AtomContainer")
  }
  #.jcall(dg, "Lorg/openscience/cdk/depict/Depiction;", "depict", mol)
  dg$depict(mol)
}
#' highlight_atoms
#'
#' Highlight atoms in a depiction.
#'
#' @param dg Required. A Depiction Generator as generated by \code{depict}
#' @param atoms Required. A list of CDK IOBJects, usually atoms or bonds
#' @param color Required. A java.awt.Color
#' @export
#' @examples 
#' 
#' pen    <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' lactam <- match_smarts("C1(=O)NCC1", pen)
#' color  <- J("java.awt.Color")
#' 
#' depiction() %>%
#'   highlight_atoms(lactam, color$LIGHT_GRAY) %>%
#'   depict(pen) %>%
#'   get_image() %>%
#'   grid::grid.raster()
#'   
highlight_atoms <- function(dg, atoms, color) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  dg$withHighlight(atoms, color)
}
#' save_image
#'
#' save the output of the \code{depict} function.
#'
#' @param molgrid Required. A MolGridDepiction. Usually obtained from
#' the \code{depict} function.
#' @param outfile Required. Filepath to the output
#' @export
#' @examples 
#' pen    <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' lactam <- match_smarts("C1(=O)NCC1", pen)
#' color  <- J("java.awt.Color")
#' 
#' depiction() %>%
#'   highlight_atoms(lactam, color$LIGHT_GRAY) %>%
#'   depict(pen) %>%
#'   save_image("penicillin.png")
#'   
save_image <- function(molgrid, outfile) {
  if (!checkJavaClass(molgrid, "org/openscience/cdk/depict/MolGridDepiction")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  molgrid$writeTo(outfile)
}

#' get_image
#'
#' get an image generated in Java as an R-accessible image.
#' 
#'
#' @param molgrid Required. A MolGridDepiction. Usually obtained from
#' the \code{depict} function.
#' @importFrom png readPNG
#' @export
#' @examples 
#' 
#' pen      <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' depicted <- depiction() %>% depict(pen)
#' image    <- get_image(depicted)
#' grid::grid.raster(image)
#'   
get_image <- function(molgrid) {
  if (!checkJavaClass(molgrid, "org/openscience/cdk/depict/MolGridDepiction")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  
  # CDK apends a ".png" to the name
  output  <- paste(tempfile(),"png")
  output1 <- paste0(output,".png")
  
  molgrid$writeTo("png", output)
  img <- readPNG(output1)
  
  unlink(output)
  unlink(output1)
  
  img
}
#' set_zoom
#'
#' set_zoom applies a zoom to the \code{depiction}
#'
#' @param dg a Depiction Generator
#' @param zoom Optional. Default \code{1}
#' @export
#' @examples 
#' pen    <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' depiction() %>%
#'   set_zoom(3) %>%
#'   depict(pen) %>%
#'   get_image()
#'   
set_zoom <- function(dg, zoom=1) {
  if (!checkJavaClass(dg, "org/openscience/cdk/depict/DepictionGenerator")) {
    stop("highlight_atoms requires a Depiction Generator")
  }
  dg$withZoom(zoom)
}
