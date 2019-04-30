import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"

Item{
    id:bigsalePage
    property string pName: ""
    property string pBarCode: ""
    property int pCount: 0
    width: rootbigsaleCanvas.width
    height: rootbigsaleCanvas.height;
    Component.onCompleted: {
        simpleModelController.showFrom(2);
    }

    Rectangle {
        id: rootbigsaleCanvas
        width: Screen.width-76
        height: Screen.height-28

        Text {
            id: text1
            x: 18
            y: 0
            width: 636
            height: 50
            color: "#0000ff"
            text: qsTr("Расчетные квитанции")
            font.pixelSize: 43
        }

        Rectangle {
            id: bigsaleListItem
            color: "#d3d3d3"
            anchors.topMargin: 60
            anchors.fill: parent

            Rectangle {
                id: bigsaleListBackground
                color: "#ffffff"
                anchors.rightMargin: -400
                anchors.left: parent.horizontalCenter
                anchors.right: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.leftMargin: -400
                anchors.bottomMargin: 30
                anchors.topMargin: 30
                anchors.top: parent.top
                border.color: "gray"
                border.width: 2

                ListView {
                    property int counter: 0;
                    id: bigsaleList
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.fill: parent
                    spacing: 25
                    cacheBuffer: 500000;
                    clip: true;
                    model: counter, simpleModelController.myModel;
                    delegate:bigsaleDelegate;
                    Connections {
                        target: simpleModelController
                        onMyModelChanged:{
                            bigsaleList.counter++
                        }
                    }
                }
            }

            Component{
                id:bigsaleDelegate

                Item{
                    id:bigsaleDelegateItem
                    property bool isOpen: false;
                    width: bigsaleList.width
                    height: isOpen? 400 : 60;
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    Rectangle{
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 15;
                        height: bigsaleDelegateItem.isOpen? 400 : 60;
                        color:"#e7e2e2"
                        border.width: 2
                        border.color: "blue"
                        Rectangle {
                            id: rectangle
                            visible: bigsaleDelegateItem.isOpen
                            x: 0
                            color: "lightgray"
                            anchors.rightMargin: 2
                            anchors.leftMargin: 2
                            anchors.bottomMargin: 2
                            anchors.topMargin: 60
                            anchors.fill: parent
                            Text {
                                x: 15
                                y: 4
                                width: 360
                                height: 31
                                text: "" +  m_Name
                                font.pointSize: 18
                                anchors.leftMargin: 10
                                anchors.left: parent.left
                            }
                            Text {
                                x: 18
                                y: 50
                                width: 95
                                height: 17
                                text: "" + m_ProductCount;
                                font.pointSize: 14
                                anchors.leftMargin: 3
                                anchors.left: parent.left
                            }
                            Text {
                                x: 15
                                y: 13
                                width: 94
                                height: 27
                                text: "" + m_Price;
                                font.pointSize: 16
                                anchors.leftMargin: 488
                                anchors.left: parent.left
                            }
                        }
                        Text{
                            x:15;
                            y: 0
                            text: "id:" +  m_MainId;
                            anchors.leftMargin: 2
                            anchors.left: parent.left;
                        }

                        Text {
                            x: 246
                            y: 20
                            width: 152
                            height: 46
                            text: qsTr("Date")
                            font.pixelSize: 12
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            onClicked: bigsaleDelegateItem.isOpen = !bigsaleDelegateItem.isOpen;
                        }
                    }
                }
            }
            Item{
                id: element_chag
                anchors.fill: parent
                visible: false
                Rectangle {
                    id: rectangle_chag
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }

                Rectangle {
                    id: rectangle_element_chag
                    height: 300
                    width: 700
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 3
                    visible: true
                    anchors.centerIn: rectangle_chag;

                    MyButton{
                        id:accept_btn_chag
                        y: 598
                        width: 120
                        height: 40
                        visible: true
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                        button_border_color: "blue"
                        button_text_color: "blue"
                        button_text: "Изменить"
                        button_round: 15
                        onButton_clicked:{
                            simpleModelController.updatePlan(informationPage.pBarCode, spinBox.value);
                            element_chag.visible = false;
                        }
                    }

                    MyButton{
                        id:decline_btn_chag
                        x: 318
                        y: 592
                        width: 120
                        height: 40
                        visible: true
                        anchors.right: parent.right
                        anchors.rightMargin: 100
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                        button_border_color: "red"
                        button_text_color: "red"
                        button_text: "Отмена"
                        button_round: 15
                        onButton_clicked: {
                            element_chag.visible = false;
                        }
                    }

                    Text {
                        id: element
                        x: 44
                        y: 32
                        width: 612
                        height: 81
                        text: qsTr("Установите новое кол-во для закупки продукта " + bigsalePage.pName);
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        visible: true
                        font.pixelSize: 22
                    }

                    SpinBox {
                        id: spinBox
                        x: 243
                        y: 119
                        width: 214
                        height: 40
                        to: 1000000
                        from: 0
                        value: bigsalePage.pCount;
                        visible: true
                    }
                }
            }
        }
    }
}





