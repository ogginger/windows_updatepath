updatepath.bat

Takes two arguments- first, the path you wish to add and secondly a '-d' flag if you want to delete that path.

updatepath will not add or delete the paths if they do or do not exist respectively.

Ex. updatepath "C:\Users\Me\Documents\bin\" will add it to the path if it doesn't already exist.
Ex. updatepath -d "C:\Users\Me\Documents\bin\ will remove it if the path exists.
