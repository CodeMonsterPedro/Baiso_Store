import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import backend.login 1.0
import "../MyUIs"

Item{
    id:rootStorageManPage
    anchors.fill: parent

    Rectangle{
        id:localHub_StorageMan
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
            anchors.fill: localHub_StorageMan;
            Image {
                id: dataBasePart
                width: 64;height: 64;
                source: "../MyUIs/dbicon.png"
                MouseArea{
                    id:second
                    anchors.fill: dataBasePart
                    onClicked: storageManPartsPage.source="AdminSubUIs/usersPage.qml";
                }
            }
            Image {
                id: analyzePart
                width: 64;height: 64;
                source: "../MyUIs/brain.png"
                MouseArea{
                    id:third
                    anchors.fill: analyzePart
                    onClicked: storageManPartsPage.source="AdminSubUIs/networkSettings.qml";

                }
            }
        }

        Image {
            id: exit_btn
            x: 8
            y: 271
            width: 64
            height: 64
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            source:"../MyUIs/door.png"
            MouseArea {
                id: exitArea
                anchors.fill: exit_btn
                onClicked:{
                    logout_backend.getDisconnect();
                    rootCanvas.my_role = 0;
                    rootCanvas.my_market = 0;
                    rootCanvas.state = "LogIn";
                }
            }
        }

    }

    Rectangle{
        id:rootStorageManCanvas;
        color:"white"
        anchors.left: localHub_StorageMan.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.leftMargin: 0


        Loader{
            id:storageManPartsPage
            anchors.fill: parent
            visible: true;
            source: "AdminSubUIs/usersPage.qml"
        }
    }
    Backend_logIn{
        id:logout_backend
    }
}



















/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_height:480;anchors_width:80;anchors_x:0;anchors_y:0}
D{i:1;anchors_height:832;anchors_width:1540}
}
 ##^##*/
