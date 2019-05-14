import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import backend.login 1.0
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
            id: column
            width: 80
            anchors.topMargin: 40
            spacing: 15;
            anchors.fill: localHub;
            Image {
                id: informationPart
                width: 64;height: 64;
                visible: false
                source: "graph.png"
                MouseArea{
                    id:first
                    anchors.fill: informationPart
                    onClicked: managerPartsPage.source="../MyUIs/InformationPage.qml";
                }
            }
            MyButton{
                id: dataBasePart
                button_height: 70
                button_width: 70
                button_text: ""
                button_border_color: "blue"
                button_image_height: 64;
                button_image_width: 64;
                button_round: 15;
                visible: true
                width: 70
                height: 70
                anchors.horizontalCenter: parent.horizontalCenter
                button_image_source: "dbicon.png"
                onButton_clicked: managerPartsPage.source="ManagerSubUIs/dataBasePart.qml";
            }
            MyButton{
                id: analyzePart
                button_height: 70
                button_width: 70
                button_text: ""
                button_border_color: "blue"
                button_image_height: 64;
                button_image_width: 64;
                button_round: 15;
                visible: true
                width: 70
                height: 70
                anchors.horizontalCenter: parent.horizontalCenter
                button_image_source: "brain.png"
                onButton_clicked: managerPartsPage.source="ManagerSubUIs/analyzePart.qml";
            }
        }
        MyButton{
            id: exit_btn
            x: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            button_height: 70
            button_width: 70
            button_text: ""
            button_border_color: "blue"
            button_image_height: 64;
            button_image_width: 64;
            button_round: 15;
            visible: true
            width: 70
            height: 70
            anchors.horizontalCenter: parent.horizontalCenter
            button_image_source: "door.png"
            onButton_clicked:{
                logout_backend.getDisconnect();
                rootCanvas.my_role = 0;
                rootCanvas.my_market = 0;
                rootCanvas.state = "LogIn";
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
            anchors.fill: parent
            visible: true;
            source: "ManagerSubUIs/dataBasePart.qml"
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
