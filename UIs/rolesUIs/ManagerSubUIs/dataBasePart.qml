import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"
import backend.transfer 1.0

Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    Rectangle{
        id:rootDataBaseCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;
        color:"green"
    }
}
