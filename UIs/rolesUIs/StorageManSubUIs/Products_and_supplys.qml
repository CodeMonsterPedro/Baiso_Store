import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../MyUIs"

Item{
    id:addItemsPage
    width: addItemsPageCanvas.width
    height: addItemsPageCanvas.height
    property alias supplyerName: supplyerName
    Rectangle{
        id:addItemsPageCanvas
        width: Screen.width-76;
        height: Screen.height-84;

        Item{
            id:addProduct
            x:36;y:103
            width: 1131
            height: 676
            property int indexx: 10

            TextField{
                id:productPrice
                x: 24
                y: 404
                width: 340
                height: 60
                placeholderText: "Price"

            }


            TextField{
                id:companytName
                x: 24
                y: 208
                width: 858
                height: 60
                placeholderText: "Company name"

            }

            TextField{
                id:supplyerName
                x: 24
                y: 515
                width: 340
                height: 60
                placeholderText: "Supplyer id"

            }

            TextField{
                id:productName
                x: 24
                y: 118
                width: 858
                height: 60
                placeholderText: "Product name"

            }

            SpinBox {
                id: countInBox
                x: 22
                y: 319
            }

            ComboBox {
                id: comboBox
                x: 192
                y: 319
                width: 170
                height: 40
                model:["kgs","item"]
            }

            TextField {
                id: productPrice1
                x: 396
                y: 309
                width: 486
                height: 60
                placeholderText: "Bar-code"
            }

            Text {
                id: text1
                x: 24
                y: 34
                width: 401
                height: 48
                text: qsTr("New product")
                font.pixelSize: 32
            }

            MyButton{
                id: ok_obutton
                x: 772
                y: 493
                width: 116
                height: 82
                button_width: 90
                button_height: 40;
                button_text: "Add"
                button_round: 15
                button_border_color: "green"
//                onButton_clicked: {
//                    repos.setRequest("INSERT into public.\"ProductList\" (id,product_name,in_box_count,supplyer,company,price,count_sys,bar_code)
// VALUES("+ addProduct.indexx + "," + productName.text + "," + countInBox.value + "," + supplyerName.text + "," + companytName.text
//                                     + "," + productPrice.text + "," + comboBox.currentText + "," + productPrice1.text+")");
//                }
            }



        }


    }


}
