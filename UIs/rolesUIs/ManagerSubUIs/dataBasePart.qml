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
            color:"blue"
        }

        Item {
            id: dbTableItem
            x: 43
            y: 116
            width: 1473
            height: 809

            ComboBox {
                id: comboBox1
                x: 15
                y: 18
                model:simpleModelController.m_list;
                onCurrentIndexChanged: simpleModelController.showFrom(comboBox1.currentIndex);
                onCurrentTextChanged: {
                    if(comboBox1.currentText=="ProductList")listView.delegate = "Rectangle{
                            width: 400;
                            height: 40;
                            border.color: \"blue\"
                            Text{
                                anchors.left: parent.left;
                                anchors.verticalCenter: parent
                                text: \"(\" + m_MainId + \") \" + m_Name;
                            }
                        }";
                    if(comboBox1.currentText=="ProductSaleFull")listView.delegate = "Rectangle{
                            width: 400;
                            height: 40;
                            border.color: \"blue\"
                            Text{
                                anchors.left: parent.left;
                                anchors.verticalCenter: parent
                                text: \"(\" + m_MainId + \") \" + m_Name;
                            }
                        }";
                }
            }

            RadioButton {
                id: radioButton
                x: 189
                y: 18
                text: qsTr("Radio Button")
            }

            RadioButton {
                id: radioButton1
                x: 331
                y: 18
                text: qsTr("Radio Button")
            }

            Rectangle {
                id: rectangle
                y: 88
                width: 729
                height: 713
                color: "#ffffff"
                border.color: "blue"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                anchors.left: parent.left
                anchors.leftMargin: 0

                ListView {
                    id: listView
                    x: 8
                    y: 8
                    height: 704
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    clip: true;
                    model:simpleModelController.myModel;
                    delegate: Rectangle{
                        anchors.left: parent;
                        anchors.right: parent;
                        anchors.leftMargin: 15;
                        anchors.rightMargin: 15;
                        height: 100;
                        border.color: "blue"
                        Text{
                            x:15;
                            text: "Current item id: " +  m_MainId
                            anchors.left: parent.left;
                        }

                        Text {
                            x: 15
                            y: 24
                            height: 17
                            text: "Product: " +  m_Name
                            anchors.left: parent.left
                        }

                        Text {
                            x: 15
                            y: 48
                            text: "Current product bar code: " + m_BarCode;
                            anchors.left: parent.left
                        }

                        Text {
                            x: 15
                            y: 74
                            text: "Price: " + m_Price;
                            anchors.left: parent.left
                        }

                        Text {
                            x: 240
                            y: 0
                            text: m_InBoxCount +"\\" + m_CountSys + " in one box";
                        }

                    }
                }
            }

            Rectangle {
                id: rectangle1
                y: 88
                height: 713
                color: "#ffffff"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 8
                border.color: "blue";
                anchors.left: rectangle.right
                anchors.leftMargin: 1
                anchors.right: parent.right
                anchors.rightMargin: 28

                Rectangle{
                    height: 434
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                    TextField {
                        id: textField2
                        x: 69
                        y: 70
                        width: 251
                        height: 40
                        text: qsTr("")
                        placeholderText: "Product Name"
                    }

                    TextField {
                        id: textField3
                        x: 69
                        y: 153
                        width: 251
                        height: 40
                        text: qsTr("")
                        placeholderText: "Supplayer name"
                    }

                    TextField {
                        id: textField4
                        x: 69
                        y: 229
                        width: 251
                        height: 40
                        text: qsTr("")
                        placeholderText: "Company name"
                    }

                    TextField {
                        id: textField5
                        x: 69
                        y: 306
                        width: 251
                        height: 40
                        text: qsTr("")
                        placeholderText: "Bar code"
                    }

                    TextField {
                        id: textField6
                        x: 413
                        y: 70
                        text: qsTr("")
                        placeholderText: "Count of items in one box"
                    }

                    TextField {
                        id: textField7
                        x: 413
                        y: 153
                        text: qsTr("")
                        placeholderText: "Price"
                    }

                    TextField {
                        id: textField8
                        x: 413
                        y: 229
                        text: qsTr("")
                        placeholderText: "Type of one item"
                    }

                    Text {
                        id: element
                        x: 8
                        y: 8
                        width: 241
                        height: 32
                        text: qsTr("Add new record")
                        font.pixelSize: 18
                    }
                    MyButton{
                        id:submiAddButton
                        x: 443
                        y: 306
                        width: 148
                        height: 40
                        button_round: 15;
                        button_border_color: "blue";
                        button_text_color: "blue"
                        onButton_clicked:{
                            simpleModelController.addNewElementToRep("" +
                                                                     textField2.text + "|" +
                                                                     textField3.text + "|" +
                                                                     textField4.text + "|" +
                                                                     textField5.text + "|" +
                                                                     textField6.text + "|" +
                                                                     textField7.text + "|" +
                                                                     textField8.text
                                                                     );
                        }
                    }

                }
                Rectangle{
                    y: 430
                    height: 240
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0

                }
            }

        }
    }

}
























/*##^## Designer {
    D{i:4;anchors_width:1414;anchors_x:15}D{i:5;anchors_width:1216;anchors_x:24}D{i:15;anchors_width:729;anchors_x:0}
D{i:17;anchors_width:715}D{i:18;anchors_width:715;anchors_x:0}D{i:16;anchors_width:200;anchors_x:730}
}
 ##^##*/
