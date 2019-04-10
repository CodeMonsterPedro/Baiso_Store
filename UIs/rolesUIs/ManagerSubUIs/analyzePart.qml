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
    Rectangle {
        id: rootDataBaseCanvas
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
            id: dbTableItem
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
                    title:"Sale stats"
                    antialiasing: true
                    LineSeries {
                        name: "Текущая статистика"
                        XYPoint { x: 0; y: 0 }
                        XYPoint { x: 1.1; y: 2.1 }
                        XYPoint { x: 1.9; y: 3.3 }
                        XYPoint { x: 2.1; y: 2.1 }
                        XYPoint { x: 2.9; y: 4.9 }
                        XYPoint { x: 3.4; y: 3.0 }
                        XYPoint { x: 4.1; y: 3.3 }
                    }
                    LineSeries {
                        name: "Предшествующая статистика"
                        XYPoint { x: 0; y: 0 }
                        XYPoint { x: 1.1; y: 2.0 }
                        XYPoint { x: 1.9; y: 3.1 }
                        XYPoint { x: 2.1; y: 2.0 }
                        XYPoint { x: 2.9; y: 4.3 }
                        XYPoint { x: 3.4; y: 2.7 }
                        XYPoint { x: 4.1; y: 3.0 }
                    }
                    LineSeries {
                        name: "Прогноз"
                        XYPoint { x: 0; y: 0 }
                        XYPoint { x: 1.1; y: 2.2 }
                        XYPoint { x: 1.9; y: 3.5 }
                        XYPoint { x: 2.1; y: 2.3 }
                        XYPoint { x: 2.9; y: 5.1 }
                        XYPoint { x: 3.4; y: 3.2 }
                        XYPoint { x: 4.1; y: 3.5 }
                    }
                }

                ComboBox {
                    id: comboBox
                    x: 675
                    y: 29
                    width: 186
                    height: 54
                    font.pointSize: 18
                    model:["Неделя","Месяц","Три месяца"]
                }

                TextField {
                    id: textField
                    x: 39
                    y: 29
                    width: 254
                    height: 54
                    text: qsTr("")
                    placeholderText: "Продукт \\ id"
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
        Analitic{id:analitic_part;}
    }
}





























































/*##^## Designer {
    D{i:5;anchors_height:300;anchors_width:300;anchors_x:42;anchors_y:20}D{i:4;anchors_height:200;anchors_width:200}
}
 ##^##*/
