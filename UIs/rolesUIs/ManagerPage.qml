import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../MyUIs"
import backend.transfer 1.0
Item{
    id:rootManagerPage
    width:rootManagerCanvas.width
    height: rootManagerCanvas.height

    Rectangle{
        id:rootManagerCanvas;
        width: Screen.desktopAvailableWidth-60
        height: Screen.desktopAvailableHeight-68
        x:30;y:40
        radius: 15
        color:"white"


        Loader{
            id:managerPartsPage
            visible: true;
            width: rootManagerCanvas.width-16;
            height: rootManagerCanvas.height-16;
            y:8;x:8;
            source: "../MyUIs/InformationPage.qml"
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
                    case 0:managerPartsPage.source="../MyUIs/InformationPage.qml";break;
                    case 1:managerPartsPage.source="ManagerSubUIs/dataBasePart.qml";break;
                    case 2:managerPartsPage.source="ManagerSubUIs/analyzePart.qml";break;


                }
            }
        }


    }

}
