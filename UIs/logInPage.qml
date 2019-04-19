import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import backend.login 1.0
import "MyUIs"


Item {
    id:rootLogInPage

    signal becomeSaleMan();
    signal becomeStorageMan();
    signal becomeAdmin();

    Rectangle{
        id:rootLogInCanvas
        anchors.fill: parent
        color:"white";

        Text{
            color:"blue"
            width:100;height:40;
            x:15;y:15;
            text:qsTr("Welcome ;)");
            font.pixelSize: 25;
        }

        TextInput{
            id:loginfield
            width: rootLogInPage.width-30;height: 30;
            x:15;y:(rootLogInCanvas.height/2)-60;
            font.pixelSize: 20;
        }
        Rectangle{
            width: loginfield.width;height: 1;
            x:loginfield.x;y:loginfield.y+31;
            color:"blue"
        }

        TextInput{
            id:passwordfield
            width: rootLogInPage.width-30;height: 30;
            x:15;y:(rootLogInCanvas.height/2)+60;
            font.pixelSize: 20;
            echoMode: TextInput.Password;
        }
        Rectangle{
            width: passwordfield.width;height: 1;
            x:passwordfield.x;y:passwordfield.y+31;
            color:"blue"
        }

        MyButton{
            id:loginSubmit
            width:160;height: 60;
            x: (rootLogInCanvas.width/2)-loginSubmit.width/2;
            y: (rootLogInCanvas.height/4)*3;
            button_text_color: "blue"
            button_border_color: "blue"
            button_round: 25;
            button_text: qsTr("Log in");
            onButton_clicked: {
                switch(backend_id.sendRequest(loginfield.text,passwordfield.text)){
                case 0:rootLogInPage.becomeAdmin();break;
                case 1:rootLogInPage.becomeSaleMan();break;
                case 2:rootLogInPage.becomeStorageMan();break;
                default:rootLogInPage.becomeSaleMan();break;


                }
            }

        }

    }
    Backend_logIn{
        id:backend_id
    }
}
