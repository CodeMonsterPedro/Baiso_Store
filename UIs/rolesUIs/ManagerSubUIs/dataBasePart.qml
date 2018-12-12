import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"
import backend.transfer 1.0

Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    Rectangle{
        id:rootDataBaseCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;

        Item {
            id: dbTableItem
            x: 43
            y: 116
            width: 1248
            height: 809

            ComboBox {
                id: comboBox1
                x: 15
                y: 18
                model:["All sales","Products"]
                onCurrentIndexChanged: {simpleModelController.showFrom(comboBox1.currentIndex);}

            }

            ListView {
                id: listView
                y: 93
                height: 708
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.right: parent.right
                anchors.rightMargin: 28
                model: simpleModelController.myModel;

                delegate: Text {
                        id: titleLabel
                        text: mText
                        anchors.fill: parent
                        anchors.leftMargin: 10;
                        font.pixelSize: 20
                    }
            }
        }
    }
}

/*##^## Designer {
    D{i:5;anchors_width:1216;anchors_x:24}
}
 ##^##*/
