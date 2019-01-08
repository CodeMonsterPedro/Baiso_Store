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
        color: "#f9f9f9"
        onVisibleChanged: console.log("info model size" + listView.count);

        ListView {
            id: listView
            visible: true;
            x: 43
            y: 151
            width: 701
            height: 335
            model: simpleModelController.myModel;
            delegate:
                    Rectangle {
                        width: 700
                        height: 40
                        border.color: "black"
                        Text {
                            text: mText
                            font.bold: true
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
            }

        Text {
            id: text1
            x: 43
            y: 58
            width: 461
            height: 66
            text: qsTr("Information")
            font.pixelSize: 43
            color:"green"
        }
    }
}
