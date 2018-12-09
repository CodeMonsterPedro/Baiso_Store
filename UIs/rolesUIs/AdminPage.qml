﻿import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item{
    id:rootAdminPage
    width: rootAdminCanvas.width
    height: rootAdminCanvas.height

    Rectangle{
        id:rootAdminCanvas;
        width: Screen.desktopAvailableWidth-60
        height: Screen.desktopAvailableHeight-68
        x:30;y:40
        radius: 15
        color:"white"
    }
}