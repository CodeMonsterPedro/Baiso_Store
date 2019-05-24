import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"


Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    property var deleteList: []
    property int tableFontSize: 11
    property string pName: ""
    property string sup: ""
    property string com: ""
    property string sys: ""
    property int inBox: 0;
    property real price: 0.0;
    property string bcode: ""
    Rectangle{
        id:rootDataBaseCanvas
        width: Screen.width-76;
        height: Screen.height-28;
        Text {
            id: text1
            x: 18
            y: 0
            width: 480
            height: 50
            text: qsTr("Добавление учетных записей")
            font.pixelSize: 43
            color:"blue"
        }

        Rectangle {
            id: dbTableItem
            color:"lightgray"
            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            /////////////////////////////////////////////////////////////////////

            Rectangle {
                id: rectangle1
                color: "#ffffff"
                radius: 8
                anchors.left: parent.horizontalCenter
                anchors.right: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.rightMargin: -360
                anchors.leftMargin: -360
                anchors.bottomMargin: 40
                anchors.topMargin: 40

                TextField {
                    id: textField
                    x: 62
                    y: 83
                    text: qsTr("")
                    placeholderText: "Имя"
                }

                TextField {
                    id: textField1
                    x: 62
                    y: 159
                    text: qsTr("")
                    placeholderText: "роль"
                }

                TextField {
                    id: textField2
                    x: 62
                    y: 235
                    text: qsTr("")
                    placeholderText: "номер магазина"
                }

                TextField {
                    id: textField3
                    x: 361
                    y: 159
                    text: qsTr("")
                    placeholderText: "Пароль"
                }

                TextField {
                    id: textField4
                    x: 361
                    y: 83
                    text: qsTr("")
                    placeholderText: "Логин"
                }
                MyButton{
                    x: 361
                    y: 240
                    width: 147
                    height: 35
                    button_text: "Добавить"
                    button_border_color: "blue"
                    button_text_color: "blue"
                    button_round: 15
                    button_height: 40
                    onButton_clicked: {
                        var str = "" + textField.text + "|" + textField1.text + "|" + textField3.text + "|" + textField4.text + "|" + textField2.text;
                        simpleModelController.addNewAccountToRep(str);
                    }

                }

                Text {
                    id: element5
                    x: 62
                    y: 67
                    width: 100
                    height: 22
                    text: qsTr("Имя")
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    anchors.bottom: loginfield.top
                    anchors.bottomMargin: 1
                }

                Text {
                    id: element6
                    x: 62
                    y: 142
                    width: 100
                    height: 22
                    text: qsTr("Роль")
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    anchors.bottom: loginfield.top
                    anchors.bottomMargin: 1
                }

                Text {
                    id: element7
                    x: 62
                    y: 219
                    width: 100
                    height: 22
                    text: qsTr("№ магазина")
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    anchors.bottom: loginfield.top
                    anchors.bottomMargin: 1
                }

                Text {
                    id: element9
                    x: 361
                    y: 67
                    width: 135
                    height: 22
                    text: qsTr("Логин")
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    anchors.bottom: loginfield.top
                    anchors.bottomMargin: 1
                }

                Text {
                    id: element10
                    x: 361
                    y: 142
                    width: 135
                    height: 22
                    text: qsTr("Пароль")
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    anchors.bottom: loginfield.top
                    anchors.bottomMargin: 1
                }

                TextField {
                    id: textField5
                    x: 62
                    y: 550
                    text: qsTr("")
                    placeholderText: "номер магазина"
                }

                Text {
                    id: element8
                    x: 62
                    y: 534
                    width: 158
                    height: 22
                    text: qsTr("название базы данных")
                    anchors.bottomMargin: 1
                    anchors.bottom: loginfield.top
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    font.pixelSize: 12
                }

                TextField {
                    id: textField6
                    x: 62
                    y: 628
                    text: qsTr("")
                    placeholderText: "номер магазина"
                }

                Text {
                    id: element11
                    x: 62
                    y: 612
                    width: 100
                    height: 22
                    text: qsTr("IP адрес")
                    anchors.bottomMargin: 1
                    anchors.bottom: loginfield.top
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    font.pixelSize: 12
                }

                TextField {
                    id: textField7
                    x: 308
                    y: 550
                    text: qsTr("")
                    placeholderText: "номер магазина"
                }

                Text {
                    id: element12
                    x: 308
                    y: 534
                    width: 100
                    height: 22
                    text: qsTr("Логин")
                    anchors.bottomMargin: 1
                    anchors.bottom: loginfield.top
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    font.pixelSize: 12
                }

                TextField {
                    id: textField8
                    x: 308
                    y: 628
                    text: qsTr("")
                    placeholderText: "номер магазина"
                }

                Text {
                    id: element13
                    x: 308
                    y: 612
                    width: 100
                    height: 22
                    text: qsTr("Пароль")
                    anchors.bottomMargin: 1
                    anchors.bottom: loginfield.top
                    anchors.leftMargin: 0
                    anchors.left: loginfield.left
                    font.pixelSize: 12
                }

                MyButton {
                    x: 556
                    y: 631
                    width: 147
                    height: 35
                    button_text: "Принять"
                    button_border_color: "#0000ff"
                    button_text_color: "#0000ff"
                    button_round: 15
                    button_height: 40
                }
            }



            /////////////////////////////////////////////////////////////////////
        }
    }

}





























/*##^## Designer {
    D{i:11;anchors_x:15}D{i:12;anchors_x:15}D{i:13;anchors_x:15}D{i:14;anchors_x:15}D{i:15;anchors_x:15}
D{i:17;anchors_x:15}D{i:19;anchors_x:15}D{i:21;anchors_x:15}D{i:23;anchors_x:15}D{i:4;anchors_height:200;anchors_width:200}
}
 ##^##*/
