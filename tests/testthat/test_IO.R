library("testthat")
library("depict")

context("Test IO")

test_that("we can open MOL file", {
  molfile <- system.file("molfiles/ChEBI_5931.mol", package="depict")
  sdffile <- system.file("molfiles/Structure2D_CID_14969.sdf", package="depict")

  mol <- read_mol(molfile)
  sdf <- read_mol(sdffile)

  expect_equal(attr(mol, "jclass"), "org/openscience/cdk/AtomContainer")
  expect_equal(attr(sdf, "jclass"), "org/openscience/cdk/AtomContainer")
})


test_that("we can open parse a SMILES string", {
  
  SMI1 <- parse_smiles("CCCCCC")
  SMI2 <- parse_smiles("C1CCCCCCCCC1")
  
  expect_equal(attr(SMI1, "jclass"), "org/openscience/cdk/silent/AtomContainer")
  expect_equal(attr(SMI2, "jclass"), "org/openscience/cdk/silent/AtomContainer")
})
