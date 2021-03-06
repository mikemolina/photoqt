/**************************************************************************
 **                                                                      **
 ** Copyright (C) 2018 Lukas Spies                                       **
 ** Contact: http://photoqt.org                                          **
 **                                                                      **
 ** This file is part of PhotoQt.                                        **
 **                                                                      **
 ** PhotoQt is free software: you can redistribute it and/or modify      **
 ** it under the terms of the GNU General Public License as published by **
 ** the Free Software Foundation, either version 2 of the License, or    **
 ** (at your option) any later version.                                  **
 **                                                                      **
 ** PhotoQt is distributed in the hope that it will be useful,           **
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of       **
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        **
 ** GNU General Public License for more details.                         **
 **                                                                      **
 ** You should have received a copy of the GNU General Public License    **
 ** along with PhotoQt. If not, see <http://www.gnu.org/licenses/>.      **
 **                                                                      **
 **************************************************************************/

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Slider {

    property real scrollStep: 3

    property string tooltip: ""

    style: SliderStyle {
        groove: Rectangle {
            implicitWidth: 200
            implicitHeight: 3
            color: control.enabled ? colour.slider_groove_bg_color : colour.slider_groove_bg_color_disabled
            Behavior on color { ColorAnimation { duration: variables.animationSpeed/2 } }
            radius: variables.global_item_radius
            property bool en: control.enabled
        }
        handle: Rectangle {
            anchors.centerIn: parent
            color: control.enabled ?
                       (control.pressed ?
                            colour.slider_handle_color_active :
                            colour.slider_handle_color_inactive) :
                       colour.slider_handle_color_disabled
            Behavior on color { ColorAnimation { duration: variables.animationSpeed/2 } }
            border.color: control.enabled ? colour.slider_handle_border_color : colour.slider_handle_border_color_disabled
            Behavior on border.color { ColorAnimation { duration: variables.animationSpeed/2 } }
            border.width: 1
            implicitWidth: 18
            implicitHeight: 12
            radius: variables.global_item_radius
        }
    }

    ToolTip {
        id: tooltip
        text: parent.tooltip
        anchors.fill: parent
        cursorShape: (parent.pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor)
        propagateComposedEvents: true
        onPressed: mouse.accepted = false
        onReleased: mouse.accepted = false
        onWheel: {
            if(wheel.angleDelta.y < 0)
                value += scrollStep
            else
                value -= scrollStep
        }
    }

}
