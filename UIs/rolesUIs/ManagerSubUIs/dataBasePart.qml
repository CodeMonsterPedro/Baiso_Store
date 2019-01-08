import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"


Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    Rectangle{
        id:rootDataBaseCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;
        Text {
            id: text1
            x: 50
            y: 40
            width: 480
            height: 50
            text: qsTr("Data Base")
            font.pixelSize: 43
            color:"green"
        }

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
            }

//            ListView {
//                id: listView
//                y: 97
//                height: 615
//                anchors.right: parent.right
//                anchors.rightMargin: -174
//                anchors.left: parent.left
//                anchors.leftMargin: 8
//               }

        }
    }

}


/*##^## Designer {
    D{i:5;anchors_width:1216;anchors_x:24}D{i:4;anchors_width:1414;anchors_x:15}
}
 ##^##*/
