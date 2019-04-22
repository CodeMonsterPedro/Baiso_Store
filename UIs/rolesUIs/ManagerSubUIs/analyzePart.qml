﻿import QtQuick 2.0
import QtCharts 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import analitic_item 1.0;
import "../../MyUIs"


Item{
    id:analyzePage
    width: analyzePageCanvas.width
    height: analyzePageCanvas.height
    property var resultL: [];
    property var prevL: [];
    property var curL: [];
    Rectangle {
        id: analyzePageCanvas
        width: Screen.width-76
        height: Screen.height-28

        Text {
            id: text1
            x: 18
            y: 0
            width: 636
            height: 50
            color: "#0000ff"
            text: qsTr("Анализ и прогнозирование")
            font.pixelSize: 43
        }

        Rectangle {
            property int days: 28;

            id: analyzePageItem
            color: "#d3d3d3"
            anchors.topMargin: 60
            anchors.fill: parent
            Rectangle {
                id: rectangle1
                color: "#ffffff"
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.bottomMargin: 20
                anchors.topMargin: 20
                anchors.fill: parent

                ChartView {
                    id: area1;
                    anchors.rightMargin: 20
                    anchors.leftMargin: 20
                    anchors.topMargin: 90
                    anchors.bottomMargin: 20
                    anchors.fill: parent
                    title:"Статистика продаж"
                    antialiasing: true
                    LineSeries {
                        id:cc;
                        name: "Текущая статистика"
                        axisY: ValueAxis{
                            id:x1
                            visible: false
                            min: 0;
                            max: analitic_part.topValueMargin+40
                        }
                        axisX: ValueAxis{
                            id:x2
                            visible: false
                            min: 0;
                            max: analyzePageItem.days;
                        }
                    }
                    LineSeries {
                        id:cc1;
                        name: "Предшествующая статистика"
                        axisY: ValueAxis{
                            id:x3
                            visible: false
                            min: 0;
                            max: analitic_part.topValueMargin+40
                        }
                        axisX: ValueAxis{
                            id:x4
                            visible: false
                            min: 0;
                            max: analyzePageItem.days;
                        }
                    }
                    LineSeries {
                        id:cc2;
                        name: "Прогноз"
                        axisY: ValueAxis{
                            id:x5
                            visible: true
                            min: 0;
                            max: analitic_part.topValueMargin+40
                        }
                        axisX: ValueAxis{
                            id:x6
                            visible: true
                            min: 0;
                            max: analyzePageItem.days;
                        }
                    }
                }
                ComboBox {
                    id: comboBox
                    x: 533
                    y: 29
                    width: 143
                    height: 38
                    font.pointSize: 18
                    model:["Месяц","Три месяца","Год"]
                    onCurrentIndexChanged: {
                        if(comboBox.currentIndex == 0)analyzePageItem.days=28;
                        if(comboBox.currentIndex == 1)analyzePageItem.days=84;
                        if(comboBox.currentIndex == 2)analyzePageItem.days=365;
                    }
                }

                TextField {
                    id: textField
                    x: 39
                    y: 29
                    width: 256
                    height: 38
                    text: qsTr("")
                    placeholderText: "Продукт \\ Штрихкод"
                    font.pointSize: 18
                }

                MyButton{
                    id:btn_AnalyzeStart
                    x: 709
                    y: 29
                    width: 218
                    height: 38
                    button_border_color: "blue"
                    button_text_color: "blue"
                    button_text: "Проанализировать"
                    button_round: 15
                    onButton_clicked: analitic_part.startAnalize(textField.text, textField1.text);

                }

                TextField {
                    id: textField1
                    x: 310
                    y: 29
                    width: 188
                    height: 38
                    text: qsTr("")
                    placeholderText: "Дата начала"
                    font.pointSize: 18
                }

                Text {
                    id: element2
                    x: 31
                    y: 149
                    width: 139
                    height: 24
                    text: qsTr("Кол-во продаж")
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    font.pixelSize: 16
                }

                Text {
                    id: element3
                    y: 718
                    width: 113
                    height: 23
                    text: qsTr("Кол-во дней")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 0
                    font.pixelSize: 16
                }
            }

        }

        Item{
            id: element
            anchors.fill: parent
            visible: false;
            Rectangle {
                id: rectangle
                color: "#090808"
                opacity: 0.5
                anchors.fill: parent
            }

            Rectangle {
                id: rectangle2
                height: 702
                color: "#ffffff"
                border.color:"blue"
                radius: 3
                anchors.rightMargin: 400
                anchors.leftMargin: 400
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottomMargin: 280
                anchors.topMargin: 220

                MyButton{
                    id:accept_btn
                    y: 598
                    width: 120
                    height: 40
                    anchors.left: parent.left
                    anchors.leftMargin: 190
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 70
                    button_border_color: "blue"
                    button_text_color: "blue"
                    button_text: "Принять"
                    button_round: 15
                    onButton_clicked:{
                        analitic_part.acceptRequest();
                        element.visible = false;
                    }
                }

                MyButton{
                    id:decline_btn
                    x: 318
                    y: 592
                    width: 120
                    height: 40
                    anchors.right: parent.right
                    anchors.rightMargin: 190
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 70
                    button_border_color: "red"
                    button_text_color: "red"
                    button_text: "Отклонить"
                    button_round: 15
                    onButton_clicked: {
                        analitic_part.declineRequest();
                        element.visible = false;
                    }
                }

                Text {
                    id: element1
                    height: 201
                    text: qsTr("По результатам анализа было раcчитано что продажи продукта  " + analitic_part.currentProduct + " на следующий период будут " + analitic_part.nPlnCnt + ", что на  " + analitic_part.newCoef + " едениц отличается от текущего плана, принять ли полученный результат как новую сумму для закупки товара?")
                    verticalAlignment: Text.AlignTop
                    anchors.right: parent.right
                    anchors.rightMargin: 50
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    anchors.top: parent.top
                    anchors.topMargin: 70
                    font.pixelSize: 19
                }
            }

        }

        Analitic{
            id:analitic_part;
            onAlgorithmEnded: {
                cc.clear();
                cc1.clear();
                cc2.clear();
                for(var i=0;i<analitic_part.rList.length;i++){
                    cc.append(i,analitic_part.cList[i]);
                    cc1.append(i,analitic_part.pList[i]);
                    cc2.append(i,analitic_part.rList[i]);
                    analyzePage.resultL.push(analitic_part.rList[i]);
                    analyzePage.curL.push(analitic_part.cList[i]);
                    analyzePage.prevL.push(analitic_part.pList[i]);
                }
                element.visible = true;
            }
        }
    }
}



























































































































/*##^## Designer {
    D{i:5;anchors_height:300;anchors_width:300;anchors_x:42;anchors_y:20}D{i:15;anchors_width:651;anchors_x:90;anchors_y:110}
D{i:18;anchors_height:200;anchors_width:200}D{i:20;anchors_x:681}D{i:4;anchors_height:200;anchors_width:200}
D{i:22;anchors_x:71}D{i:24;anchors_width:651;anchors_x:90;anchors_y:110}D{i:23;anchors_width:120;anchors_x:318}
D{i:21;anchors_height:200;anchors_width:200}
}
 ##^##*/
