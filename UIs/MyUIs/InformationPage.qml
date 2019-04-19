import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    id:informationPage
    width: rootInformationCanvas.width
    height: {
        for (var i = 0; i < 30; i++)
        planingListModel.append({myId: 1, productName:"Apples",
                                totalCount:100, countSystem:"kgs",
                                underTip:15})
        return rootInformationCanvas.height
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
            text: qsTr("Product planing")
            font.pixelSize: 43
        }

        Rectangle {
            id: informationListItem
            color: "#d3d3d3"
            anchors.topMargin: 60
            anchors.fill: parent

            Rectangle {
                id: rectangle
                color: "#ffffff"
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.bottomMargin: 20
                anchors.topMargin: 20
                anchors.fill: parent

                ListView {
                    id: listView
                    x: 20
                    y: 20
                    spacing: 15
                    anchors.rightMargin: 20
                    anchors.leftMargin: 20
                    anchors.bottomMargin: 20
                    anchors.topMargin: 20
                    anchors.fill: parent
                    clip:true;
                    delegate:
                        Item {
                        x: 5
                        width: 700
                        height: 150

                        Rectangle {
                            id: rectangle11
                            width: 678
                            height: 153
                            color: "#ffffff"
                            border.color:"blue"
                            border.width: 2;

                            Rectangle {
                                id: rectangle1
                                x: 8
                                y: 8
                                width: 36
                                height: 34
                                color: "blue"
                                radius: 15

                                Text{
                                    x: 14
                                    y: 13
                                    width: 46
                                    height: 41
                                    text: qsTr("" + myId);
                                }
                            }

                            Text{
                                x: 15
                                y: 104
                                width: 180
                                text: qsTr("Under tip: " + underTip)
                            }

                            Text{
                                x: 148
                                y: 67
                                text: qsTr("" + countSystem);
                                font.pointSize: 11
                            }

                            Text{
                                x: 14
                                y: 67
                                text: qsTr("Paned count: " + totalCount)
                                font.pointSize: 11
                            }

                            Text{
                                x: 133
                                y: 8
                                width: 240
                                height: 41
                                text: qsTr("" + productName);
                                font.pointSize: 20
                                color:"blue"
                            }
                            Button{
                                id:btn_Change
                                x: 425
                                y: 105
                                text:"Change"
                            }
                            Button{
                                id:btn_Delete
                                x: 539
                                y: 105
                                text:"Delete";
                            }
                        }

                    }
                    model: planingListModel;
                }
                ListModel{
                    id:planingListModel
//                        ListElement{
//                            myId:1
//                            productName:"Apples"
//                            totalCount:100
//                            countSystem:"kgs"
//                            underTip:15
//                        }


                }

            }



        }
    }
}





/*##^## Designer {
    D{i:5;anchors_height:278;anchors_width:160;anchors_x:110;anchors_y:144}D{i:4;anchors_height:200;anchors_width:200}
}
 ##^##*/
