import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import backend.transfer 1.0

Item {
    id:root
    width: rootCanvasHub.width
    height: rootCanvasHub.height
    property int hub_main_width: 280
    property int hub_main_height: 120
    property int hub_main_radius: 15
    property int hub_label_width: 80
    property int hub_label_height: 30
    property int hub_label_radius: 15
    property color hub_main_color: "white"
    property color hub_label_color: "white"
    property string hub_label_text: "Hover me_"
    property int current_page: 0

    Rectangle{
        id:label
        y:-hub_label_height/2
        x:((hub_main_width/2)-(hub_label_width/2))
        color:hub_label_color
        width: hub_label_width
        height: hub_label_height
        radius:hub_label_radius

        Text{
            id:labelText
            y:hub_label_height/2;
            anchors.horizontalCenter:label.horizontalCenter;
            text:qsTr(hub_label_text);
        }

        MouseArea{
            id:labelArea
            anchors.fill: label
            hoverEnabled: true
            onEntered: {
                label.visible=false;
                rootCanvasHub.visible=true;
            }

        }
    }

    Rectangle{
        id:rootCanvasHub
        visible: false
        y:-15
        color:hub_main_color
        width:hub_main_width
        height: hub_main_height
        radius: hub_main_radius
        //state: "closed"
        border.color: "green"
        onVisibleChanged: {
            if(rootCanvasHub.visible==false)label.visible=true;
        }
        MouseArea{
            id:rootCanvasHubArea
            anchors.fill: rootCanvasHub
            hoverEnabled: true
            onExited: {
                label.visible=true;
                rootCanvasHub.visible=false;
            }
        }
        Row{
            id:hubItemsRow
            spacing: 25;
            anchors.centerIn: rootCanvasHub
            Image {
                id: informationPart
                width: 64;height: 64;
                source: "graph.png"
                MouseArea{
                    id:first
                    anchors.fill: informationPart
                    onClicked: current_page=0;
                }
            }


            Image {
                id: dataBasePart
                width: 64;height: 64;
                source: "dbicon.png"
                MouseArea{
                    id:second
                    anchors.fill: dataBasePart
                    onClicked: current_page=1;
                }
            }


            Image {
                id: analyzePart
                width: 64;height: 64;
                source: "brain.png"
                MouseArea{
                    id:third
                     anchors.fill: analyzePart
                     onClicked: current_page=2;
                }
            }
        }


    }

    Backend_transfer{
         id:hub_transfer
    }


/*

    states:[
        State {
            name: "opened"
            PropertyChanges {
                target: label
                visible:false;
            }
            PropertyChanges {
                target: labelArea
                visible:false;
            }
            PropertyChanges {
                target: labelText
                visible:false;
            }
            PropertyChanges {
                target: rootCanvasHub
                visible:true;
            }
            PropertyChanges {
                target: rootCanvasHubArea
                visible:true;
            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: label
                visible:true;
            }
            PropertyChanges {
                target: labelArea
                visible:true;
            }
            PropertyChanges {
                target: labelText
                visible:true;
            }
            PropertyChanges {
                target: rootCanvasHub
                visible:false;
            }
            PropertyChanges {
                target: rootCanvasHubArea
                visible:false;
            }
        }
    ]

    transitions: [
        Transition {
            from: "opened"
            to: "closed"
            PropertyAnimation{
                target: rootCanvasHub
                properties: "y"
                duration: 200
            }
            PropertyAnimation{
                target: label
                properties: "y"
                duration: 100
            }
        },
        Transition {
            from: "closed"
            to: "opened"
            PropertyAnimation{
                target:label
                properties: "y"
                duration: 100
            }
            PropertyAnimation{
                target:rootCanvasHub
                properties: "y"
                duration: 200
            }

        }
    ]*/
}
