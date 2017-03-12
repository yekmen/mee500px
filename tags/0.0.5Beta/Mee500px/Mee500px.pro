# Add more folders to ship with the application, here
folder_01.source = qml/Mee500px
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01
VERSION += 0.0.5
DEFINES += APPLICATION_VERSION=\"\\\"$$VERSION\\\"\"

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xEA3DB90F
symbian:TARGET.CAPABILITY += NetworkServices

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += mobility
CONFIG += qdeclarative-boostable
QT += network

# Add dependency to Symbian components
# CONFIG += qt-components

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    swipecontrol.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

RESOURCES += \
    resource.qrc

HEADERS += \
    swipecontrol.h

contains(MEEGO_EDITION,harmattan) {
    desktopfile.files = Mee500px.desktop
    desktopfile.path = /usr/share/applications
    INSTALLS += desktopfile
}
