import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3
import "../content"


ApplicationWindow {
    visible: true
    width: 540
    height: 960
    id: mainFrame

    signal push(int i)
    signal spin_edit(int val)

    Rectangle {
        color: "#212126"
        anchors.fill: parent
    }

    //!!!------ Маэ перекривати touch listview etc
    /*SwipeArea {
          id: mouse
          anchors.fill: parent
          onMove: {
              console.log("onMove")
              //content.x = (-root.width * currentIndex) + x
          }
          onSwipe: {
              switch (direction) {
              case "left":
              {
                  console.log("left")
                  if (currentIndex === itemData.length - 1) {
                      currentIndexChanged()
                  }
                  else {
                      currentIndex++
                  }
                  break
              }
              case "right":{
                  console.log("right")
                  if (currentIndex === 0) {
                      currentIndexChanged()
                  }
                  else {
                      currentIndex--
                  }
                  break
              }
              }
          }
          onCanceled: {
              console.log("cancel")
              //currentIndexChanged()
          }
      }*/




    /*toolBar: BorderImage {

        border.bottom: 8
        source: "../images/toolbar.png"
        width: parent.width
        height: 50

        /*Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stackView.pop()
            }
        }*/

        /*Text {
            font.pixelSize: 42
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            //x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "Prayer"
        }
    }*/

        //------TABS
        TabView {
            id: tabView
            anchors.fill: parent
            style: touchStyle




            //-------OPTIONS TAB
            Tab {
                title: "Buttons"
                ButtonPage{ visible: true }
            }
            //-------PRAYER TAB
            Tab {
                id: prayer_tab
                title: "Sliders"

                Item {
                    width: parent.width
                    height: parent.height

                    property real progress: 0
                    SequentialAnimation on progress {
                        loops: Animation.Infinite
                        running: true
                        NumberAnimation {
                            from: 0
                            to: 1
                            duration: 3000
                        }
                        NumberAnimation {
                            from: 1
                            to: 0
                            duration: 3000
                        }
                    }

                    // Spin Style
                    Component {
                        id: spinStyle

                        SpinBoxStyle {
                            textColor: "white"
                            font.pixelSize: 28
                            background: Item {
                                //implicitHeight: 50
                                //implicitWidth: 320
                                BorderImage {
                                    source: "../images/textinput.png"
                                    border.left: 8
                                    border.right: 8
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                }
                            }
                        }
                    }

                    SpinBox{
                        id: circles
                        width: push1.width/2-10
                        height: 80
                        anchors.top: push5.bottom
                        anchors.left: push5.left
                        anchors.leftMargin: 5
                        anchors.topMargin: 10
                        value: (days.value/20)
                        enabled: false
                        style: spinStyle

                        onEditingFinished: {
                        }
                    }

                    SpinBox{
                        id: days
                        width: push1.width/2-10
                        height: 80
                        anchors.top: push20.bottom
                        anchors.left: circles.right
                        anchors.leftMargin: 10
                        anchors.topMargin: 10
                        value: spin_value
                        maximumValue: 10000
                        style: spinStyle
                        focus: false

                        onEditingFinished: {
                            spin_edit(days.value)
                        }
                    }

                        Button {
                            id: push1
                            width: tabView.width-10
                            height: 180
                            x: 5
                            y: 10
                            //anchors.top: mainFrame.toolBar.bottom
                            //anchors.left: mainFrame.toolBar.left
                            //anchors.leftMargin: 5
                            //anchors.topMargin: 5
                            text: "+1 Pray"
                            style: touchStyle
                            onClicked: {
                                mainFrame.push(1);
                            }
                        }

                        Button {
                            id: push5
                            width: (push1.width/2)-5
                            height: 80
                            anchors.top: push1.bottom
                            anchors.left: push1.left
                            anchors.topMargin: 10
                            text: "+5 Pray"
                            style: touchStyle
                            onClicked: {
                                mainFrame.push(5);
                            }
                        }

                        Button {
                            anchors.margins: 20
                            id: push20
                            width: (push1.width/2)-5
                            height: 80
                            anchors.top: push1.bottom
                            anchors.left: push5.right
                            anchors.leftMargin: 10
                            anchors.topMargin: 10
                            text: "+20 Pray"
                            style: touchStyle
                            onClicked: {
                                mainFrame.push(20);
                            }
                            //!------ HOW BACK IN STACK VIEW !!!!
                            //onClicked: if (stackView) stackView.pop()
                        }


                    // Button Style
                    Component {
                        id: touchStyle
                        ButtonStyle {
                            panel: Item {
                                implicitHeight: 50
                                implicitWidth: 320
                                BorderImage {
                                    anchors.fill: parent
                                    antialiasing: true
                                    border.bottom: 8
                                    border.top: 8
                                    border.left: 8
                                    border.right: 8
                                    anchors.margins: control.pressed ? -4 : 0
                                    source: control.pressed ? "../images/button_pressed.png" : "../images/button_default.png"
                                    Text {
                                        text: control.text
                                        anchors.centerIn: parent
                                        color: "white"
                                        font.pixelSize: 23
                                        renderType: Text.NativeRendering
                                    }
                                }
                            }
                        }
                    }

                    ScrollView {
                        width: parent.width
                        anchors.top: circles.bottom
                        height: parent.height-circles.height-days.height-push1.height

                        flickableItem.interactive: true

                        ListView {
                            anchors.fill: parent
                            model: praysModel
                            delegate: AndroidDelegate {
                                text: '<b>Day:</b> ' + day + '<b> Count:</b> ' + count
                            }
                        }

                        style: ScrollViewStyle {
                            transientScrollBars: true
                            handle: Item {
                                implicitWidth: 14
                                implicitHeight: 26
                                Rectangle {
                                    color: "#424246"
                                    anchors.fill: parent
                                    anchors.topMargin: 6
                                    anchors.leftMargin: 4
                                    anchors.rightMargin: 4
                                    anchors.bottomMargin: 6
                                }
                            }
                            scrollBarBackground: Item {
                                implicitWidth: 14
                                implicitHeight: 26
                            }
                        }
                    }
                }
            }

            //-------STATISTIC TAB
            Tab {
                title: "Progress"
                Item{
                    anchors.fill: parent
                    StackView {
                        id: stackView
                        anchors.fill: parent
                        // Implements back key navigation
                        focus: true
                        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                                             stackView.pop();
                                             event.accepted = true;
                                         }

                        initialItem: Item {
                            width: parent.width
                            height: parent.height
                            ListView {
                                model: pageModel
                                anchors.fill: parent
                                delegate: AndroidDelegate {
                                    text: title
                                    onClicked: stackView.push(Qt.resolvedUrl(page))
                                }
                            }
                        }
                    }

                    ListModel {
                        id: pageModel
                        ListElement {
                            title: "Buttons"
                            page: "../content/ButtonPage.qml"
                        }
                        ListElement {
                            title: "Sliders"
                            page: "../content/SliderPage.qml"
                        }
                        ListElement {
                            title: "ProgressBar"
                            page: "../content/ProgressBarPage.qml"
                        }
                        ListElement {
                            title: "Tabs"
                            page: "../content/TabBarPage.qml"
                        }
                        ListElement {
                            title: "TextInput"
                            page: "../content/TextInputPage.qml"
                        }
                        ListElement {
                            title: "List"
                            page: "../content/ListPage.qml"
                        }
                    }
                }
            }
        }

        Component {
            id: touchStyle
            TabViewStyle {
                tabsAlignment: Qt.AlignVCenter
                tabOverlap: 0
                frame: Item { }
                tab: Item {
                    implicitWidth: control.width/control.count
                    implicitHeight: 80
                    BorderImage {
                        anchors.fill: parent
                        border.bottom: 8
                        border.top: 8
                        source: styleData.selected ? "../images/tab_selected.png":"../images/tabs_standard.png"
                        Text {
                            anchors.centerIn: parent
                            color: "white"
                            text: styleData.title.toUpperCase()
                            font.pixelSize: 16
                        }
                        Rectangle {
                            visible: index > 0
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.margins: 10
                            width:1
                            color: "#3a3a3a"
                        }
                    }
                }
            }
        }


    /*

    Component {
          id: prayerDelegate
          Rectangle {
              id: wrapper

              height: 55
              //color: ListView.isCurrentItem ? "black" : "red"
              Column {
              Text {
                  id: contactInfo
                   text: '<b>Day:</b> ' + day + '<b> Count:</b> ' + count
                   //color: wrapper.ListView.isCurrentItem ? "red" : "black"
              }
              }
          }
      }

        ListView {
           //TableViewColumn{ role: "day"  ; title: "Day" ; width: 100 }
           //TableViewColumn{ role: "count" ; title: "Count" ; width: 200 }
           //delegate: prayerDelegate
           //delegate: Text{ text: " day " + day + " count " + count }
           delegate: prayerDelegate
           anchors.top: circles.bottom
           anchors.left: parent.left
           anchors.leftMargin: 10
           anchors.topMargin: 20
           width: parent.width
           height: 500
           model: praysModel
           focus: true
        }
        */
}
