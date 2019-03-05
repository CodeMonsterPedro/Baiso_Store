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
        height: Screen.desktopAvailableHeight-28;
        Text {
            id: text1
            x: 18
            y: 0
            width: 480
            height: 50
            text: qsTr("Data Base")
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


            Rectangle {
                id: rectangle2
                height: 50
                color: "white"
                border.color: "gray"
                border.width: 2
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 30

                ComboBox {
                    id: comboBox1
                    width: 180
                    anchors.top: parent.top
                    anchors.topMargin: (parent.height-comboBox1.height)/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: (parent.height-comboBox1.height)/2
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    model:simpleModelController.list;
                    onCurrentIndexChanged: simpleModelController.showFrom(comboBox1.currentIndex+1);

                    onCurrentTextChanged: {
                        if(comboBox1.currentText=="ProductList")listView.delegate = productDelegate;
                        if(comboBox1.currentText=="ProductSaleFull")listView.delegate = saleDelegate;
                    }
                }

                Item{
                    id:btn_ToggleListType
                    property bool listType: true;
                    x: 220

                    width: 200
                    height: 40
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.top: parent.top
                    anchors.topMargin: (parent.height-btn_ToggleListType.height)/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: (parent.height-btn_ToggleListType.height)/2

                    Rectangle{
                        id:btn_listType
                        visible: btn_ToggleListType.listType
                        width: 200;
                        height: 40
                        border.color:"blue"
                        border.width: 2
                        Text{
                            anchors.centerIn: parent
                            text:qsTr("List view")
                            color: "blue"
                            font.pixelSize: 20;
                        }

                    }

                    Rectangle{
                        id:btn_TableType
                        visible: !btn_ToggleListType.listType
                        width: 200;
                        height: 40;
                        border.color:"blue"
                        border.width: 2
                        Text{
                            anchors.centerIn: parent
                            text:qsTr("Table view")
                            color: "blue"
                            font.pixelSize: 20;
                        }
                    }
                    MouseArea{
                        id:btn_ToggleType
                        anchors.fill: btn_ToggleListType
                        onClicked: {
                            btn_ToggleListType.listType=!btn_ToggleListType.listType;
                            simpleModelController.toggleListType();
                        }
                    }
                }

                Item {
                    id: pageChangeItem
                    height: 40
                    anchors.rightMargin: 20
                    anchors.left: comboBox1.right
                    anchors.right: btn_ToggleListType.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: (parent.height-pageChangeItem.height)/2
                    anchors.top: parent.top
                    anchors.topMargin: (parent.height-pageChangeItem.height)/2
                    anchors.leftMargin: 20

                    Rectangle {
                        id: rectangle3
                        color: "white"
                        border.color: "gray"
                        border.width: 2
                        anchors.fill: parent

                        Button {
                            id: button
                            x: 0
                            y: 0
                            width: 40
                            text: qsTr("<-")
                            anchors.left: parent.left
                            anchors.leftMargin: 0
                            enabled: simpleModelController.currentPage > 1
                            onClicked: simpleModelController.goPrev();
                        }

                        Button {
                            id: button1
                            x: 0
                            y: 0
                            width: 40
                            text: qsTr("->")
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            enabled: simpleModelController.currentPage < simpleModelController.maxPage
                            onClicked: simpleModelController.goNext();
                        }

                        TextField {
                            id: textField
                            x: 41
                            y: 0
                            width: 82
                            height: 40
                            text: qsTr("" + simpleModelController.currentPage)
                        }

                        Text {
                            id: element3
                            x: 129
                            y: 8
                            width: 69
                            height: 24
                            text: qsTr("/ " + simpleModelController.maxPage)
                            font.pixelSize: 20
                        }

                    }
                }
            }

            Rectangle {
                id: rectangle1
                width: 709
                color: "#ffffff"
                anchors.top: rectangle2.bottom
                anchors.topMargin: 19
                border.color: "gray"
                border.width: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: 20

                ListView {
                    id: listView
                    contentHeight: 10
                    contentWidth: 10
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.fill: parent
                    spacing: 25
                    clip: true;
                    model:simpleModelController.myModel;
                    delegate:saleDelegate;


                }
            }
            /////////////////////////////////////////////////////////////////////
            Component{
                id:productDelegate
                Item{
                    width: listView.width
                    height: 100
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Rectangle{
                        anchors.fill: parent
                        anchors.leftMargin: 35;
                        anchors.rightMargin: 15;
                        height: 120;
                        color:"#e4dfdf"
                        border.width: 2
                        border.color: "blue"
                        Image {
                            id: image1
                            x: 0
                            y: 31
                            width: 98
                            height: 69
                            fillMode: Image.PreserveAspectFit
                            source: "../../MyUIs/barcode.jpg"
                        }

                        Rectangle {
                            id: rectangle
                            x: 3
                            y: 4
                            width: 28
                            height: 25
                            color: "#000000"
                            radius: 13
                        }

                        Text{
                            x:15;
                            y: 8
                            color: "#ffffff"
                            text: "" +  m_MainId;
                            anchors.leftMargin: 8
                            anchors.left: parent.left;
                        }

                        Text {
                            x: 15
                            y: 14
                            width: 455
                            height: 45
                            color:"blue"
                            text: "" +  m_Name
                            font.pointSize: 15
                            anchors.leftMargin: 128
                            anchors.left: parent.left
                        }

                        Text {
                            x: 15
                            y: 83
                            width: 95
                            height: 17
                            text: "" + m_BarCode;
                            anchors.leftMargin: 3
                            anchors.left: parent.left
                        }

                        Text {
                            x: 15
                            y: 65
                            text: "$" + m_Price + "\\" + m_CountSys;
                            font.pointSize: 14
                            anchors.leftMargin: 128
                            anchors.left: parent.left
                        }

                        Text {
                            x: 423
                            y: 75
                            text: m_InBoxCount +"\\" + m_CountSys + " in one box";
                        }



                    }
                }
            }

            Component{
                id:saleDelegate
                Item{
                    width: listView.width
                    height: 100
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Rectangle{
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 15;
                        height: 100;
                        color:"#e7e2e2"
                        border.width: 2
                        border.color: "blue"

                        Rectangle {
                            id: rectangle
                            x: 0
                            color: "lightgray"
                            anchors.rightMargin: 2
                            anchors.leftMargin: 2
                            anchors.bottomMargin: 2
                            anchors.topMargin: 20
                            anchors.fill: parent
                            Text {
                                x: 15
                                y: 8
                                width: 360
                                height: 31
                                text: "" +  m_Name
                                font.pointSize: 18
                                anchors.leftMargin: 10
                                anchors.left: parent.left
                            }
                            Text {
                                x: 15
                                y: 63
                                width: 95
                                height: 17
                                text: "Market #" + m_BarCode;
                                anchors.leftMargin: 3
                                anchors.left: parent.left
                            }

                            Text {
                                x: 15
                                y: 17
                                width: 94
                                height: 27
                                text: "$" + m_Price + " x" + m_CountSys;
                                font.pointSize: 14
                                anchors.leftMargin: 488
                                anchors.left: parent.left
                            }
                            Text {
                                x: 5
                                y: 63
                                width: 95
                                height: 17
                                text: "" + m_Date;
                                anchors.left: parent.left
                                anchors.leftMargin: 450
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
                            x: 123
                            y: 0
                            text: " Purchase #" + m_PurchId;
                        }

                    }
                }


            }

            /////////////////////////////////////////////////////////////////////

            Rectangle {
                id: addbutton

                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.left: rectangle1.right
                anchors.leftMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.right: parent.right
                anchors.rightMargin: 20

                border.color: "gray";
                border.width: 2;
                color: "#ffffff"


                Rectangle{
                    height: 434
                    anchors.top: parent.top
                    anchors.topMargin: 2
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                    anchors.left: parent.left
                    anchors.leftMargin: 2

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
                        button_text: "Add new"
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
                    anchors.rightMargin: 2
                    anchors.left: parent.left
                    anchors.leftMargin: 2

                    Text {
                        id: element1
                        x: 8
                        y: 8
                        width: 241
                        height: 32
                        text: qsTr("Sort records List")
                        font.pixelSize: 18
                    }

                    ComboBox {
                        id: comboBox
                        x: 69
                        y: 46
                        width: 248
                        height: 40
                    }

                    ComboBox {
                        id: comboBox2
                        x: 69
                        y: 100
                        width: 248
                        height: 40
                    }

                    MyButton {
                        id: submiAddButton1
                        x: 169
                        y: 167
                        width: 148
                        height: 40
                        button_round: 15
                        button_text: "Sort"
                        button_text_color: "#0000ff"
                        button_border_color: "#0000ff"
                    }

                    Text {
                        id: element2
                        x: 418
                        y: 8
                        width: 241
                        height: 32
                        text: qsTr("Delete record")
                        font.pixelSize: 18
                    }

                    MyButton {
                        id: submiAddButton2
                        x: 579
                        y: 167
                        width: 148
                        height: 40
                        button_round: 15
                        button_text: "Delete"
                        button_text_color: "#0000ff"
                        button_border_color: "#0000ff"
                    }

                    TextField {
                        id: textField9
                        x: 476
                        y: 46
                        width: 251
                        height: 40
                        text: qsTr("")
                        placeholderText: "id"
                    }

                }
            }


        }
    }

}












































/*##^## Designer {
    D{i:5;anchors_width:1414;anchors_x:15}D{i:8;anchors_height:622;anchors_width:729;anchors_x:0;anchors_y:74}
D{i:7;anchors_width:1216;anchors_x:24}D{i:10;anchors_width:715}D{i:9;anchors_height:704;anchors_width:200;anchors_x:730;anchors_y:8}
D{i:11;anchors_height:622;anchors_width:729;anchors_x:0;anchors_y:74}D{i:6;anchors_height:40;anchors_x:220;anchors_y:5}
D{i:17;anchors_height:704;anchors_width:200;anchors_x:730;anchors_y:8}D{i:13;anchors_height:200;anchors_width:200}
D{i:12;anchors_height:37;anchors_width:263;anchors_x:212;anchors_y:5}D{i:4;anchors_width:709;anchors_x:20;anchors_y:30}
D{i:19;anchors_height:704;anchors_width:715;anchors_x:730;anchors_y:8}D{i:18;anchors_height:704;anchors_width:715;anchors_x:730;anchors_y:8}
D{i:23;anchors_height:678;anchors_width:200;anchors_x:730;anchors_y:18}D{i:24;anchors_height:678;anchors_width:1216;anchors_x:24;anchors_y:18}
D{i:25;anchors_height:678;anchors_width:715;anchors_x:0;anchors_y:18}D{i:26;anchors_height:678;anchors_width:715;anchors_x:0;anchors_y:18}
D{i:27;anchors_height:678;anchors_width:715;anchors_x:0;anchors_y:18}D{i:28;anchors_height:678;anchors_width:715;anchors_x:0;anchors_y:18}
D{i:29;anchors_height:678;anchors_width:715;anchors_x:0;anchors_y:18}D{i:22;anchors_width:715;anchors_x:0}
D{i:21;anchors_width:715;anchors_x:0}D{i:20;anchors_width:715}D{i:33;anchors_height:704;anchors_x:8;anchors_y:8}
D{i:34;anchors_height:704;anchors_width:1414;anchors_x:15;anchors_y:8}D{i:35;anchors_height:704;anchors_width:1414;anchors_x:15;anchors_y:8}
D{i:36;anchors_height:704;anchors_width:1414;anchors_x:15;anchors_y:8}D{i:37;anchors_height:704;anchors_width:1414;anchors_x:15;anchors_y:8}
D{i:38;anchors_width:1414;anchors_x:15}D{i:39;anchors_width:1414;anchors_x:15}D{i:32;anchors_height:704;anchors_width:715;anchors_x:8;anchors_y:8}
D{i:31;anchors_height:704;anchors_width:715;anchors_x:8;anchors_y:8}D{i:30;anchors_width:715;anchors_x:0}
D{i:43;anchors_width:1414;anchors_x:15}D{i:44;anchors_width:1414;anchors_x:15}D{i:45;anchors_width:1414;anchors_x:15}
D{i:46;anchors_height:704;anchors_width:1414;anchors_x:8;anchors_y:8}D{i:47;anchors_height:704;anchors_x:8;anchors_y:8}
D{i:41;anchors_width:1414;anchors_x:15}D{i:40;anchors_width:1414;anchors_x:15}D{i:3;anchors_height:809;anchors_width:1516;anchors_x:0;anchors_y:116}
}
 ##^##*/
