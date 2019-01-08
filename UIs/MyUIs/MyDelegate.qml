import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {

    property int Canvas_width: 200;
    property int Canvas_height: 40;
    property color Canvas_color: "grey";
    property string main_value: "";


    anchors.fill: delegateCanvas;

    Rectangle{
        id:delegateCanvas

    }

    MouseArea{
        id:delegateArea
        anchors.fill: delegateCanvas;
    }
}
