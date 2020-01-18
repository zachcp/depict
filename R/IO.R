#' parse_smiles
#'
#' simple smiles parser
#'
#' @param smi Required. A smiles string
#' @param generatecoords Optional. Default \code{TRUE}. Whether
#'  to generate coordinates from the smiles
#' @param kekulise Optional. Boolean. Default \code{TRUE}
#' 
#' @importFrom rJava new
#' @importFrom rJava J
#' @export
#' @examples 
#' parse_smiles("CCCC")
#' parse_smiles("C1CCCCC1")
parse_smiles <- function(smi, generatecoords=TRUE, kekulise=TRUE) {

  SmilesParser <- J("org.openscience.cdk.smiles.SmilesParser")
  SChemObjectBuilder <- J("org.openscience.cdk.silent.SilentChemObjectBuilder")
  StructureDiagramGenerator <- J("org.openscience.cdk.layout.StructureDiagramGenerator")

  sinst <- SChemObjectBuilder$getInstance()
  sp    <- rJava::new(SmilesParser, sinst)
  sp$kekulise(kekulise)
  
  mol   <- sp$parseSmiles(smi)

  if (generatecoords) {
    sdg   <- new(StructureDiagramGenerator)
    sdg$setMolecule(mol)
    sdg$generateCoordinates()
    mol <- sdg$getMolecule()
  }

  mol

}

#' read_mol
#'
#' Read a Molfile and return an AtomContainer that can be passed to \code{depict}.
#'
#' @param molfile Required. A filepath to a MOLfile.
#' @return an AtomContainer
#' @importFrom rJava .jnew
#' @export
#' 
#' @examples
#' insulinmol <- system.file("molfiles/ChEBI_5931.mol", package="depict")
#' insulin    <- read_mol(insulinmol)
read_mol <- function(molfile) {

  jAtomContainer <- J("org.openscience.cdk.AtomContainer")

  jfileobj   <- .jnew("java.io.File", molfile)
  jreaderobj <- .jnew("java.io.FileReader", jfileobj)
  jmolreader <- .jnew("org.openscience.cdk.io.MDLV2000Reader")
  AC         <- .jnew("org.openscience.cdk.AtomContainer")

  jmolreader$setReader(jreaderobj)
  jmolreader$read(AC)

}

