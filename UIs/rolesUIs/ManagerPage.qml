import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../MyUIs"

Item{
    id:rootManagerPage
    anchors.fill: parent

    Rectangle{
        id:localHub
        width: 80
        anchors.left: parent.left
        color:"blue"
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.leftMargin: 0

        Column{
            width: 80
            anchors.topMargin: 40
            spacing: 15;
            anchors.fill: localHub;
            Image {
                id: informationPart
                width: 64;height: 64;
                source: "../MyUIs/graph.png"
                MouseArea{
                    id:first
                    anchors.fill: informationPart
                    onClicked: managerPartsPage.source="../MyUIs/InformationPage.qml";
                }
            }

            Image {
                id: dataBasePart
                width: 64;height: 64;
                source: "../MyUIs/dbicon.png"
                MouseArea{
                    id:second
                    anchors.fill: dataBasePart
                    onClicked: managerPartsPage.source="ManagerSubUIs/dataBasePart.qml";
                }
            }

            Image {
                id: analyzePart
                width: 64;height: 64;
                source: "../MyUIs/brain.png"
                MouseArea{
                    id:third
                    anchors.fill: analyzePart
                    onClicked: managerPartsPage.source="ManagerSubUIs/analyzePart.qml";

                }
            }
        }

    }

    Rectangle{
        id:rootManagerCanvas;
        color:"white"
        anchors.left: localHub.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 0


        Loader{
            id:managerPartsPage
            visible: true;
            width: rootManagerCanvas.width-16;
            height: rootManagerCanvas.height-16;
            y:8;x:8;
            source: "ManagerSubUIs/dataBasePart.qml"
        }
        ScrollBar {
            id: vbar
            hoverEnabled: true
            active: hovered || pressed
            orientation: Qt.Vertical
            size: rootManagerCanvas.height / managerPartsPage.height
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        /*
        MyHub{
            id:hub
            visible: true
            x: ((rootCanvas.width/2)-(hub.hub_main_width/2));
            y:-40
            hub_main_width:360
            hub_main_height: 100
            hub_label_width: 120
            hub_label_height: 52
            onCurrent_pageChanged: {
                console.log(current_page);
                switch(current_page)
                {
                    case 0:managerPartsPage.source="../MyUIs/InformationPage.qml";break;
                    case 1:managerPartsPage.source="ManagerSubUIs/dataBasePart.qml";break;
                    case 2:managerPartsPage.source="ManagerSubUIs/analyzePart.qml";break;


                }
            }
        }
*/

    }


}











/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_height:480;anchors_width:80;anchors_x:0;anchors_y:0}
D{i:1;anchors_height:832;anchors_width:1540}
}
 ##^##*/
