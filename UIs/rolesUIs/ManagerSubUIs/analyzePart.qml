import QtQuick 2.0
import QtCharts 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
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
    property string pName: ""
    property string pBarCode: ""
    property int pCount: 0
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
                radius: 8
                anchors.rightMargin: 300
                anchors.leftMargin: 300
                anchors.bottomMargin: 20
                anchors.topMargin: 20
                anchors.fill: parent
                MyButton{
                    id:printBtn
                    button_height: 64
                    button_width: 64
                    button_text: ""
                    button_border_color: "blue"
                    button_round: 10;
                    visible: true
                    x:810
                    y:22
                    width: 64
                    height: 64
                    button_image_source: "print.png"
                    onButton_clicked: simpleModelController.printPlan(parseInt(textField.text,10));
                }
                TextField {
                    id: textField
                    x: 62
                    y: 29
                    width: 256
                    height: 50
                    text: qsTr("")
                    placeholderText: "№ Магазина"
                    font.pointSize: 18
                }

                MyButton{
                    id:btn_AnalyzeStart
                    x: 529
                    y: 29
                    width: 266
                    height: 50
                    button_border_color: "blue"
                    button_text_color: "blue"
                    button_text: "Проанализировать"
                    button_round: 15
                    onButton_clicked: {
                        if(textField.text.length==0  || textField1.text.length == 0)
                        {

                        }else {
                            analitic_part.startAnalize(textField.text, textField1.text);
                        }
                    }
                }
                TextField {
                    id: textField1
                    x: 328
                    y: 29
                    width: 188
                    height: 50
                    text: qsTr("")
                    placeholderText: "Дата начала"
                    font.pointSize: 18
                    onPressed: calendarF.visible = true;
                }
                Calendar{
                    id:calendarF;
                    z:1
                    visible: false;
                    anchors.left: textField1.left;
                    anchors.right: textField1.right;
                    anchors.top: textField1.top
                    anchors.topMargin: textField1.height;
                    onSelectedDateChanged:{
                        var date = "" + calendarF.selectedDate.getDate() + "." + (calendarF.selectedDate.getMonth() + 1)+ "." + calendarF.selectedDate.getFullYear();
                        textField1.text = date;
                        calendarF.visible = false;
                    }
                }
                Rectangle {
                    id: planListBackground
                    color: "#ffffff"
                    anchors.rightMargin: -400
                    anchors.left: parent.horizontalCenter
                    anchors.right: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: -400
                    anchors.bottomMargin: 0
                    anchors.topMargin: 92
                    anchors.top: parent.top
                    border.color: "gray"
                    border.width: 0

                    ListView {
                        property int counter: 0;
                        id: planList
                        visible: false;
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
                                font.pointSize:15
                            }
                            Text{
                                x: 130
                                y: 25
                                width: 167
                                height: 34
                                text: qsTr("Закупка: " + m_ProductCount);
                                font.pointSize: 16
                            }
                            Image {
                                id: image1
                                x: 8
                                y: 6
                                width: 98
                                height: 69
                                fillMode: Image.PreserveAspectFit
                                source: "../../MyUIs/barcode.jpg"
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
                            Text {
                                x: 15
                                y: 47
                                width: 120
                                height: 25
                                text: "Рекомендовано к закупке: " + m_Difference
                                font.pointSize: 16
                                anchors.leftMargin: 130
                                anchors.left: parent.left
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    analitic_part.updateValuesForIt("" + m_BarCode);
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
                                    element_add.visible = true;
                                }
                            }

                            MyButton{
                                id:btn_Change
                                width: 110
                                button_round: 15
                                button_height: btn_Change.height;
                                button_width: btn_Change.width;
                                button_text:"Изменить"
                                button_border_color: "blue"
                                button_border_width: 2;
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                anchors.top: parent.top
                                anchors.topMargin: 20
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 20
                                onButton_clicked: {
                                    analyzePage.pName = m_Name;
                                    analyzePage.pBarCode = m_BarCode;
                                    analyzePage.pCount = m_ProductCount;
                                    element_chag.visible = true;
                                }
                            }

                        }
                    }
                }
            }
            Item{
                id: element
                anchors.fill: parent
                visible: false
                Rectangle {
                    id: rectangle44
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }

                Rectangle {
                    id: rectangle2
                    height: 702
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 8
                    anchors.rightMargin: 400
                    anchors.leftMargin: 400
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 280
                    anchors.topMargin: 220

                    MyButton{
                        id:close_btn
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
                    simpleModelController.showFromPlan(2,textField.text);
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
                    // element.visible = true;
                    planList.counter++;
                    planList.visible = true;
                }
                onDaysCountChanged: analyzePageItem.days = analitic_part.daysCount;
            }

            Item{
                id: element_add
                x: 300
                y: 20
                anchors.fill: parent
                visible: false
                Rectangle {
                    id: rectangle
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }
                Rectangle {
                    id: rectangle_element
                    height: 702
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 8
                    anchors.rightMargin: 100
                    anchors.leftMargin: 100
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 30
                    anchors.topMargin: 30
                    MyButton{
                        id:accept_btn
                        width: 30
                        height: 30
                        z: 1
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        button_border_color: "red"
                        button_text_color: "red"
                        button_text: "X"
                        button_round: 15
                        onButton_clicked: {
                            element_add.visible = false;
                        }
                    }
                    Rectangle {
                        id: rectangle3
                        anchors.rightMargin: 10
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 10
                        anchors.topMargin: 10
                        anchors.fill: parent
                        visible: true

                        ChartView {
                            id: area1
                            antialiasing: true
                            anchors.rightMargin: 20
                            anchors.bottomMargin: 20
                            title: "Статистика продаж"
                            LineSeries {
                                id: cc
                                name: "Текущая статистика"
                                axisX: ValueAxis {
                                    id: x2
                                    min: 0
                                    max: analyzePageItem.days
                                    visible: false
                                }
                                axisY: ValueAxis {
                                    id: x1
                                    min: 0
                                    max: analitic_part.topValueMargin+40
                                    visible: false
                                }
                            }

                            LineSeries {
                                id: cc1
                                name: "Предшествующая статистика"
                                axisX: ValueAxis {
                                    id: x4
                                    min: 0
                                    max: analyzePageItem.days
                                    visible: false
                                }
                                axisY: ValueAxis {
                                    id: x3
                                    min: 0
                                    max: analitic_part.topValueMargin+40
                                    visible: false
                                }
                            }

                            LineSeries {
                                id: cc2
                                name: "Прогноз"
                                axisX: ValueAxis {
                                    id: x6
                                    min: 0
                                    max: analyzePageItem.days
                                    visible: true
                                }
                                axisY: ValueAxis {
                                    id: x5
                                    min: 0
                                    max: analitic_part.topValueMargin+40
                                    visible: true
                                }
                            }
                            anchors.fill: parent
                            anchors.leftMargin: 20
                            anchors.topMargin: 20
                        }

                        Text {
                            id: element2
                            x: 20
                            y: 66
                            width: 139
                            height: 24
                            text: qsTr("Кол-во продаж")
                            font.pixelSize: 16
                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        }

                        Text {
                            id: element3
                            y: 718
                            width: 113
                            height: 23
                            text: qsTr("Кол-во дней")
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: area1.bottom
                            anchors.bottomMargin: 10
                            font.pixelSize: 16
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
                    radius: 8
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
                            simpleModelController.updatePlan(analyzePage.pBarCode, spinBox.value, textField.text);
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
                        id: textMessage
                        x: 44
                        y: 50
                        width: 512
                        height: 37
                        text: "Установите новое кол-во для закупки продукта "
                        anchors.horizontalCenter: parent.horizontalCenter
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
                        value: analyzePage.pCount;
                        visible: true
                    }
                }
            }
        }

    }
}














/*##^## Designer {
    D{i:4;anchors_height:200;anchors_width:200}D{i:24;anchors_height:30;anchors_y:598}
D{i:23;anchors_height:30;anchors_y:598}
}
 ##^##*/
