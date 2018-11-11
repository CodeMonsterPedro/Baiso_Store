import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Item {
    id:root
    property string button_text: "text";
    property string button_image_source: "";
    property color button_color: "white";
    property int button_width: 50;
    property int button_height: 20;
    signal button_clicked;
    signal button_hover;
    signal button_unhover;

    Rectangle{
     id:backbgound
     anchors.fill: root;
     color:button_color;
     width:button_width;
     height: button_height;

     Text{
        id:textlabel;
        anchors.centerIn: backbgound;
        text:button_text;
        font.pixelSize:backbgound.height/2;
        onTextChanged: {
            if(textlabel.text!="text")icon.visible=fasle;
            else if(icon.source=="")icon.visible=false;
            else {icon.visible=true;textlabel.visible=false;}
        }
        }
     Image {
         id: icon;
         source: button_image_source;
         width: 128;
         height: 128;
         onSourceChanged: {if(button_image_source!=""){button_width=icon.width;button_height=icon.height}}
     }
    }
    Rectangle{
        id:shadow;
        anchors.fill: root;
        visible: false;
        color:"black";
        opacity: 0.2;

    }


    MouseArea{
        anchors.fill: root;
        hoverEnabled: true;
        onClicked: root.button_clicked();
        onEntered:{shadow.visible=true; root.button_hover();}
        onExited:{shadow.visible=false; root.button_unhover();}

    }

}
