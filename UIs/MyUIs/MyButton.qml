﻿import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Item {
    id:root
    property string button_text: "text";
    property string button_image_source: "";
    property color button_color: "white";
    property color button_border_color: "white"
    property color button_text_color: "black"
    property int button_width: 50;
    property int button_height: 20;
    property int button_image_width: button_width;
    property int button_image_height: button_height;
    property int button_round: 0;
    property int button_shadow_round: backbgound.radius;
    property int button_border_width: 1;
    signal button_clicked;
    signal button_hover;
    signal button_unhover;

    Rectangle{
     id:backbgound
     anchors.fill: root;
     color:button_color;
     width:button_width;
     height: button_height;
     border.color: button_border_color;
     border.width: button_border_width;
     radius: button_round;

     Text{
        id:textlabel;
        anchors.centerIn: backbgound;
        text:button_text;
        color:button_text_color;
        font.pixelSize:backbgound.height/2;
        onTextChanged: {
            if(textlabel.text!="text")icon.visible=false;
            else if(icon.source=="")icon.visible=false;
            else {icon.visible=true;textlabel.visible=false;}
        }
        }
     Image {
         id: icon;
         anchors.centerIn: parent;
         width: button_image_width;
         height: button_image_height
         source: button_image_source;
     }
    }
    Rectangle{
        id:shadow;
        anchors.fill: root;
        visible: false;
        color:"black";
        opacity: 0.2;
        radius: button_shadow_round;

    }
    MouseArea{
        anchors.fill: root;
        hoverEnabled: true;
        onClicked: root.button_clicked();
        onEntered:{shadow.visible=true; root.button_hover();}
        onExited:{shadow.visible=false; root.button_unhover();}

    }
}
