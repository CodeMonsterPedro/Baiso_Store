import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    id:addItemsPage
    width: addItemsPageCanvas.width
    height: addItemsPageCanvas.height
    Rectangle{
        id:addItemsPageCanvas
        width: Screen.desktopAvailableWidth-76;
        height: Screen.desktopAvailableHeight-84;

        Item{
            id:addProduct
            x:30;y:30
            Column{
                spacing: 30;
                TextField{
                    id:productName
                    width: 200
                    height: 60

                }
                TextField{
                    id:companytName
                    width: 200
                    height: 60

                }
                TextField{
                    id:inBoxCount
                    width: 200
                    height: 60

                }
                TextField{
                    id:supplyerName
                    width: 200
                    height: 60

                }
                TextField{
                    id:productPrice
                    width: 200
                    height: 60

                }
            }
        }


    }


}
