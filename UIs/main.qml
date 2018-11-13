import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Window {
    id:rootWindow
    visible: true
    width: rootCanvas.width
    height: rootCanvas.height
    x:rootCanvas.x
    y:rootCanvas.y
    title: qsTr("Baiso")
    Rectangle{
        id:rootCanvas
        width: Screen.desktopAvailableWidth
        height: Screen.desktopAvailableHeight
        state:"LogIn"

        Loader{
            id:logInPart


        }



        states:[
            State {
                name: "LogIn"
                PropertyChanges {
                    target: rootCanvas
                    width:450;height:650;
                    x:(Screen.desktopAvailableWidth/2)-225;
                    y:(Screen.desktopAvailableHeight/2)-325;
                }
            },
            State {
                name: "BecomeSaleMan"
                PropertyChanges {
                    target: rootCanvas
                    color:blue
                }
            },
            State {
                name: "BecomeStorageMan"
                PropertyChanges {
                    target: rootCanvas
                    color:red
                }
            }


        ]
    }
}
