import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    id:addItemsPage
    width: addItemsPageCanvas.width
    height: addItemsPageCanvas.height
    property alias supplyerName: supplyerName
    Rectangle{
        id:addItemsPageCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;

        Item{
            id:addProduct
            x:36;y:103
            width: 1131
            height: 676

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




        }


    }


}
