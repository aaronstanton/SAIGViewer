using PyCall
@pyimport matplotlib.backends.backend_qt4agg as qt4agg
@pyimport PyQt4 as PyQt4
@pyimport matplotlib.figure as mplf
using Seismic


progname = "SAIGViewer V0.1"
file_name = "binary_data/data_with_noise"

    function ApplicationWindow(w)

        w = PyQt4.QtGui[:QMainWindow]()        # constructors
        w[:setWindowTitle](progname) # w.setWindowTitle() is w[:setWindowTitle] in PyCall
          
        main_widget = PyQt4.QtGui[:QWidget](w)

        l = PyQt4.QtGui[:QGridLayout](main_widget)

        app_icon = PyQt4.QtGui[:QIcon]()
        app_icon[:addFile]("Icons/SAIG16x16.png", PyQt4.QtCore[:QSize](16,16))
        app_icon[:addFile]("Icons/SAIG24x24.png", PyQt4.QtCore[:QSize](24,24))
        app_icon[:addFile]("Icons/SAIG32x32.png", PyQt4.QtCore[:QSize](32,32))
        app_icon[:addFile]("Icons/SAIG48x48.png", PyQt4.QtCore[:QSize](48,48))
        app_icon[:addFile]("Icons/SAIG256x256.png", PyQt4.QtCore[:QSize](256,256))        
        w[:setWindowIcon](app_icon)

        width = 4
        height = 4
        dpi = 100
        fig = mplf.Figure((width,height), dpi)
        szp = PyQt4.QtGui[:QSizePolicy]()
        canvas = qt4agg.FigureCanvasQTAgg(fig)
        canvas[:setSizePolicy](szp[:Expanding],
                               szp[:Expanding])
        canvas[:updateGeometry]()
        ax = fig[:add_subplot](1,1,1)
        ax[:hold](false)
      

        zbtn = PyQt4.QtGui[:QPushButton]("Zoom", w)
        zbtnc = zbtn[:clicked]
        zbtnc[:connect](adopted())


        d, h, status = SeisRead(file_name)        

        SeisPlot(d,["canvas" => ax, "style" => "wiggles"])

        #l[:addWidget](y_sld, 0, 0)
        l[:addWidget](canvas, 0, 1)
        #l[:addWidget](x_sld, 1, 1)
        l[:addWidget](zbtn, 2, 2)
        #l[:addWidget](rbtn, 1, 2)




        main_widget[:setFocus]()
        w[:setCentralWidget](main_widget)


        return w
    end

    function adopted()
        println("help i'm adopted")
    end




qApp = PyQt4.QtGui[:QApplication](ARGS)
window = PyQt4.QtGui[:QMainWindow]()
window[:setWindowTitle]("SAIGViewer")



aw = ApplicationWindow(window)
aw[:setWindowTitle](progname)
aw[:show]()


if !isinteractive()
    wait(Condition())
end

