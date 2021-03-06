QT += qml quick sql charts printsupport
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    Sources/loginpageu.cpp \
    RepositoryU/repositoryu.cpp \
    Sources/ModelsCpp/informationlistmodel.cpp \
    Sources/ModelsCpp/modelcontroller.cpp \
    Sources/analiticitem.cpp \
    Sources/mymath.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Headers/loginpageu.h \
    RepositoryU/repositoryu.h \
    Headers/Models/informationlistmodel.h \
    Headers/Models/modelcontroller.h \
    Headers/analiticitem.h \
    Headers/mymath.h

SUBDIRS += \
    Baiso.pro \
    Headers \
    Sources \
   RepositoryU \
   UIs/rolesUIs \
   UIs/MyUIs    \
  UIs/roleUIs/ManagerSubUIs \
  UIs/roleUIs/StorageManSubUIs \
  UIs/roleUIs/AdminSubUIs

DISTFILES += \
    README.md \
    UIs/main.qml\
    UIs/MyUIs/MyButton.qml\
    UIs/logInPage.qml \
    UIs/MyUIs/InformationPage.qml \
    UIs/rolesUIs/AdminPage.qml \
    UIs/rolesUIs/StorageManPage.qml \
    UIs/rolesUIs/ManagerPage.qml \
    UIs/MyUIs/MyHub.qml
