import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"


Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    property var deleteList: []
    property int tableFontSize: 11
    property string pName: ""
    property string sup: ""
    property string com: ""
    property string sys: ""
    property int inBox: 0;
    property real price: 0.0;
    property string bcode: ""
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
                    model:["Продукты","Продажи"]
                    onCurrentIndexChanged: simpleModelController.showFrom(comboBox1.currentIndex);

                    onCurrentTextChanged: {
                        if(comboBox1.currentText=="Продукты")listView.delegate = productDelegate;
                        if(comboBox1.currentText=="Продажи")listView.delegate = saleDelegate;
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
                        visible: comboBox1.currentText=="Продажи";
                        color:"lightgray"
                        Row{
                            anchors.fill: parent
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40;
                                CheckBox{
                                    opacity: 0.0
                                    anchors.centerIn:parent;
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                Text{
                                    anchors.centerIn: parent;
                                    text: "Id";
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                Text {
                                    anchors.centerIn: parent;
                                    text: "Название продукта"
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                Text {
                                    anchors.centerIn: parent;
                                    text: "Штрих-код"
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
                                Text {
                                    anchors.centerIn: parent
                                    text: "Цена за еденицу";
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth2;
                                height: 40
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
                        visible: comboBox1.currentText=="Продажи";
                        color:"lightgray"
                        Row{
                            visible: !btn_ToggleListType.listType;
                            anchors.fill: parent;
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                CheckBox{
                                    opacity: 0.0
                                    anchors.centerIn:parent;
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                Text {
                                    text: "Номер чека";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                Text {
                                    text: "Название продукта"
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                Text {
                                    text: "Номер магазина";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                Text {
                                    text: "Купленное кол-во";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                Text {
                                    text: "Цена за еденицу";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }

                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
                                Text {
                                    text: "Дата продажи";
                                    anchors.centerIn: parent;
                                    font.pointSize: rootDataBase.tableFontSize
                                }
                            }
                            Rectangle{
                                width: listHeaderItem.tableItemWidth;
                                height: 40;
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

                                Button {
                                    id: button
                                    text: qsTr("Button")
                                    onClicked: {
                                        product_element_chag.visible = true;
                                        rootDataBase.pName = m_Name;
                                        rootDataBase.sup = m_Supplyer;
                                        rootDataBase.com = m_Company;
                                        rootDataBase.sys = m_CountSys;
                                        rootDataBase.price = m_Price;
                                        rootDataBase.inBox = m_InBoxCount;
                                        rootDataBase.bcode = m_BarCode;

                                    }
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
                    radius: 3
                    anchors.rightMargin: 400
                    anchors.leftMargin: 400
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 60
                    anchors.topMargin: 110
                    ComboBox{
                        id:element_add_combobox
                        x: 236
                        y: 40
                        model:["Продукт","Продажу"];
                    }


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
                            if(element_add_combobox.currentIndex==0){
                                //"product_name","In_box_count","supplyer","company","price","count_sys","bar_code")
                                //"10","14","11","12","15","16","13"
                                var str = "" + textField10.text + "|" + textField14.text + "|" + textField11.text + "|" + textField12.text + "|" + textField15.text + "|" + textField16.text + "|" + textField13.text
                                simpleModelController.addNewProductToRep(str);
                                textField10.text="";
                                textField11.text="";
                                textField12.text="";
                                textField13.text="";
                                textField14.text="";
                                textField15.text="";
                                textField16.text="";
                            } else if(element_add_combobox.currentIndex==1){
                                var str = "" + textField21.text + "|" + textField22.text + "|" + textField23.text + "|" + textField24.text + "|" + textField25.text + "|" + textField26.text;
                                simpleModelController.addNewPurchaseToRep(str);

                            }
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
                            textField21.text="";
                            textField22.text="";
                            textField23.text="";
                            textField24.text="";
                            textField25.text="";
                            textField26.text="";
                        }
                    }
                    Rectangle {
                        height: 387
                        visible: element_add_combobox.currentindex===0 ? true : false;
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
                            y: 104
                            text: qsTr("")
                            placeholderText: "Цена за еденицу"
                        }
                        TextField {
                            id: textField16
                            x: 413
                            y: 180
                            text: qsTr("")
                            placeholderText: "Система исчисления"
                        }
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 91
                        anchors.rightMargin: 37
                    }
                    Rectangle {
                        height: 387
                        visible: element_add_combobox.currentindex===1 ? true : false;
                        anchors.right: parent.right
                        anchors.leftMargin: 28
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 91
                        anchors.rightMargin: 37

                        TextField {
                            id: textField21
                            x: 69
                            y: 29
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Название продукта"
                        }

                        TextField {
                            id: textField22
                            x: 69
                            y: 104
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Номер магазина"
                        }

                        TextField {
                            id: textField23
                            x: 69
                            y: 180
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Номер чека"
                        }

                        TextField {
                            id: textField24
                            x: 69
                            y: 257
                            width: 251
                            height: 40
                            text: qsTr("")
                            placeholderText: "Кол-во продукта"
                        }

                        TextField {
                            id: textField25
                            x: 413
                            y: 29
                            text: qsTr("")
                            placeholderText: "Цена за еденицу"
                        }

                        TextField {
                            id: textField26
                            x: 413
                            y: 104
                            text: qsTr("")
                            placeholderText: "Дата продажи"
                        }

                    }

                    Text {
                        id: element1
                        x: 99
                        y: 40
                        width: 129
                        height: 40
                        text: qsTr("Добавить")
                        font.pixelSize: 26
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
                            if(comboBox1.currentText=="Продукты")simpleModelController.deleteItems(str,0,"Product");
                            else if(comboBox1.currentText=="Продажи")simpleModelController.deleteItems(str,0,"Sale");
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
                            if(comboBox1.currentText=="Продукты")simpleModelController.deleteItems(str,1,"Product");
                            else if(comboBox1.currentText=="Продажи")simpleModelController.deleteItems(str,1,"Sale");
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
                visible: false
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
                    anchors.bottomMargin: 150
                    anchors.topMargin: 150

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
                        border.width: 0
                        anchors.rightMargin: 20
                        anchors.leftMargin: 20
                        anchors.bottomMargin: 120
                        anchors.topMargin: 20
                        anchors.fill: parent
                        visible: true

                        TextField {
                            id: textField1
                            x: 51
                            y: 39
                            text: qsTr("С даты")
                            onPressed: calendarF.visible = true;
                        }

                        TextField {
                            id: textField2
                            x: 299
                            y: 39
                            text: qsTr("по дату")
                            onPressed: calendarS.visible = true;
                        }

                        Switch {
                            id: element2
                            x: 51
                            y: 105
                            text: qsTr("Табличный вид")
                        }

                        Switch {
                            id: element4
                            x: 51
                            y: 158
                            text: qsTr("Switch")
                        }

                        ComboBox {
                            id: comboBox
                            x: 299
                            y: 105
                            width: 200
                            height: 40
                        }
                        Calendar{
                            id:calendarF;
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
                        Calendar{
                            id:calendarS;
                            visible: false;
                            anchors.left: textField2.left;
                            anchors.right: textField2.right;
                            anchors.top: textField2.top
                            anchors.topMargin: textField2.height;
                            onSelectedDateChanged: {
                                var date = "" + calendarS.selectedDate.getDate() + "." + (calendarS.selectedDate.getMonth() + 1)+ "." + calendarS.selectedDate.getFullYear();
                                textField2.text = date;
                                calendarS.visible = false;
                            }
                        }
                    }

                }
            }

            Item{
                id: product_element_chag
                anchors.fill: parent
                visible: false
                Rectangle {
                    id: rectangle_chag
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }
                Rectangle {
                    id: product_rectangle_element_chag
                    height: 500
                    width: 700
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 3
                    visible: true
                    anchors.centerIn: rectangle_chag;
                    TextField {
                        id: textField_Name
                        x: 69
                        y: 29
                        width: 251
                        height: 40
                        text: qsTr(rootDataBase.pName)
                    }
                    TextField {
                        id: textField_Supllyer
                        x: 69
                        y: 104
                        width: 251
                        height: 40
                        text: qsTr(rootDataBase.sup)
                    }
                    TextField {
                        id: textField_Company
                        x: 69
                        y: 180
                        width: 251
                        height: 40
                        text: qsTr(rootDataBase.com)
                    }
                    TextField {
                        id: textField_InBoxCount
                        x: 413
                        y: 29
                        text: qsTr("" + rootDataBase.inBox)
                    }
                    TextField {
                        id: textField_Price
                        x: 413
                        y: 104
                        text: qsTr("" + rootDataBase.price)
                    }
                    TextField {
                        id: textField_SysCount
                        x: 413
                        y: 180
                        text: qsTr(rootDataBase.sys)
                    }
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
                            var str = "" + textField_Name.text + "|" + textField_InBoxCount.text + "|" + textField_Supllyer.text + "|" + textField_Company.text + "|" + textField_Price.text + "|" + textField_SysCount.text;
                            simpleModelController.updateProduct(rootDataBase.bcode,str);
                            product_element_chag.visible = false;
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
                            product_element_chag.visible = false;
                        }
                    }
                }
            }

            /////////////////////////////////////////////////////////////////////
        }
    }

}




/*##^## Designer {
    D{i:76;anchors_width:120;anchors_x:318}D{i:145;anchors_height:200;anchors_y:46}
}
 ##^##*/

