#' match_smarts
#'
#' Use a SMARTS pattern to find a match in a molecule. The
#' output can be used in \code{highlight_atoms} to stylize
#' portions of a chemical \code{depiction}.
#' 
#' @param smarts Required. a smarts string
#' @param mol Required. an r/CDK AtomContainer
#' @param limit Optional. Default \code{10}
#' 
#' @importFrom rJava J
#' @importFrom rJava new
#' 
#' @return a hashset of atoms and bonds
#' @export
#' @examples
#' pen    <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
#' cav    <- parse_smiles("CN1C=NC2=C1C(=O)N(C(=O)N2C)C")
#' lactam <- match_smarts(pen, "C1(=O)NCC1")
match_smarts <- function(mol, smarts, limit=10) {
  hashset       <- J("java/util/HashSet")
  smartspattern <- J("org/openscience/cdk/smiles/smarts/SmartsPattern")
  spattern      <- smartspattern$create(smarts, NULL)

  #spattern$matchAll(mol)$limit(limit)$uniqueAtoms()$toAtomBondMap()
  matches <- spattern$matchAll(mol)
  #matches <- matches$limit(10L)
  atombondmap <- matches$uniqueAtoms()$toAtomBondMap()

  # somewhat convoluted code to get all of the matching atoms
  highlight <- new(hashset)

  for (l in as.list(atombondmap)) {
    newset <- l$entrySet()
    newset <- as.list(newset)
    for (x in newset) {
      highlight$add(x$getValue())
    }
  }
  highlight
}


  

#' match_stereo
#' 
#' return a hashset of Atoms that have the specified stereochemistry
#' 
#' @param mol Required. an r/CDK AtomContainer
#' @param stereo_type Required. a stereo option. One of "None", 
#'   "Bicoordinate", "Tricoordinate", or "Tetracoordinate"
#' 
#' @importFrom rJava J
#' @importFrom rJava new
#' 
#' @return a hashset of atoms and bonds
#' @export
match_stereo <- function(mol, stereo_type="any") {

  stypes <-  c("any", "Bicoordinate", "Tricoordinate", "Tetracoordinate")
  if (!stereo_type %in% stypes) {
    warning("Sterocenter must be one of Bicoordinate, Tricoordinate, Tetracoordinate or any")  
  }

  hashset   <- J("java/util/HashSet")
  highlight <- new(hashset)
  
  stereos   <- J("org/openscience/cdk/stereo/Stereocenters")
  highlight <- new(hashset)
  centers   <- stereos$of(mol)
  
  # java is 0-indexed
  for (i in seq(0, mol$getAtomCount()-1, 1)) {
    idx_int <- as.integer(i)
    center  <- centers$isStereocenter(idx_int)
    
    if (center == TRUE) {
      center_type <- centers$elementType(idx_int)
      
      if (stereo_type == "any") {
        atm <- mol$getAtom(idx_int)
        highlight$add(atm)
        
      } else {
        if (center_type$toString() == stereo_type) {
          atm <- mol$getAtom(idx_int)
          highlight$add(atm)
        }
      }
    }
  }
  
  highlight
}


