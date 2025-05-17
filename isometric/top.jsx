var selected = app.activeDocument.selection[0]
var matrix   = app.getIdentityMatrix()

selected.height = selected.height / 100 * 86.062 // %

matrix.mValueC = Math.tan(Math.PI / 180 * 30) // °
selected.transform(matrix, true, true, true, true, 1)

selected.rotate(-30) // °
