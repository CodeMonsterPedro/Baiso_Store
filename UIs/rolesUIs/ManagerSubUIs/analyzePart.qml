import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import analitic_item 1.0;
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
                onButton_clicked: mainAlgoItem.startAnalize(textField.text,textField1.text);
            }

            Text {
                id: text1
                x: 44
                y: 105
                width: 408
                height: 37
                text: "The calculated coefficient is:"
                font.pixelSize: 22
                color:"blue"
            }

            TextField {
                id: textField
                x: 44
                y: 46
                width: 291
                height: 40
                text: qsTr("")
                placeholderText: "Product ID \\ Name \\ Bar Code "
            }

            TextField {
                id: textField1
                x: 371
                y: 46
                width: 291
                height: 40
                text: qsTr("")
                placeholderText: "Chouse a month"
            }


        }


        Rectangle {
            id: rectangle
            x: 18
            y: 200
            width: 1485
            height: 1
            color: "grey"
        }

        Analitic{
            id:mainAlgoItem;
        }

        Connections{
            target: mainAlgoItem;
            onAlgorithmEnded:{
                console.log("lol it works!!");
            }
        }


    }
}









/*##^## Designer {
    D{i:5;anchors_width:850;anchors_x:10;anchors_y:16}
}
 ##^##*/
