import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../MyUIs"



Item{
    id:rootAdminPage
    width: rootAdminCanvas.width
    height: rootAdminCanvas.height

    Rectangle{
        id:rootAdminCanvas;
        width: Screen.desktopAvailableWidth-60
        height: Screen.desktopAvailableHeight-68
        x:30;y:40
        radius: 15
        color:"white"


        Loader{
            id:adminPartsPage
            visible: true;
            width: rootAdminCanvas.width-16;
            height: rootAdminCanvas.height-16;
            y:8;x:8;
            source: "../MyUIs/InformationPage.qml"
        }
        ScrollBar {
                id: vbar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: rootAdminCanvas.height / adminPartsPage.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

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
                    case 0:adminPartsPage.source="../MyUIs/InformationPage.qml";break;
                    case 1:adminPartsPage.source="ManagerSubUIs/dataBasePart.qml";break;
                    case 2:adminPartsPage.source="ManagerSubUIs/analyzePart.qml";break;


                }
            }
        }


    }

}

