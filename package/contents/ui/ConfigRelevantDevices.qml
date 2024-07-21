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
import QtQuick.Controls
import org.kde.kirigami as Kirigami

// plasma pulseaudio plugin
import org.kde.plasma.private.volume

Item {
    id: page
    property list<string> relevantDevices: plasmoid.configuration.relevantDevices
    property alias cfg_relevantDevices: page.relevantDevices

    function outputName(port, sink) {
        return port.description + " (" + sink.properties["device.product.name"] + ")";
    }


    Kirigami.FormLayout {
        anchors.fill: parent
        ListView {
            id: relevantDevicesListView
            model: SinkModel {
            }
            anchors.fill: parent
            delegate: CheckBox {
                id: sinkCb
                text: currentDescription

                readonly property var sink: model.PulseObject
                readonly property var currentPort: model.Ports[ActivePortIndex]
                readonly property string currentDescription: currentPort ? outputName(currentPort, sink) : model.Description

                Binding {
                    target: sinkCb
                    property: "checked"
                    value: relevantDevices.indexOf(currentDescription) !== -1
                }

                onClicked: {
                    if (this.checked) {
                        relevantDevices.push(currentDescription);
                    } else {
                        relevantDevices.splice(relevantDevices.indexOf(currentDescription), 1);
                    }
                }
            }
        }
    }
}