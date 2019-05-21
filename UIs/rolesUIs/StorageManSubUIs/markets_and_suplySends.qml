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
                width: 180
                height: 132
                color: "#ffffff"
                radius: 8
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.right: parent.right
                anchors.rightMargin: -15

                MyButton{
                    id:addbutton_2
                    x: 13
                    y: 13
                    width: 120
                    height: 40
                    button_round: 15
                    button_text: "Добавить"
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
                    width: 120
                    height: 40
                    button_round: 15
                    button_text: "Удалить"
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
                    property var deleteList: [];
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
                    height: 240
                    width: 700
                    color: "#ffffff"
                    border.color:"blue"
                    radius: 8
                    anchors.centerIn: rectangle_del;

                    MyButton{
                        id:accept_btn_del
                        y: 598
                        width: 120
                        height: 40
                        anchors.left: parent.left
                        anchors.leftMargin: 100
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 60
                        button_border_color: "blue"
                        button_text_color: "blue"
                        button_text: "Удалить"
                        button_round: 15
                        onButton_clicked:{
                            element_del.visible = false;
                            var str = "";
                            for(var i=0;i<bigsaleList.deleteList.length;i++){
                                str+= "" + bigsaleList.deleteList[i].toString() + "|";
                            }
                            simpleModelController.deleteItems(str,0,"Sale");
                            bigsaleList.deleteList = [];

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
                        anchors.bottomMargin: 60
                        button_border_color: "red"
                        button_text_color: "red"
                        button_text: "Отмена"
                        button_round: 15
                        onButton_clicked: {
                            element_del.visible = false;

                        }
                    }

                    Text {
                        id: element
                        x: 115
                        y: 86
                        width: 440
                        height: 43
                        text: qsTr("Удалить выбранные элементы?")
                        anchors.verticalCenterOffset: -40
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 28
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
                            height: m_BRows * 40;
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
                            x:45;
                            y: 30
                            text: "id:" +  m_MainId;
                            font.pointSize: 16
                        }

                        Text {
                            x: 238
                            y: 16
                            width: 293
                            height: 28
                            text: m_Date;
                            anchors.bottom: printBtn.bottom
                            anchors.bottomMargin: 50
                            anchors.right: printBtn.left
                            anchors.rightMargin: 20
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
                        MyButton{
                            x:650
                            y:12
                            button_text: "Изменить"
                            button_height:34
                            button_width: 100;
                            button_border_color: "blue"
                            button_round: 15
                            visible: true
                            width: 100
                            height: 34
                            onButton_clicked:{
                                simpleModelController.setCurrentBigSale(m_MainId);
                            }
                        }
                        CheckBox{
                            x:2;
                            y: 2
                            height: 30
                            visible: true
                            onCheckedChanged: {bigsaleList.deleteList.push(m_MainId);}
                        }
                        MyButton{
                            id:printBtn
                            x:599
                            y:4
                            button_height: 50
                            button_width: 50;
                            button_border_color: "blue"
                            button_image_width:40;
                            button_image_height: 40;
                            button_round: 15
                            visible: true
                            width: 50
                            height: 50
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
                visible: false
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
                                            if(simpleModelController.isCorrectCount(element_chag.pNames[index],spin.value)){

                                                element_chag.pCount[index] = spin.value;
                                            }
                                            else {
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
                property variant newBigSaleNameList: []
                property variant newBigSaleCountList: []
                property variant newBigSaleList: []
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
                    radius: 8
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
                            textField_Count.value = 1;
                            bigSale_element_add.newBigSaleNameList=[];
                            bigSale_element_add.newBigSaleCountList=[];
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
                            textField_Count.value = 1;
                            bigSale_element_add.newBigSaleNameList=[];
                            bigSale_element_add.newBigSaleCountList=[];
                            bigSale_element_add.newBigSaleList = [];
                        }
                    }
                    Rectangle {
                        id: rectangle1
                        property bool counter: false;
                        border.color: "lightgray"
                        border.width: 1
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 90
                        visible: true
                        anchors.right: parent.right
                        anchors.leftMargin: 28

                        Row {
                            id: element_add_row
                            height: 40
                            anchors.top: parent.top
                            anchors.topMargin: 0
                            spacing: 5
                            anchors.left: parent.left
                            anchors.leftMargin: 2
                            anchors.right: parent.right
                            anchors.rightMargin: 1

                            TextField{
                                property bool updater: false
                                id: textField_ProductName
                                width: 351
                                height: 40
                                text: ""
                                onTextChanged: {
                                    if(textField_ProductName.text.length>=1){
                                        simpleModelController.search(textField_ProductName.text);
                                        searchList.visible = true;
                                    }
                                    else{
                                        simpleModelController.resetProductSearch();
                                        searchList.visible = false;
                                    }
                                }
                            }
                            SpinBox{
                                id: textField_Count
                                width: 170
                                height: 40
                                value: 1;
                                from:1
                                to:20000
                            }
                            MyButton {
                                width: 110
                                height: 40
                                visible: true
                                button_height: 40
                                button_width: 170
                                button_text_color: "#0000ff"
                                button_text: "Внести"
                                button_border_color: "#0000ff"
                                button_round: 3
                                onButton_clicked: {
                                    if(simpleModelController.isCorrectCount(textField_ProductName.text, parseInt(textField_Count.value,10))){
                                        bigSale_element_add.newBigSaleList.push("" + textField_ProductName.text + "|" + textField_Count.value);
                                        bigSale_element_add.newBigSaleNameList.push("" + textField_ProductName.text);
                                        bigSale_element_add.newBigSaleCountList.push("" + textField_Count.value);
                                        textField_Count.value = 1;
                                        simpleModelController.useProduct(textField_ProductName.text);
                                        rectangle1.counter = !rectangle1.counter;
                                        textField_ProductName.updater = !textField_ProductName.updater;
                                    }else{
                                        textField_Count.value = 1;
                                    }
                                }
                            }
                        }

                        ListView {
                            id: bigSaleItemsList
                            anchors.topMargin: 42
                            anchors.bottomMargin: 0
                            anchors.fill: parent
                            model:rectangle1.counter, bigSale_element_add.newBigSaleNameList;
                            clip: true;
                            delegate: Item {
                                height: 50
                                anchors.left: parent.left
                                anchors.right: parent.right
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: bigSaleItemsList.width/2
                                        height: 50
                                        border.color: "black"
                                        border.width: 2;
                                        Text{
                                            anchors.centerIn: parent;
                                            text: "" +  bigSale_element_add.newBigSaleNameList[index];
                                            font.pointSize: 14
                                        }
                                    }
                                    Rectangle{
                                        width: bigSaleItemsList.width/2
                                        height: 50
                                        border.color: "black"
                                        border.width: 2;
                                        SpinBox {
                                            anchors.centerIn: parent;
                                            value: parseInt(bigSale_element_add.newBigSaleCountList[index],10);
                                            from: 1
                                            to:simpleModelController.getProductMaxValue(bigSale_element_add.newBigSaleNameList[index]);
                                            font.pointSize: 14
                                            onValueChanged: {
                                                bigSale_element_add.newBigSaleCountList[index] = value;
                                            }
                                        }
                                    }
                                }
                            }
                            headerPositioning: ListView.OverlayHeader
                            header: Item {
                                height: 50
                                anchors.left: parent.left
                                anchors.right: parent.right
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: bigSaleItemsList.width/2
                                        height: 50
                                        Text{
                                            anchors.centerIn: parent;
                                            text: "Товар";
                                            font.pointSize: 14
                                        }
                                    }
                                    Rectangle{
                                        width: bigSaleItemsList.width/2
                                        height: 50
                                        Text {
                                            anchors.centerIn: parent;
                                            text: "Кол-во"
                                            font.pointSize: 14
                                        }
                                    }
                                }
                            }
                        }

                        ListView {
                            id: searchList
                            visible: false
                            property bool counter: false;
                            x: 353
                            y: 40
                            height: simpleModelController.productSearch.length > 10? 400 : simpleModelController.productSearch.length*40;
                            anchors.top: element_add_row.bottom
                            anchors.topMargin: 0
                            anchors.left: element_add_row.left
                            anchors.leftMargin: 0
                            anchors.right: element_add_row.right
                            anchors.rightMargin: 610
                            model:counter, simpleModelController.productSearch

                            delegate: Item {
                                width: searchList.width
                                height: 40
                                Rectangle{
                                    anchors.fill: parent
                                    Text {
                                        anchors.fill: parent
                                        text: qsTr("" + simpleModelController.productSearch[index])
                                        font.pixelSize: 14;
                                    }
                                }
                                MouseArea{
                                    anchors.fill:parent
                                    onClicked:{
                                        searchList.visible = false;
                                        textField_ProductName.text = simpleModelController.productSearch[index];
                                        textField_Count.to = simpleModelController.getProductMaxValue(textField_ProductName.text);
                                    }
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
                onProductSearchChanged:{
                    searchList.counter = !searchList.counter;
                }
            }
        }
    }
}



















































































/*##^## Designer {
    D{i:30;anchors_width:659}D{i:34;anchors_height:40;anchors_width:120;anchors_y:598}
D{i:29;anchors_height:387}D{i:70;anchors_width:110;anchors_x:353;anchors_y:40}
}
 ##^##*/
