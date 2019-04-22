import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"


Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    property var deleteList: []
    property int tableFontSize: 11

    Rectangle{
        id:rootDataBaseCanvas
        width: Screen.width-76;
        height: Screen.height-28;
        Text {
            id: text1
            x: 18
            y: 0
            width: 480
            height: 50
            text: qsTr("Просмотр данных")
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
                    property bool listType: false;
                    x: 220
                    width: btn_ToggleListType.listType? 260 : 360
                    height: 40
                    anchors.right: listType? parent.right : funcItems.left;
                    anchors.rightMargin: 10;
                    anchors.top: parent.top
                    anchors.topMargin: (parent.height-btn_ToggleListType.height)/2
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: (parent.height-btn_ToggleListType.height)/2

                    Rectangle{
                        id:btn_listType
                        visible: btn_ToggleListType.listType
                        width: 260;
                        height: 40
                        border.color:"blue"
                        border.width: 2
                        Text{
                            anchors.centerIn: parent
                            text:qsTr("Отображение списком")
                            color: "blue"
                            font.pixelSize: 20;
                        }

                    }

                    Rectangle{
                        id:btn_TableType
                        visible: !btn_ToggleListType.listType
                        width: 360;
                        height: 40;
                        border.color:"blue"
                        border.width: 2
                        Text{
                            anchors.centerIn: parent
                            text:qsTr("Отображение таблицей")
                            color: "blue"
                            font.pixelSize: 20;
                        }
                    }
                    MouseArea{
                        id:btn_ToggleType
                        anchors.fill: btn_ToggleListType
                        onClicked: {
                            btn_ToggleListType.listType=!btn_ToggleListType.listType;
                            /*if(btn_ToggleListType.listType){
                                if(comboBox1.currentText=="ProductList")listView.delegate = productDelegate;
                                if(comboBox1.currentText=="ProductSaleFull")listView.delegate = saleDelegate;
                            }else {
                                listView.delegate = 0;
                            }*/
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

                Row{
                    id:funcItems
                    width: 300
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    visible: !btn_ToggleListType.listType;
                    spacing: 10;
                    MyButton{
                        id:addbutton_2_1
                        width: 85
                        height: 40
                        button_round: 15
                        button_text: "+"
                        button_text_color: "green"
                        button_width: rectangle4.width;
                        button_height: 40;
                        button_border_color: "green"
                        onButton_clicked: element_add.visible=true;
                    }

                    MyButton{
                        id:deletebutton_2_2
                        width: 85
                        height: 40
                        button_round: 15
                        button_text: "-"
                        button_text_color: "red"
                        button_width: rectangle4.width;
                        button_height: 40;
                        button_border_color:"red"
                        onButton_clicked: element_del.visible=true;
                    }

                    MyButton{
                        id:sortbuton_2_3
                        width: 85
                        height: 40
                        button_round: 15
                        button_text: "Фильтр"
                        button_text_color: "blue"
                        button_width: rectangle4.width;
                        button_height: 40;
                        button_border_color:"blue"
                        onButton_clicked: element_sort.visible=true;
                    }
                }
            }

            Rectangle {
                id: rectangle1
                color: "#ffffff"
                anchors.top: rectangle2.bottom
                anchors.topMargin: 19
                border.color: "gray"
                border.width: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.leftMargin: btn_ToggleListType.listType? 400 : 20;
                anchors.right: parent.right;
                anchors.rightMargin: btn_ToggleListType.listType? 400 : 20;

                ListView {
                    property int counter: 0;
                    id: listView
                    contentHeight: 10
                    contentWidth: 10
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.fill: parent
                    spacing: 25
                    cacheBuffer: 500000;
                    clip: true;
                    model: counter, simpleModelController.myModel;
                    delegate:saleDelegate;
                    headerPositioning: ListView.OverlayHeader
                    header: listHeader;
                    Connections {
                        target: simpleModelController
                        onMyModelChanged:{
                            listView.counter++
                        }
                    }


                }
            }
            /////////////////////////////////////////////////////////////////////

            Component{
                id:listHeader
                Item {
                    property real tableItemWidth: listView.width/7;
                    property real tableItemWidth2: listView.width/6;
                    visible: !btn_ToggleListType.listType
                    id: listHeaderItem;
                    z:2;
                    height: 45;
                    Rectangle{

                        id:productHead
                        visible: comboBox1.currentText=="ProductList";
                        Row{
                            anchors.fill: parent
                            Rectangle{
                                opacity: 0.0
                                width: listHeaderItem.tableItemWidth2;
                                height: 40;
                                CheckBox{
                                    anchors.centerIn:parent;
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text{
                                    anchors.centerIn: parent;
                                    text: "Id";
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent;
                                    text: "Название продукта"
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent;
                                    text: "Штрих-код"
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent
                                    text: "Цена за еденицу";
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent;
                                    text: "Кол-во в одном ящике"
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                        }


                    }
                    Rectangle{
                        id:saleHead;
                        visible: comboBox1.currentText=="ProductSaleFull";
                        Row{
                            visible: !btn_ToggleListType.listType;
                            anchors.fill: parent;
                            Rectangle{
                                opacity: 0.0
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                CheckBox{
                                    anchors.centerIn:parent;
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    text: "Номер чека";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    text: "Название продукта"
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    text: "Номер магазина";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    text: "Купленное кол-во";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    text: "Цена за еденицу";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    text: "Дата продажи";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                Text{
                                    text: "id";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }


                        }

                    }
                }
            }

            Component{
                id:productDelegate
                Item{
                    id:productDelegateItem
                    property real tableItemWidth: listView.width/6;
                    width: listView.width
                    height: btn_ToggleListType.listType? 100 : 40;
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Rectangle{
                        visible: !btn_ToggleListType.listType;
                        anchors.fill: parent;
                        Row{
                            anchors.fill: parent
                            Rectangle{
                                width: productDelegateItem.tableItemWidth;
                                height: 40;
                                border.color: "black"
                                border.width: 2;
                                CheckBox{
                                    anchors.centerIn:parent;
                                    onCheckedChanged: {deleteList.push(m_MainId);}
                                }
                            }

                            Rectangle{
                                width: productDelegateItem.tableItemWidth
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text{
                                    anchors.centerIn: parent;
                                    text: "" +  m_MainId;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: productDelegateItem.tableItemWidth
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent;
                                    text: "" +  m_Name
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: productDelegateItem.tableItemWidth
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent;
                                    text: "" + m_BarCode;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: productDelegateItem.tableItemWidth
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent
                                    text: "$" + m_Price + "\\" + m_CountSys;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: productDelegateItem.tableItemWidth
                                height: 40
                                border.color: "black"
                                border.width: 2;
                                Text {
                                    anchors.centerIn: parent;
                                    text: m_InBoxCount +"\\" + m_CountSys;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                        }
                    }

                    Rectangle{
                        visible: btn_ToggleListType.listType
                        anchors.fill: parent
                        anchors.leftMargin: 15;
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
                            font.pointSize: rootDataBase.tableFontSize
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
                    id:saleDelegateItem
                    property real tableItemWidth2: listView.width/7;
                    width: listView.width
                    height: btn_ToggleListType.listType? 100 : 40;
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Row{
                        visible: !btn_ToggleListType.listType;
                        anchors.fill: parent;
                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            CheckBox{
                                anchors.centerIn:parent;
                                onCheckedChanged: {deleteList.push(m_MainId);}
                            }
                        }
                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            Text{
                                text: "" +  m_MainId;
                                anchors.centerIn: parent;
                                font.pointSize: rootDataBase.tableFontSize
                            }
                        }
                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            Text {
                                text: "" +  m_Name
                                anchors.centerIn: parent;
                                font.pointSize: rootDataBase.tableFontSize
                            }
                        }
                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            Text {
                                text: "" + m_MarketId;
                                anchors.centerIn: parent;
                                font.pointSize: rootDataBase.tableFontSize
                            }
                        }
                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            Text{
                                text: "" +  m_ProductCount;
                                anchors.centerIn: parent;
                                font.pointSize: rootDataBase.tableFontSize
                            }
                        }
                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            Text {
                                text: "$" + m_Price;
                                anchors.centerIn: parent;
                                font.pointSize: rootDataBase.tableFontSize
                            }
                        }

                        Rectangle{
                            width: saleDelegateItem.tableItemWidth2;
                            height: 40;
                            border.color: "black"
                            border.width: 2;
                            Text {
                                text: "" + m_Date.getDate() + "." + (m_Date.getMonth() + 1)+ "." + m_Date.getFullYear();
                                anchors.centerIn: parent;
                                font.pointSize: rootDataBase.tableFontSize
                            }
                        }


                    }

                    Rectangle{
                        visible: btn_ToggleListType.listType
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
                                text: "Магазин #" + m_MarketId;
                                font.pointSize: 14
                                anchors.leftMargin: 3
                                anchors.left: parent.left
                            }
                            Text {
                                x: 15
                                y: 13
                                width: 94
                                height: 27
                                text: "$" + m_Price + " x " + m_ProductCount;
                                font.pointSize: 16
                                anchors.leftMargin: 488
                                anchors.left: parent.left
                            }
                            Text {
                                x: 15
                                y: 50
                                width: 95
                                height: 17
                                text: "" + m_Date.getDate() + "." + (m_Date.getMonth() + 1)+ "." + m_Date.getFullYear();
                                font.pointSize: 14
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
                    }
                }


            }

            Rectangle {
                visible: btn_ToggleListType.listType
                id: rectangle4
                x: 1424
                width: 123
                height: 192
                color: "#ffffff"
                radius: 15
                anchors.top: rectangle1.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: -23

                MyButton{
                    id:addbutton_2
                    x: 13
                    y: 13
                    width: 85
                    height: 40
                    button_round: 15
                    button_text: "+"
                    button_text_color: "green"
                    button_width: rectangle4.width;
                    button_height: 40;
                    button_border_color: "green"
                    onButton_clicked: element_add.visible=true;
                }

                MyButton{
                    id:deletebutton_2
                    x: 13
                    y: 75
                    width: 85
                    height: 40
                    button_round: 15
                    button_text: "-"
                    button_text_color: "red"
                    button_width: rectangle4.width;
                    button_height: 40;
                    button_border_color:"red"
                    onButton_clicked: element_del.visible=true;
                }

                MyButton{
                    id:sortbuton_2
                    x: 13
                    y: 140
                    width: 85
                    height: 40
                    button_round: 15
                    button_text: "Фильтр"
                    button_text_color: "blue"
                    button_width: rectangle4.width;
                    button_height: 40;
                    button_border_color:"blue"
                    onButton_clicked: element_sort.visible=true;
                }
            }

            Item{
                id: element_add
                anchors.fill: parent
                visible: true
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
                    radius: 3
                    anchors.rightMargin: 400
                    anchors.leftMargin: 400
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 60
                    anchors.topMargin: 110


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
                        button_text: "Добавить"
                        button_round: 15
                        onButton_clicked:{
                            element_add.visible = false;
                            var str = "" + textField10.text + "|" + textField14.text + "|" + textField11.text + "|" + textField12.text + "|" + textField15.text + "|" + textField16.text + "|" + textField17.text + "|" + textField18.text
                            simpleModelController.addNewElementToRep(str);
                            textField10.text="";
                            textField11.text="";
                            textField12.text="";
                            textField13.text="";
                            textField14.text="";
                            textField15.text="";
                            textField16.text="";
                            textField17.text="";
                            textField18.text="";
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
                        button_text: "Отмена"
                        button_round: 15
                        onButton_clicked: {
                            element_add.visible = false;
                            textField10.text="";
                            textField11.text="";
                            textField12.text="";
                            textField13.text="";
                            textField14.text="";
                            textField15.text="";
                            textField16.text="";
                            textField17.text="";
                            textField18.text="";

                        }
                    }
                    /*
                    ComboBox {
                        id: comboBox3
                        y: 47
                        width: 180
                        anchors.leftMargin: 39
                        anchors.left: parent.left
                        model: simpleModelController.list
                    }
*/
                    Rectangle {
                        height: 387
                        // visible: comboBox3.currentText=="ProductList" ? true : false;
                        visible: true;
                        anchors.right: parent.right
                        anchors.leftMargin: 28
                        TextField {
                            id: textField10
                            x: 69
                            y: 29
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Название продукта"
                        }

                        TextField {
                            id: textField11
                            x: 69
                            y: 104
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Поставщик"
                        }

                        TextField {
                            id: textField12
                            x: 69
                            y: 180
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Производитель"
                        }

                        TextField {
                            id: textField13
                            x: 69
                            y: 257
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Штрихкод"
                        }

                        TextField {
                            id: textField14
                            x: 413
                            y: 29
                            text: qsTr("")
                            placeholderText: "Кол-во в одной коробке"
                        }

                        TextField {
                            id: textField15
                            x: 413
                            y: 320
                            text: qsTr("")
                            placeholderText: "Цена за еденицу"
                        }
                        TextField {
                            id: textField16
                            x: 413
                            y: 257
                            text: qsTr("")
                            placeholderText: "Цена за еденицу"
                        }
                        TextField {
                            id: textField17
                            x: 413
                            y: 180
                            text: qsTr("")
                            placeholderText: "Цена за еденицу"
                        }
                        TextField {
                            id: textField18
                            x: 413
                            y: 104
                            text: qsTr("")
                            placeholderText: "Цена за еденицу"
                        }
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 91
                        anchors.rightMargin: 37
                    }
                }
            }


            Item{
                id: element_del
                anchors.fill: parent
                visible: false
                Rectangle {
                    id: rectangle_del
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }

                Rectangle {
                    id: rectangle_element_del
                    height: 300
                    width: 700
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 3
                    anchors.centerIn: rectangle_del;

                    MyButton{
                        id:accept_btn_del
                        y: 598
                        width: 120
                        height: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                        button_border_color: "blue"
                        button_text_color: "blue"
                        button_text: "Удалить"
                        button_round: 15
                        onButton_clicked:{
                            element_del.visible = false;
                            var str = "";
                            for(var i=0;i<rootDataBase.deleteList.length;i++){
                                str+= "" + rootDataBase.deleteList[i].toString() + "|";
                            }
                            simpleModelController.deleteItems(str,0);
                            rootDataBase.deleteList = [];

                        }
                    }

                    MyButton{
                        id:decline_btn_del
                        x: 318
                        y: 592
                        width: 120
                        height: 40
                        anchors.right: parent.right
                        anchors.rightMargin: 100
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                        button_border_color: "red"
                        button_text_color: "red"
                        button_text: "Отмена"
                        button_round: 15
                        onButton_clicked: {
                            element_del.visible = false;

                        }
                    }

                    MyButton{
                        id:arhive_btn_del
                        y: 592
                        height: 40
                        anchors.left: accept_btn_del.right
                        anchors.leftMargin: 60
                        anchors.right: decline_btn_del.left
                        anchors.rightMargin: 60
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                        button_border_color: "gray"
                        button_text_color: "gray"
                        button_text: "В архив"
                        button_round: 15
                        onButton_clicked: {
                            element_del.visible = false;
                            var str = "";
                            for(var i=0;i<rootDataBase.deleteList.length;i++){
                                str+= "" + rootDataBase.deleteList[i].toString() + "|";
                            }
                            simpleModelController.deketeItems(str,1);
                            rootDataBase.deleteList = [];
                        }
                    }

                    Text {
                        id: element
                        x: 115
                        y: 86
                        width: 389
                        height: 81
                        text: qsTr("Удалить выбранные элементы?")
                        font.pixelSize: 28
                    }
                }
            }


            Item{
                id: element_sort
                anchors.fill: parent
                visible: false;
                Rectangle {
                    id: rectangle_sort
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }

                Rectangle {
                    id: rectangle_element_sort
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
                    anchors.bottomMargin: 230
                    anchors.topMargin: 180

                    MyButton{
                        id:accept_btn_sort
                        y: 598
                        width: 120
                        height: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 190
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 70
                        button_border_color: "blue"
                        button_text_color: "blue"
                        button_text: "Применить"
                        button_round: 15
                        onButton_clicked:{
                            element_sort.visible = false;
                        }
                    }

                    MyButton{
                        id:decline_btn_sort
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
                        button_text: "Отмена"
                        button_round: 15
                        onButton_clicked: {
                            element_sort.visible = false;
                        }
                    }

                    Rectangle {
                        y: 46
                        height: 200
                        anchors.right: parent.right
                        anchors.leftMargin: 113

                        ComboBox {
                            id: comboBox3
                            x: 69
                            y: 46
                            width: 248
                            height: 40
                            model:["По дате","По кол-ву продаж","По алфавиту"]
                        }
                        anchors.left: parent.left
                        visible: true
                        anchors.rightMargin: 160
                    }
                }
            }


            /////////////////////////////////////////////////////////////////////
        }
    }

}














/*##^## Designer {
    D{i:76;anchors_width:120;anchors_x:318}
}
 ##^##*/
