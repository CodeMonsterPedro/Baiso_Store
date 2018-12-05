import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3



Window {
    id:rootWindow
    visible: true
    width: rootCanvas.width
    height: rootCanvas.height
    x:0
    y:0
    title: qsTr("Baiso")
    Rectangle{
        id:rootCanvas
        width: Screen.desktopAvailableWidth
        height: Screen.desktopAvailableHeight
        x:0;y:0;
        state:"LogIn"


        Loader{
            id:logInPart
            anchors.fill: rootCanvas
            x:0;y:0;
            visible: false
            source: "logInPage.qml"

        }
        Connections{
            target: logInPart.item;
            onBecomeAdmin:{
                rootCanvas.state="BecomeAdmin";
            }
            onBecomeSaleMan:{
                rootCanvas.state="BecomeSaleMan";
            }
            onBecomeStorageMan:{
                rootCanvas.state="BecomeStorageMan";
            }
        }

        Loader{
            id:saleManPart;
            anchors.fill: rootCanvas;
            x:0;y:0
            visible: false;
            source: "rolesUIs/Manager.qml"
        }

        states:[
            State {
                name: "LogIn"
                PropertyChanges {
                    target: rootCanvas
                    width:450;height:650;
                }
                PropertyChanges {
                    target: logInPart
                    visible:true;
                }
                PropertyChanges {
                    target: rootWindow
                    x:(Screen.desktopAvailableWidth/2)-rootCanvas.width/2;
                    y:(Screen.desktopAvailableHeight/2)-rootCanvas.height/2;

                }
                PropertyChanges {
                    target: saleManPart
                    visible:false;
                }
            },
            State {
                name: "BecomeSaleMan"
                PropertyChanges {
                    target: rootCanvas
                    color:"blue"
                }
                PropertyChanges {
                    target: saleManPart
                    visible:true;
                }
                PropertyChanges {
                    target: logInPart
                    visible:false;

                }
            },
            State {
                name: "BecomeStorageMan"
                PropertyChanges {
                    target: rootCanvas
                    color:"red"
                }
            },
            State{
                name:"BecomeAdmin"
                PropertyChanges {
                    target: rootCanvas
                    x:0;y:0;
                    width: Screen.desktopAvailableWidth
                    height: Screen.desktopAvailableHeight
                }
                PropertyChanges {
                    target: logInPart
                    visible: false;
                }
            }


        ]
       transitions: [
           Transition {
               from: "LogIn"
               to: ""
               PropertyAnimation{
                    target: rootCanvas
                    properties: "width";duration: 1000
               }
               PropertyAnimation{
                    target: rootCanvas
                    properties: "height";duration: 1000
               }
           }
       ]
    }
}
