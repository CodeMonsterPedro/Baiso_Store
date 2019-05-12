import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"

Item{
    id:bigsalePage
    property string pName: ""
    property string pBarCode: ""
    property int pCount: 0
    width: rootbigsaleCanvas.width
    height: rootbigsaleCanvas.height;

    Rectangle {
        id: rootbigsaleCanvas
        width: Screen.width-76
        height: Screen.height-28

        Text {
            id: text1
            x: 18
            y: 0
            width: 636
            height: 50
            color: "#0000ff"
            text: qsTr("Расчетные квитанции")
            font.pixelSize: 43
        }

        Rectangle {
            id: bigsaleListItem
            color: "#d3d3d3"
            anchors.topMargin: 60
            anchors.fill: parent

            Rectangle {
                visible: true
                id: rectangle4
                x: 1424
                width: 123
                height: 132
                color: "#ffffff"
                radius: 15
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.right: parent.right
                anchors.rightMargin: -15

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
                    onButton_clicked: bigSale_element_add.visible=true;
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
            }

            Rectangle {
                id: bigsaleListBackground
                color: "#ffffff"
                anchors.rightMargin: -400
                anchors.left: parent.horizontalCenter
                anchors.right: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.leftMargin: -400
                anchors.bottomMargin: 30
                anchors.topMargin: 30
                anchors.top: parent.top
                border.color: "gray"
                border.width: 2

                ListView {
                    property int counter: 0;
                    id: bigsaleList
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                    anchors.topMargin: 10
                    anchors.fill: parent
                    spacing: 25
                    cacheBuffer: 500000;
                    clip: true;
                    model: counter, simpleModelController.myModel;
                    delegate:bigsaleDelegate;
                    Connections {
                        target: simpleModelController
                        onMyModelChanged:{
                            bigsaleList.counter++
                        }
                    }
                }
            }


            Component{
                id:bigsaleDelegate
                Item{
                    id:bigsaleDelegateItem
                    property bool isOpen: false;
                    width: bigsaleList.width
                    height: bigsaleDelegateItem.isOpen? rectangle.height+20 : 60;
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    Rectangle{
                        id: rectangle1
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 15;
                        height: bigsaleDelegateItem.isOpen? rectangle.height+20 : 60;
                        color:"#e7e2e2"
                        border.width: 2
                        border.color: "blue"
                        Rectangle {
                            id: rectangle
                            color: "lightgray"
                            height: m_BRows * 50;
                            visible: bigsaleDelegateItem.isOpen;
                            anchors.rightMargin: 2
                            anchors.leftMargin: 2
                            anchors.topMargin: 60
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            Text {
                                x: 15
                                width: 300
                                text: "" +  m_Name
                                anchors.top: parent.top
                                anchors.topMargin: 0
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                font.pointSize: 18
                                anchors.leftMargin: 0
                                anchors.left: parent.left
                            }
                            Text {
                                x: 18
                                width: 110
                                text: "" + m_ProductCount;
                                anchors.top: parent.top
                                anchors.topMargin: 0
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                font.pointSize: 14
                                anchors.leftMargin: 310
                                anchors.left: parent.left
                            }
                            Text {
                                x: 15
                                width: 110
                                text: "" + m_Price;
                                anchors.top: parent.top
                                anchors.topMargin: 0
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 0
                                font.pointSize: 16
                                anchors.leftMargin: 488
                                anchors.left: parent.left
                            }
                        }
                        Text{
                            x:25;
                            y: 15
                            text: "id:" +  m_MainId;
                            font.pointSize: 16
                            anchors.leftMargin: 0
                            anchors.left: parent.left;
                        }

                        Text {
                            x: 240
                            y: 8
                            width: 152
                            height: 46
                            text: qsTr("" + m_Date)
                            font.pixelSize: 16
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.rightMargin: 40
                            anchors.fill: parent
                            onClicked:{
                                bigsaleDelegateItem.isOpen = !bigsaleDelegateItem.isOpen;
                            }
                        }
                        Button{
                            width: 40
                            height: 30
                            text: "Изменить"
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            onClicked:{
                                simpleModelController.setCurrentBigSale(m_MainId);
                            }
                        }
                        CheckBox{
                            height: 30
                            visible: false
                            anchors.right: parent.right
                            anchors.rightMargin: 0
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0

                        }
                        MyButton{
                            id:printBtn
                            button_height: 50
                            button_width: 50;
                            width: 50;
                            height: 50;
                            visible: true
                            x:700
                            y:30;
                            button_image_source: "print.png"
                            onButton_clicked: simpleModelController.printBigSale(m_MainId);
                        }

                    }
                }
            }

            Item{
                property int pId: 0;
                property string dateStr: "";
                property variant pNames: [];
                property variant pCount: [];
                id: element_chag
                anchors.fill: parent
                visible: true
                Rectangle {
                    id: rectangle_chag
                    color: "#090808"
                    opacity: 0.5
                    anchors.fill: parent
                }

                Rectangle {
                    id: rectangle_element_chag
                    height: 780
                    width: 700
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 3
                    visible: true
                    anchors.centerIn: rectangle_chag;

                    ListView{
                        property bool counter: false;
                        anchors.bottomMargin: 120
                        id:listViewSaleDetails
                        anchors.topMargin: 0
                        anchors.fill: parent
                        contentHeight: 10
                        contentWidth: 10
                        spacing: 8;
                        clip: true
                        model:listViewSaleDetails.counter, element_chag.pNames;
                        delegate: Item{
                            width: listViewSaleDetails.width
                            height: 40;
                            Row{
                                visible: true
                                anchors.fill: parent
                                Rectangle{
                                    width: listViewSaleDetails.width/2;
                                    height: 40;
                                    border.color: "black"
                                    border.width: 2;
                                    Text{
                                        text: "" +  element_chag.pNames[index];
                                        anchors.centerIn: parent;
                                        font.pointSize: 14
                                    }
                                }
                                Rectangle{
                                    width: listViewSaleDetails.width/2;
                                    height: 40;
                                    border.color: "black"
                                    border.width: 2;
                                    SpinBox{
                                        id:spin
                                        width: 200;
                                        value: element_chag.pCount[index];
                                        from:1
                                        to:20000;
                                        anchors.centerIn: parent;
                                        font.pointSize: 14
                                        onValueChanged: {
                                            if(simpleModelController.isCorrectCount(element_chag.pNames[index],spin.value))element_chag.pCount[index] = spin.value;
                                            else {
                                                spin.to = spin.value;
                                                spin.value = element_chag.pCount[index];
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        header: Item{
                            height: 50;
                            Row{
                                anchors.fill: parent
                                Rectangle{
                                    width: listViewSaleDetails.width/2;
                                    height: 40
                                    Text{
                                        anchors.centerIn: parent;
                                        text: "Название продукта";
                                        font.pointSize: 14
                                    }
                                }
                                Rectangle{
                                    width: listViewSaleDetails.width/2;
                                    height: 40
                                    Text {
                                        anchors.centerIn: parent;
                                        text: "Кол-во проданого"
                                        font.pointSize: 14
                                    }
                                }
                            }
                        }
                        headerPositioning: ListView.OverlayHeader
                    }



                    MyButton{
                        property variant resultL: [];
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
                            for(var i=0;i<element_chag.pNames.length;i++){
                                accept_btn_chag.resultL.push("" + element_chag.pNames + " " + element_chag.pCount)
                            }
                            simpleModelController.updateFullPurchase(element_chag.pId,accept_btn_chag.resultL);
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
                }
            }


            Item{
                id: bigSale_element_add
                property var newBigSaleList: []
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
                    anchors.bottomMargin: 50
                    anchors.topMargin: 50
                    MyButton{
                        id:accept_btn
                        y: 598
                        width: 120
                        height: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 190
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 40
                        button_border_color: "blue"
                        button_text_color: "blue"
                        button_text: "Добавить"
                        button_round: 15
                        onButton_clicked:{
                            simpleModelController.addNewFullPurchaseToRep(" ", bigSale_element_add.newBigSaleList);
                            simpleModelController.refreshProducts();
                            bigSale_element_add.visible = false;
                            textField_ProductName.text = "";
                            textField_Count.text = "";
                            bigSale_element_add.newBigSaleList = [];
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
                        anchors.bottomMargin: 40
                        button_border_color: "red"
                        button_text_color: "red"
                        button_text: "Отмена"
                        button_round: 15
                        onButton_clicked: {
                            simpleModelController.refreshProducts();
                            bigSale_element_add.visible = false;
                            textField_ProductName.text = "";
                            textField_Count.text = "";
                            bigSale_element_add.newBigSaleList = [];
                        }
                    }
                    Rectangle {
                        id: rectangle1
                        property bool counter: false;
                        border.width: 2
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 90
                        visible: true
                        anchors.right: parent.right
                        anchors.leftMargin: 28

                        Row {
                            id: element_add_row
                            height: 40
                            spacing: 5
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 1
                            anchors.left: parent.left
                            anchors.leftMargin: 2
                            anchors.right: parent.right
                            anchors.rightMargin: 1

                            ComboBox{
                                property bool updater: true
                                id: textField_ProductName
                                width: 251
                                height: 40
                                model:updater, simpleModelController.productNames;

                            }
                            TextField {
                                id: textField_Count
                                width: 118
                                height: 40
                                text: qsTr("")
                                placeholderText: "Кол-во проданного"
                            }
                            MyButton {
                                width: 40
                                height: 40
                                button_image_source: qsTr("")
                                visible: true
                                button_height: 40
                                button_width: 40
                                button_text_color: "#0000ff"
                                button_text: "+"
                                button_border_color: "#0000ff"
                                button_round: 3
                                onButton_clicked: {
                                    if(simpleModelController.isCorrectCount(textField_ProductName.currentText, parseInt(textField_Count.text,10))){
                                        simpleModelController.useProduct(textField_ProductName.currentText);
                                        bigSale_element_add.newBigSaleList.push("" + textField_ProductName.currentText + " " + textField_Count.text);
                                        textField_Count.text = "";
                                        rectangle1.counter = !rectangle1.counter;
                                        textField_ProductName.updater = !textField_ProductName.updater;
                                    }else{
                                        textField_Count.text = "";
                                    }
                                }
                            }
                        }

                        ListView {
                            id: bigSaleItemsList
                            anchors.bottomMargin: 42
                            anchors.fill: parent
                            model:rectangle1.counter, bigSale_element_add.newBigSaleList;
                            clip: true;
                            delegate: Item {
                                height: 50
                                anchors.left: parent.left
                                anchors.right: parent.right
                                Text {
                                    anchors.fill: parent
                                    text: qsTr("" + modelData);
                                }
                            }
                            headerPositioning: ListView.OverlayHeader
                            header: Item {
                                height: 50
                                anchors.left: parent.left
                                anchors.right: parent.right
                                Text {
                                    anchors.centerIn: parent
                                    font.pixelSize: 12
                                    text: qsTr("Товар                Кол-во проданного           Цена");
                                }
                            }
                        }
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.topMargin: 70
                        anchors.rightMargin: 37
                    }
                    Text {
                        id: element1
                        x: 28
                        y: 18
                        width: 129
                        height: 40
                        text: qsTr("Добавить")
                        font.pixelSize: 26
                    }
                }
            }
                Connections{
                    target: simpleModelController
                    onProductNamesChanged:{
                         textField_ProductName.updater = !textField_ProductName.updater;
                    }
                    onCurrentBigSaleSetted:{
                        element_chag.pNames = [];
                        element_chag.pCount = [];
                        for(var i=0;i<simpleModelController.bigSaleProducts.length;i++){
                            element_chag.pNames.push(simpleModelController.bigSaleProducts[i]);
                            element_chag.pCount.push(simpleModelController.bigSaleCount[i]);
                        }
                        listViewSaleDetails.counter = !listViewSaleDetails.counter;
                        element_chag.visible = true;
                    }
                }
        }
    }
}












/*##^## Designer {
    D{i:30;anchors_width:659}D{i:34;anchors_height:40;anchors_width:120;anchors_y:598}
D{i:29;anchors_height:387}
}
 ##^##*/
