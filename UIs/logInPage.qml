import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import backend.login 1.0


Item {
    id:rootLogInPage
    Rectangle{
        id:rootLogInCanvas
        anchors.fill: parent
        color:"white";

        Text{
            color:"green"
            width:100;height:40;
            x:15;y:15;
            text:qsTr("Welcome ;)");
            font.pixelSize: 25;
        }

        TextInput{
            id:loginfield
            width: rootLogInPage.width-30;height: 30;
            x:15;y:(rootLogInCanvas.height/2)-60;
        }
        Rectangle{
            width: loginfield.width;height: 1;
            x:loginfield.x;y:loginfield.y+31;
            color:"green"
        }

        TextInput{
            id:passwordfield
            width: rootLogInPage.width-30;height: 30;
            x:15;y:(rootLogInCanvas.height/2)+60;
            echoMode: TextInput.Password;
        }
        Rectangle{
            width: passwordfield.width;height: 1;
            x:passwordfield.x;y:passwordfield.y+31;
            color:"green"
        }

        MyButton{
            id:loginSubmit
            width:160;height: 60;
            x: (rootLogInCanvas.width/2)-loginSubmit.width/2;
            y: (rootLogInCanvas.height/4)*3;
            button_text_color: "green"
            button_border_color: "green"
            button_round: 25;
            button_text: qsTr("Log in");
            onButton_clicked: {
                switch(backend_id.sendRequest(loginfield.text,passwordfield.text)){
                case 0://admin
                case 1://sklad
                case 2://manager
                default://error


                }
            }

        }

    }
    Backend_logIn{
        id:backend_id
    }
}
