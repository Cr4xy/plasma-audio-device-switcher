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

import org.kde.plasma.configuration

ConfigModel {
    ConfigCategory {
         name: i18n("General")
         icon: "preferences-desktop-plasma"
         source: "ConfigGeneral.qml"
    }
    ConfigCategory {
         name: i18n("Relevant devices")
         icon: "audio-card"
         source: "ConfigRelevantDevices.qml"
    }
}