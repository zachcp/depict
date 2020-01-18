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
#' lactam <- match_smarts("C1(=O)NCC1", pen)
match_smarts <- function(smarts, mol, limit=10) {
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

