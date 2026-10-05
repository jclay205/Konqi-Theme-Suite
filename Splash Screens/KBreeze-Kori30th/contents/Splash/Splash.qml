/*
 *   SPDX-FileCopyrightText: 2014 Marco Martin <mart@kde.org>
 *   SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick 2.15
import org.kde.kirigami as Kirigami

Rectangle {
    id: root
    color: "black"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        // Main horizontal arrangement container (Konqi Left | Line | Plasma Right)
        Row {
            id: mainRow
            anchors.centerIn: parent
            spacing: Kirigami.Units.gridUnit * 4

            // Left: 30th Anniversary Kori & Gear Mascot Image container
            Item {
                width: Kirigami.Units.gridUnit * 12
                height: Kirigami.Units.gridUnit * 10
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: korilogo
                    anchors.centerIn: parent
                    asynchronous: true
                    source: "images/Mascot-kori-kde30logo-30-gear.png"
                    fillMode: Image.PreserveAspectFit
                    sourceSize.width: Kirigami.Units.gridUnit * 10
                    sourceSize.height: Kirigami.Units.gridUnit * 10
                }
            }

            // Middle: Vertical Divider Line
            Rectangle {
                width: 2
                height: Kirigami.Units.gridUnit * 8
                anchors.verticalCenter: parent.verticalCenter
                color: "#4d4d4d"
            }

            // Right: Plasma Logo container
            Item {
                width: Kirigami.Units.gridUnit * 10
                height: Kirigami.Units.gridUnit * 10
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: plasmaLogo
                    anchors.centerIn: parent
                    asynchronous: true
                    source: "images/plasma.svgz"
                    sourceSize.width: Kirigami.Units.gridUnit * 8
                    sourceSize.height: Kirigami.Units.gridUnit * 8
                }
            }
        }

        Image {
            id: busyIndicator
            anchors.top: mainRow.bottom
            anchors.topMargin: Kirigami.Units.gridUnit * 2
            anchors.horizontalCenter: mainRow.horizontalCenter
            anchors.horizontalCenterOffset: +10
            asynchronous: true
            source: "images/busywidget.svgz"
            sourceSize.height: Kirigami.Units.gridUnit * 2
            sourceSize.width: Kirigami.Units.gridUnit * 2
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
                running: Kirigami.Units.longDuration > 1
            }
        }

        Row {
            spacing: Kirigami.Units.largeSpacing
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: Kirigami.Units.gridUnit
            }
            Text {
                color: "#eff0f1"
                anchors.verticalCenter: parent.verticalCenter
                text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "This is the first text the user sees while starting in the splash screen, should be translated as something short, is a form that can be seen on a product. Plasma is the project name so shouldn't be translated.", "Plasma made by KDE")
                Accessible.name: text
                Accessible.role: Accessible.StaticText
                textFormat: Text.PlainText
            }
            Image {
                asynchronous: true
                source: "images/kde.svgz"
                sourceSize.height: Kirigami.Units.gridUnit * 2
                sourceSize.width: Kirigami.Units.gridUnit * 2
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: Kirigami.Units.veryLongDuration * 2
        easing.type: Easing.InOutQuad
    }
}