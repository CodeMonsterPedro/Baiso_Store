import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    id:informationPage
    property string pName: ""
    property string pBarCode: ""
    property int pCount: 0

    width: rootInformationCanvas.width
    height: rootInformationCanvas.height;
    Component.onCompleted: {
        simpleModelController.showFromPlan(3);
    }

    Rectangle {
        id: rootInformationCanvas
        width: Screen.width-76
        height: Screen.height-28

        Text {
            id: text1
            x: 18
            y: 0
            width: 636
            height: 50
            color: "#0000ff"
            text: qsTr("План закупок продукции")
            font.pixelSize: 43
        }

        Rectangle {
            id: informationListItem
            color: "#d3d3d3"
            anchors.topMargin: 60
            anchors.fill: parent

            Rectangle {
                id: planListBackground
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
                    id: planList
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.fill: parent
                    spacing: 25
                    cacheBuffer: 500000;
                    clip: true;
                    model: counter, simpleModelController.myPlan;
                    delegate:planDelegate;
                    Connections {
                        target: simpleModelController
                        onMyPlanChanged:{
                            planList.counter++
                        }
                    }
                }
            }

            Component{
                id:planDelegate
                Item {
                    x: 2
                    width: planList.width-10;
                    height: 80
                    Rectangle {
                        id: rectangle11
                        color: "#ffffff"
                        anchors.fill: parent
                        border.color:"blue"
                        border.width: 2;
                        Text{
                            x: 130
                            y: 4
                            width: 214
                            height: 39
                            text: qsTr("Продукт: " + m_Name)
                            font.pointSize:18;
                        }
                        Text{
                            x: 130
                            y: 41
                            width: 167
                            height: 34
                            text: qsTr("Ящиков к закупке: " + m_ProductCount);
                            font.pointSize: 18
                        }
                        Image {
                            id: image1
                            x: 8
                            y: 6
                            width: 98
                            height: 69
                            fillMode: Image.PreserveAspectFit
                            source: "barcode.jpg"
                        }
                        Text {
                            x: 15
                            y: 58
                            width: 95
                            height: 17
                            text: "" + m_BarCode;
                            anchors.leftMargin: 12
                            anchors.left: parent.left
                        }
                        Button{
                            id:btn_Change
                            x: 607
                            width: 85
                            text:"Изменить"
                            anchors.right: parent.right
                            anchors.rightMargin: 8
                            anchors.top: parent.top
                            anchors.topMargin: 8
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 8
                            onClicked: {
                                informationPage.pName = m_Name;
                                informationPage.pBarCode = m_BarCode;
                                informationPage.pCount = m_ProductCount;
                                element_chag.visible = true;
                            }
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
                        text: qsTr("Установите новое кол-во для закупки продукта " + informationPage.pName);
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
                        value: informationPage.pCount;
                        visible: true
                    }
                }
            }
        }
    }
}






