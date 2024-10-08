/*
    Copyright 2017 Andreas Krutzler <andreas.krutzler@gmx.net>

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of
    the License or (at your option) version 3 or any later version
    accepted by the membership of KDE e.V. (or its successor approved
    by the membership of KDE e.V.), which shall act as a proxy
    defined in Section 14 of version 3 of the license.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QtControls

import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid

import org.kde.kirigami as Kirigami

// plasma pulseaudio plugin
import org.kde.plasma.private.volume

PlasmoidItem {
    id: main

    Layout.minimumWidth: gridLayout.implicitWidth
    Layout.minimumHeight: gridLayout.implicitHeight

    property bool showIcons: plasmoid.configuration.showIcons
    property bool showText: plasmoid.configuration.showText
    property bool useVerticalLayout: plasmoid.configuration.useVerticalLayout
    property bool showConfigureButton: plasmoid.configuration.showConfigureButton
    property list<string> relevantDevices: plasmoid.configuration.relevantDevices

    // from plasma-volume-control applet
    function iconNameFromPort(port, fallback) {
        if (port) {
            if (port.name.indexOf("speaker") !== -1) {
                return "audio-speakers-symbolic";
            } else if (port.name.indexOf("headphones") !== -1) {
                return "audio-headphones";
            } else if (port.name.indexOf("hdmi") !== -1) {
                return "video-television";
            } else if (port.name.indexOf("mic") !== -1) {
                return "audio-input-microphone";
            } else if (port.name.indexOf("phone") !== -1) {
                return "phone";
            }
        }
        return fallback;
    }

    function outputName(port, sink) {
        return port.description + " (" + sink.properties["device.product.name"] + ")";
    }

    PlasmaComponents.Button {
        text: "Configure"
        icon.name: "settings-configure"
        onClicked: plasmoid.internalAction("configure").trigger()
        visible: showConfigureButton
    }

    GridLayout {
        id: gridLayout
        flow: useVerticalLayout == true ? GridLayout.TopToBottom : GridLayout.LeftToRight
        anchors.fill: parent

        rowSpacing: Kirigami.Units.largeSpacing
        columnSpacing: Kirigami.Units.largeSpacing

        QtControls.ButtonGroup {
            id: buttonGroup
        }

        Repeater {
            model: SinkModel {
            }

            delegate: PlasmaComponents.Button {
                id: tab

                enabled: currentPort !== null

                visible: relevantDevices.length === 0 || relevantDevices.indexOf(currentDescription) !== -1

                text: showText ? currentDescription : ""
                icon.name: showIcons ? iconNameFromPort(currentPort, IconName) : ""

                checkable: true
                QtControls.ToolTip.text: currentDescription

                Layout.fillWidth: true
                Layout.preferredWidth: showIconsOnly ? -1 : Kirigami.Units.GridUnit * 10
                readonly property bool showIconsOnly: showIcons && !showText

                readonly property var sink: model.PulseObject
                readonly property var currentPort: model.Ports[ActivePortIndex]
                readonly property string currentDescription: currentPort ? outputName(currentPort, sink) : model.Description

                Binding {
                    target: tab
                    property: "checked"
                    value: sink.default
                }

                onClicked: {
                    sink.default = true
                }
            }
        }
    }
}
