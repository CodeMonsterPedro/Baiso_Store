import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "MyUIs"

Window {
    id:rootWindow
    visible: true
    width: rootCanvas.width
    height: rootCanvas.height
    x:0
    y:0
    title: qsTr("Baiso");
    onAfterRendering: {
        var time = new Date();
        if(time.getMinutes()<10)currentTime.text=qsTr(""+(time.getHours())+":0"+(time.getMinutes()));
        else currentTime.text=qsTr(""+(time.getHours())+':'+(time.getMinutes()));
    }
    Rectangle{
        id:rootCanvas
        width: Screen.desktopAvailableWidth
        height: Screen.desktopAvailableHeight-28
        x:0;y:0;
        state:"LogIn"
        onStateChanged: {
            console.log( "current rootCanvas state - " + rootCanvas.state);
            if(rootCanvas.state!="LogIn")currentTimeBackground.visible=true;
            else currentTimeBackground.visible=false;
        }

        Loader{
            id:logInPart
            anchors.fill: rootCanvas
            visible: rootCanvas.state=="LogIn"
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
            visible: false;
            source: "rolesUIs/ManagerPage.qml"
        }

        states:[
            State {
                name: "LogIn"
                PropertyChanges {
                    target: rootCanvas
                    width:450;height:650;
                }
                PropertyChanges {
                    target: rootWindow
                    x:(Screen.desktopAvailableWidth/2)-rootCanvas.width/2;
                    y:(Screen.desktopAvailableHeight/2)-rootCanvas.height/2;
                }
                PropertyChanges {
                    target: currentTime
                    x:-7;y:46
                }
                PropertyChanges {
                    target: logInPart
                    visible:true;
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
                    color:"green"
                    width: Screen.desktopAvailableWidth
                    height: Screen.desktopAvailableHeight-28
                }
                PropertyChanges {
                    target: rootWindow
                    x:0;y:0
                }
                PropertyChanges {
                    target: currentTime
                    x:40;y:5
                }

                PropertyChanges {
                    target: saleManPart
                    visible:true;
                    source: "rolesUIs/ManagerPage.qml"
                }


            },
            State {
                name: "BecomeStorageMan"
                PropertyChanges {
                    target: rootCanvas
                    color:"grey"
                    width: Screen.desktopAvailableWidth
                    height: Screen.desktopAvailableHeight-28
                }
                PropertyChanges {
                    target: rootWindow
                    x:0;y:0
                }
                PropertyChanges {
                    target: currentTime
                    x:40;y:5
                }

                PropertyChanges {
                    target: saleManPart
                    visible:true;
                    source:"rolesUIs/StorageManPage.qml"
                }

            },
            State{
                name:"BecomeAdmin"
                PropertyChanges {
                    target: rootCanvas
                    color:"white"
                    width: Screen.desktopAvailableWidth
                    height: Screen.desktopAvailableHeight-28
                }
                PropertyChanges {
                    target: rootWindow
                    x:0;y:0
                }
                PropertyChanges {
                    target: currentTime
                    x:40;y:5
                }
                PropertyChanges {
                    target: saleManPart
                    visible:true;
                    source:"rolesUIs/AdminPage.qml"
                }
            }
        ]
       Rectangle{
            id:currentTimeBackground;
            visible: false;
            x:currentTime.x-10;y:currentTime.y-22;
            width: 100;height: 46
            radius: 15;
            color:"white"
       }
       Text{
           id:currentTime;
           visible: true;
           x:0;y:0
           width: 80
           height: 26
           font.pixelSize: 16
           text: qsTr("UI_sklad_prot")
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
       }

    }
}
