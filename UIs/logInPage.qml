import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    id:rootLogInPage
    width: 450
    height: 650
    Rectangle{
        id:rootLogInCanvas
        anchors.fill: parent
        color:Qt.red
        /*TextInput{
            width: rootLogInPage.width-20
            height: rootLogInPage.height-20
            x:10;y:10;
        }*/
    }
}
