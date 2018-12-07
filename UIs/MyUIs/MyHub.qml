import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Item {
    id:root
    property int hub_main_width: 480
    property int hub_main_height: 280
    property int hub_main_radius: 15
    property int hub_main_x: 500
    property int hub_label_width: 80
    property int hub_label_height: 30
    property int hub_label_radius: 15
    property color hub_main_color: "white"
    property color hub_label_color: "white"
    property string hub_label_text: "Hover me_"

    Rectangle{
        id:label
        x:(rootCanvas.x+(rootCanvas.width/2))-(label.width/2);y:0-hub_label_height/2
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
                rootCanvasHub.state = "opened";
                console.log("hub state - " + rootCanvasHub.state);
            }
        }
    }

    Rectangle{
        id:rootCanvasHub
        y:0-hub_main_height
        color:hub_main_color
        width:hub_main_width
        height: hub_main_height
        radius: hub_main_radius
        state: "closed"
        border.color: "green"
        MouseArea{
            id:rootCanvasHubArea
            anchors.fill: rootCanvasHub;
            hoverEnabled: true;
            onExited: {
                rootCanvasHub.state = "closed";
                console.log("hub state - " + rootCanvasHub.state);
            }
        }
    }


    states:[
        State {
            name: "opened"
            PropertyChanges {
                target: label
                y:0-hub_label_height
            }
            PropertyChanges {
                target: rootCanvasHub
                y:0
            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: label
                y:0;
            }
            PropertyChanges {
                target: rootCanvasHub
                y:0-hub_main_height
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
                duration: 2200
            }
            PropertyAnimation{
                target: label
                properties: "y"
                duration: 1000
            }
        },
        Transition {
            from: "closed"
            to: "opened"
            PropertyAnimation{
                target:label
                properties: "y"
                duration: 1000
            }
            PropertyAnimation{
                target:rootCanvasHub
                properties: "y"
                duration: 2200
            }

        }
    ]
}
