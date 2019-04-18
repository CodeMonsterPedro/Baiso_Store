import QtQuick 2.0
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
        width: Screen.desktopAvailableWidth-76
        height: Screen.desktopAvailableHeight-28

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
                    anchors.topMargin: 120
                    anchors.bottomMargin: 0
                    anchors.fill: parent
                    title:"Статистика продаж"
                    antialiasing: true
                    ValueAxis{
                        id:axisY
                        min: 0;
                        max: analyzePageItem.days;
                    }
                    LineSeries {
                        id:cc;
                        name: "Текущая статистика"
                        axisX: CategoryAxis {
                            visible: false;
                            min: 1
                            max: analyzePageItem.days;
                            CategoryRange {
                                label: "Анализируемые дни"
                                endValue: analyzePageItem.days; id: sel1
                            }
                        }
                        axisY:CategoryAxis {
                            visible: false;
                            min: 1
                            max: analitic_part.topValueMargin;
                            CategoryRange {
                                label: "Кол-во продаж"
                                endValue: analitic_part.topValueMargin; id: sel4
                            }
                        }
                    }
                    LineSeries {
                        id:cc1;
                        name: "Предшествующая статистика"
                        axisX: CategoryAxis {
                            visible: false;
                            min: 1
                            max: analyzePageItem.days;
                            CategoryRange {
                                label: "Анализируемые дни"
                                endValue: analyzePageItem.days; id: sel2
                            }
                        }
                        axisY:CategoryAxis {
                            visible: false;
                            min: 1
                            max: analitic_part.topValueMargin;
                            CategoryRange {
                                label: "Кол-во продаж"
                                endValue: analitic_part.topValueMargin; id: sel3
                            }
                        }
                    }
                    LineSeries {
                        id:cc2;
                        name: "Прогноз"
                        axisX: CategoryAxis {
                            visible: true;
                            min: 1
                            max: analyzePageItem.days;
                            CategoryRange {
                                label: "Анализируемые дни"
                                endValue: analyzePageItem.days; id: sel5
                            }
                        }
                        axisY:CategoryAxis {
                            visible: true;
                            min: 1
                            max: analitic_part.topValueMargin;
                            CategoryRange {
                                label: "Кол-во продаж"
                                endValue: analitic_part.topValueMargin; id: sel6
                            }
                        }
                    }
                }

                ComboBox {
                    id: comboBox
                    x: 675
                    y: 29
                    width: 186
                    height: 54
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
                    width: 254
                    height: 54
                    text: qsTr("")
                    placeholderText: "Продукт \\ Штрихкод"
                    font.pointSize: 18
                }

                MyButton{
                    id:btn_AnalyzeStart
                    x: 920
                    y: 29
                    width: 291
                    height: 54
                    button_border_color: "blue"
                    button_text_color: "blue"
                    button_text: "Проанализировать"
                    button_round: 15
                    onButton_clicked: analitic_part.startAnalize(textField.text, textField1.text);

                }

                TextField {
                    id: textField1
                    x: 368
                    y: 29
                    width: 254
                    height: 54
                    text: qsTr("")
                    placeholderText: "Дата начала"
                    font.pointSize: 18
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
    D{i:5;anchors_height:300;anchors_width:300;anchors_x:42;anchors_y:20}D{i:4;anchors_height:200;anchors_width:200}
D{i:18;anchors_height:200;anchors_width:200}D{i:20;anchors_x:71}D{i:21;anchors_width:120;anchors_x:318}
D{i:22;anchors_width:651;anchors_x:90;anchors_y:110}D{i:19;anchors_height:200;anchors_width:200}
}
 ##^##*/
