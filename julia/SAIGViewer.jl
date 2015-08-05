using PySide
using PyPlot
using Seismic
println("wat")

progname = "SAIGViewer V0.1"
file_name = "data_with_noise.seisd"


w = Qt.QWidget()        # constructors
w[:setWindowTitle](progname) # w.setWindowTitle() is w[:setWindowTitle] in PyCall
l = Qt.QGridLayout(w)
w[:setLayout](l)


# create an initial image canvas
sc = Qt.QWidget(w, width=100, height=100)
l[:addWidget](sc)



#=
btn = Qt.QPushButton("Click me", w)
lyt[:addWidget](btn)
qconnect(btn, :clicked) do  # qconnect convenience to connect to a signal
    msg = Qt.QMessageBox(btn)
    msg[:setWindowTitle]("A message for you...")
    msg[:setText]("Hello world!")
    msg[:setInformativeText]("Thanks for clicking.")
    msg[:setIcon](Qt.QMessageBox()[:Information])   # how to pick out Qt::QMessageBox::Information 
enumeration
  convert(Function, msg[:exec])()       # Sometimes, one must must convert to a function (or call qexec(msg))
end
=#

raise(w)            # show and raise widget

if !isinteractive()
    wait(Condition())
end