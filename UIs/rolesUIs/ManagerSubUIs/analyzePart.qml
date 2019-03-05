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
            text: qsTr("Analize & Fortune telling")
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
                    id: area
                    anchors.topMargin: 120
                    anchors.bottomMargin: 0
                    anchors.fill: parent
                    title:"Sale stats"
                    antialiasing: true
                    LineSeries {
                        name: "Current stats"
                        XYPoint { x: 0; y: 0 }
                        XYPoint { x: 1.1; y: 2.1 }
                        XYPoint { x: 1.9; y: 3.3 }
                        XYPoint { x: 2.1; y: 2.1 }
                        XYPoint { x: 2.9; y: 4.9 }
                        XYPoint { x: 3.4; y: 3.0 }
                        XYPoint { x: 4.1; y: 3.3 }
                    }
                    LineSeries {
                        name: "Previos stats"
                        XYPoint { x: 0; y: 0 }
                        XYPoint { x: 1.1; y: 2.0 }
                        XYPoint { x: 1.9; y: 3.1 }
                        XYPoint { x: 2.1; y: 2.0 }
                        XYPoint { x: 2.9; y: 4.3 }
                        XYPoint { x: 3.4; y: 2.7 }
                        XYPoint { x: 4.1; y: 3.0 }
                    }
                    LineSeries {
                        name: "Forduned stats"
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
                    x: 358
                    y: 20
                    width: 306
                    height: 72
                    font.pointSize: 18
                    model:["Week","Month","Three monthes"]
                }

                TextField {
                    id: textField
                    x: 30
                    y: 20
                    width: 296
                    height: 72
                    text: qsTr("Product name \\ Id")
                    font.pointSize: 18
                }

                MyButton{
                    id:btn_AnalyzeStart
                    x: 730
                    y: 20
                    width: 236
                    height: 72
                    button_border_color: "blue"
                    button_text_color: "blue"
                    button_text: "Get fortune"
                    button_round: 15

                }
            }

        }
    }
}









































/*##^## Designer {
    D{i:5;anchors_height:300;anchors_width:300;anchors_x:42;anchors_y:20}D{i:4;anchors_height:200;anchors_width:200}
}
 ##^##*/
