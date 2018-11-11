import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Window {
    id:rootWindow
    visible: true
    width: Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight
    title: qsTr("Baiso")
    Rectangle{
        id:rootCanvas
        anchors.fill: rootWindow
        state:LogIn
        states:[
            State {
                name: "LogIn"
            },
            State {
                name: "BecomeSalaMan"
                PropertyChanges {
                    target: rootWindow
                    color:blue
                }
            },
            State {
                name: "BecomeFinancier"
                PropertyChanges {
                    target: rootWindow
                    color:red
                }
            }


        ]
    }
}
