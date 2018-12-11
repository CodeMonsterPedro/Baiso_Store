import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    id:informatinPage
    width: informatinPageCanvas.width
    height: informatinPageCanvas.height
    Rectangle{
        id:informatinPageCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;
        color:"red"


    }


}
