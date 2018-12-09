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
    }

    Backend_transfer{
        id:transferManager
        onChangePage:{
            console.log(number);
            switch(number)
            {
                case 0:break;
                case 1:break;
                case 2:break;
            }
        }
    }
}
