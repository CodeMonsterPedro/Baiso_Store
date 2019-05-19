import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import backend.login 1.0
import "MyUIs"


Item {
    id:rootLogInPage

    property int market_id: 0;
    property int role: 0;
    signal becomeSaleMan();
    signal becomeStorageMan();
    signal becomeAdmin();

    Rectangle{
        id:rootLogInCanvas
        anchors.fill: parent
        color:"white";

        Text{
            color:"blue"
            width:347;height:40;
            x:15;y:15;
            text:qsTr("Добро пожаловать");
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
            button_text: qsTr("Войти")
            onButton_clicked: {
                rootCanvas.my_market = rootLogInPage.market_id = backend_id.getMarket(loginfield.text,passwordfield.text);
                simpleModelController.setMyStore(rootLogInPage.market_id);
                rootCanvas.my_role = rootLogInPage.role = backend_id.sendRequest(loginfield.text,passwordfield.text);
                loginfield.text = "";
                passwordfield.text = "";
                switch(rootLogInPage.role){
                case 0:rootLogInPage.becomeAdmin();break;
                case 1:rootLogInPage.becomeSaleMan();break;
                case 2:rootLogInPage.becomeStorageMan();break;
                case 3:break;//error
                default:rootLogInPage.becomeSaleMan();break;

                }
            }

        }

        Text {
            id: element
            y: 157
            width: 100
            height: 22
            text: qsTr("Логин")
            anchors.bottom: loginfield.top
            anchors.bottomMargin: 1
            anchors.left: loginfield.left
            anchors.leftMargin: 0
            font.pixelSize: 16
        }

        Text {
            id: element1
            y: 283
            width: 100
            height: 22
            text: qsTr("Пароль")
            font.pixelSize: 16
            anchors.leftMargin: 0
            anchors.left: passwordfield.left
            anchors.bottom: passwordfield.top
            anchors.bottomMargin: 1
        }

    }
    Backend_logIn{
        id:backend_id
    }
}





/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:8;anchors_x:15}D{i:9;anchors_x:15}
}
 ##^##*/
