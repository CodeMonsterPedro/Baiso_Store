import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"


Item{
    id:analyzePage
    width: analyzePageCanvas.width
    height: analyzePageCanvas.height
    Rectangle{
        id:analyzePageCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;

        Item {
            id: item1
            height: 151
            anchors.top: parent.top
            anchors.topMargin: 43
            anchors.right: parent.right
            anchors.rightMargin: 21
            anchors.left: parent.left
            anchors.leftMargin: 8

            Rectangle{
                color:"green"
                x: 44
                y: 44
                width: 610
                height: 42

                TextField {
                    id: textField
                     x:1;y:1;
                     width: 214
                     height: 42
                     text: qsTr("")
                     placeholderText: "Start date"
                }

            }


            MyButton{
                x: 700
                y: 44
                width: 143
                height: 42
                button_width: 90;
                button_height: 70;
                button_text: "Get value";
                button_border_color: "green"
                button_round: 15;
            }

            Rectangle {
                x: 247
                y: 44
                width: 256
                height: 20
                color: "#008000"
                TextField {
                    id: textField1
                    x:1;y:1;
                    width: 154
                    height: 18
                    text: qsTr("")
                    placeholderText: "End date"
                }
            }

            Rectangle {
                x: 450
                y: 44
                width: 20
                height: 20
                color: "#008000"
                TextField {
                    id: textField2
                    x:1;y:1;
                    width: 154
                    height: 18
                    text: qsTr("")
                    placeholderText: "Product Id"
                }
            }

            Text {
                id: text1
                x: 44
                y: 105
                width: 408
                height: 37
                text: "The calculated coefficient is:"
                font.pixelSize: 22
                color:"green"
            }


        }


        Rectangle {
            id: rectangle
            x: 18
            y: 200
            width: 1485
            height: 1
            color: "green"
        }



    }
}

/*##^## Designer {
    D{i:5;anchors_width:850;anchors_x:10;anchors_y:16}
}
 ##^##*/
