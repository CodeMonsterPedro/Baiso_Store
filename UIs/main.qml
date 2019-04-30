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
    x:0;y:0
    title: qsTr("Baiso");
    onAfterRendering: {
        var time = new Date();
        if(time.getMinutes()<10)currentTime.text=qsTr(""+(time.getHours())+":0"+(time.getMinutes()));
        else currentTime.text=qsTr(""+(time.getHours())+':'+(time.getMinutes()));
    }
        Rectangle{
            id:rootCanvas
            property int my_market: 0;
            property int my_role: 0;
            width: Screen.width
            height: Screen.height-28
            x:0;y:0;
            state:"LogIn"
            onStateChanged: {
                if(rootCanvas.state!="LogIn")currentTimeBackground.visible=true;
                else currentTimeBackground.visible=false;
            }
            onMy_roleChanged: console.log(my_role);

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
                            x:(Screen.width/2)-rootCanvas.width/2;
                            y:(Screen.height/2)-rootCanvas.height/2;
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
                            color:"blue"
                            width: Screen.width
                            height: Screen.height-28
                        }
                        PropertyChanges {
                            target: rootWindow
                            x:0;y:0
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
                            width: Screen.width
                            height: Screen.height-28
                        }
                        PropertyChanges {
                            target: rootWindow
                            x:0;y:0
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
                            width: Screen.width
                            height: Screen.height-28
                        }
                        PropertyChanges {
                            target: rootWindow
                            x:0;y:0
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
                    anchors.left: rootCanvas.left;
                    anchors.bottom: rootCanvas.bottom;
                    width: 80;height: 40;
                    color:"white"
               }
               Text{
                   id:currentTime;
                   visible: true;
                   font.pixelSize: 16
                   text: qsTr("UI_sklad_prot")
                   anchors.centerIn: currentTimeBackground
               }

        }
}

/*##^## Designer {
    D{i:24;anchors_height:26;anchors_width:80}
}
 ##^##*/
