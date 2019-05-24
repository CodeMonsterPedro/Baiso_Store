import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import "../../MyUIs"


Item{
    id:rootDataBase
    width: rootDataBaseCanvas.width;
    height: rootDataBaseCanvas.height
    property var deleteList: []
    property int tableFontSize: 11

    Component.onCompleted: {
        simpleModelController.showFrom(0);
    }

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
            text: qsTr("Просмотр товаров")
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
                width: 450
                height: 50
                color: "white"
                border.color: "gray"
                border.width: 2
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 30

                Item {
                    id: pageChangeItem
                    height: 40
                    anchors.rightMargin: 40
                    anchors.left: parent.left
                    anchors.right: searchProductField.left
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: (parent.height-pageChangeItem.height)/2
                    anchors.top: parent.top
                    anchors.topMargin: (parent.height-pageChangeItem.height)/2
                    anchors.leftMargin: 40

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
                            width: 69
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
                MyButton{
                    id:sortbuton_2_3
                    width: 140
                    visible: false
                    anchors.right: parent.right
                    anchors.rightMargin: 40
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    button_round: 15
                    button_text: "Сортировка"
                    button_text_color: "blue"
                    button_width: rectangle4.width;
                    button_height: 40;
                    button_border_color:"blue"
                    onButton_clicked: element_sort.visible=true;
                }
                TextField {
                    id: searchProductField
                    visible: true;
                    property int lastLength: 0
                    x: 280
                    y: 5
                    width: 162
                    height: 40
                    placeholderText: "Поиск"
                    onTextChanged: {
                        if(searchProductField.text.length>=1){
                            if(searchProductField.text.length<lastLength){
                                simpleModelController.searchReset();
                            }
                            simpleModelController.searchProducts(searchProductField.text);
                            lastLength = searchProductField.text.length;
                        }
                        else{
                            simpleModelController.searchReset();
                            lastLength = searchProductField.text.length;
                        }
                    }
                }
            }

            Rectangle {
                id: rectangle1
                color: "#ffffff"
                anchors.rightMargin: 40
                anchors.leftMargin: 40
                anchors.top: rectangle2.bottom
                anchors.topMargin: 19
                border.color: "gray"
                border.width: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.right: parent.right;

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
                    delegate:productDelegate;
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
                    property real tableItemWidth2: listView.width/5;
                    visible: tableType.position==1.0
                    id: listHeaderItem;
                    z:2;
                    height: 45;
                    Rectangle{
                        id:productHead
                        visible: true
                        color:"lightgray"
                        Row{
                            anchors.fill: parent
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
                }
            }

            Component{
                id:productDelegate
                Item{
                    id:productDelegateItem
                    property real tableItemWidth: listView.width/5;
                    width: listView.width
                    height: 40;
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    Rectangle{
                        visible: true;
                        anchors.fill: parent;
                        Row{
                            anchors.fill: parent
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
                            simpleModelController.deleteItems(str,0,"Product");
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
                            simpleModelController.deleteItems(str,1,"Product");
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
                    radius: 8
                    anchors.rightMargin: 460
                    anchors.leftMargin: 460
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottomMargin: 150
                    anchors.topMargin: 180

                    MyButton{
                        id:accept_btn_sort
                        y: 598
                        width: 120
                        height: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 140
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
                        anchors.rightMargin: 140
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

                    ComboBox {
                        id: comboBox
                        x: 131
                        y: 119
                        width: 200
                        height: 40
                        model:["Название продукта","Цена за еденицу"]
                    }

                }
            }


            /////////////////////////////////////////////////////////////////////
        }
    }

}




















/*##^## Designer {
    D{i:11;anchors_height:40}D{i:70;anchors_width:120;anchors_x:318}D{i:71;anchors_width:120;anchors_x:318}
}
 ##^##*/
