
## Coding notes

A few notes about setup:

1. Java can be touch on OSX in particular. When in doubt try `sudo R CMD javareconf` and reinstall rJava from source.
2. Currently I am using the `$` operator in just about all of my functions. This makes it about a billion times easier and more succinct to code at the price of performance. If performance becomes an issue we can use low-level calls. If its important to you I'm happy to accept pull requests.
3. The API is still in flux. I am currently happy with the design but there are a few areas where I'd like to kick the tires a bit more - especially in regards to selection.
4. java.awt.colors are a bit tough to warp since there are many arities and classes accepted.. I think I will provide a number of colors.
5. SMARTS selectors. common smarts selections for AminoAcids, Nucleic Acids, Sugars may be worth including as well.
5. 
