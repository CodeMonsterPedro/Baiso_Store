import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../MyUIs"
import backend.transfer 1.0
Item{
    id:rootStorageManPage
    width:rootStorageManCanvas.width
    height: rootStorageManCanvas.height

    Rectangle{
        id:rootStorageManCanvas;
        width: Screen.desktopAvailableWidth-60
        height: Screen.desktopAvailableHeight-68
        x:30;y:40
        radius: 15
        color:"white"


        Loader{
            id:storageManPartsPage
            visible: true;
            width: rootStorageManCanvas.width-16;
            height: rootStorageManCanvas.height-16;
            y:8;x:8;
            source: "../MyUIs/InformationPage.qml"
        }
        ScrollBar {
                id: vbar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: rootStorageManCanvas.height / storageManPartsPage.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }

        MyHub{
            id:hub_2
            visible: true
            x: ((rootCanvas.width/2)-(hub_2.hub_main_width/2));
            y:-40
            hub_main_width:360
            hub_main_height: 100
            hub_label_width: 120
            hub_label_height: 52
            onCurrent_pageChanged: {
                console.log(current_page);
                switch(current_page)
                {
                    case 0:storageManPartsPage.source="../MyUIs/InformationPage.qml";break;
                    case 1:storageManPartsPage.source="StorageManSubUIs/markets_and_suplySends.qml";break;
                    case 2:storageManPartsPage.source="StorageManSubUIs/Products_and_supplys.qml";break;
                }
            }
        }


    }

}
