__dirname = File($.fileName).parent.fsName
{path, name, artboards, layers} = document = app.activeDocument
project = path.fsName
[basename] = name.match /.*(?=\.)/

options = new PDFSaveOptions
options.acrobatLayers = false
options.preserveEditability = false

if document.documentColorSpace is 'DocumentColorSpace.RGB'
  options.PDFpreset = '[Smallest File Size]'
else options.PDFpreset = '[High Quality Print]'

revert = =>
  document.close SaveOptions.DONOTSAVECHANGES
  app.open File "#{project}/#{name}"

merge = ["#{project}/#{basename}.pdf"]


try
  layers.map (layer) => layer.visible = false
  layers.filter ({printable}) => printable
    .map (layer) =>
      layer.visible = true
      page = new File "#{project}/#{layer.name}.pdf"
      document.saveAs page, options
      merge.push page.fsName
      layer.visible = false

  revert()

  # Merge PDF pages
  $.setenv 'PDF', merge.join()
  File("#{__dirname}/../Merge PDF.app").execute()

catch {message}
  revert()
  alert message
