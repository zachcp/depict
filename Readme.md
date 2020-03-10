---
output: github_document
---





# depict

<!-- badges: start -->
[![Travis build status](https://travis-ci.org/zachcp/depict.svg?branch=master)](https://travis-ci.org/zachcp/depict)
<!-- badges: end -->
  
depict is an R wrapper around the wonderful depiction api written by [John May](https://github.com/johnmay).  The entire [CDK](https://github.com/cdk) team, but especially
John, have been steadily improving the visualization features of CDK. The depiction API is
succinct and powerful and provides access to a vary large amount of the end-user desired functionality with a small number of composable functions. Because of the design of this API
it is now relatively straightforward to design a simple streamlined interface to allow users to quickly and easily generate beautiful graphics.

## Installation

You can install depict from github with:


```r
# install.packages("devtools")
devtools::install_github("CDK-R/depict")
```




## Simple Depiction

A simple wrapper around CDK's excellent depict module.


```r
library(depict)
library(magrittr)
library(grid)

# you must supply java colors 
color <- J("java.awt.Color")

# load in penicillin
pen  <- parse_smiles("CC1(C(N2C(S1)C(C2=O)NC(=O)CC3=CC=CC=C3)C(=O)[O-])C penicillin")
cav  <- parse_smiles("CN1C=NC2=C1C(=O)N(C(=O)N2C)C")

# define the regions to highlight
# either all atoms/bonds
# or a SMARTS-defined subregion
atms <- pen$atoms()
bnds <- pen$bonds()
lactam <- match_smarts(pen, "C1(=O)NCC1")

# use piping to change the behavior as desired
depiction() %>%
  highlight_atoms(atms, color$LIGHT_GRAY) %>%
  highlight_atoms(bnds, color$LIGHT_GRAY) %>%
  highlight_atoms(lactam, color$RED) %>%
  set_size(400, 400) %>%
  set_zoom(3) %>%
  outerglow() %>%
  add_title() %>%
  depict(pen) %>%
  get_image() %>%
  grid::grid.raster()

```

![](man/figures/penicillin_highlight.png)

## A Larger Example



```r
insulinmol <- system.file("molfiles/ChEBI_5931.mol", package="depict")
insulin    <- read_mol(insulinmol)

cysteine <- match_smarts(insulin, "C(=O)C(CS)N")
xlinks   <- match_smarts(insulin, "SS")

dp <- depiction()%>% 
  set_size(700, 400) %>%
  set_zoom(10) %>%
  outerglow() %>%
  highlight_atoms(cysteine, color$YELLOW) %>%
  highlight_atoms(xlinks, color$YELLOW) %>%
  depict(insulin) %>%
  get_image() %>%
  grid::grid.raster()

```

![](man/figures/insulin.png)

## Highlight Steroecenters


```r
mol    <- parse_smiles("C[C@H]([C@@H](C(=O)O)N)O")
stereo <- depict::match_stereo(mol)


depiction() %>%
  highlight_atoms(stereo, color$RED) %>% 
  set_zoom(3) %>%
  depict(mol) %>%
  get_image() %>%
  grid::grid.raster() 
  
```

![](man/figures/highlight_stereo.png)

