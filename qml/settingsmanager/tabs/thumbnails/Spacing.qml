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

import "../../../elements"
import "../../"

Entry {

    id: entrytop

    title: em.pty+qsTr("Spacing Between Thumbnails")
    helptext: em.pty+qsTr("The thumbnails are shown in a row at the lower or upper edge (depending on your setup). They are lined up side by side.\
 Per default, there's no empty space between them.")

    // This variable is needed to avoid a binding loop of slider<->spinbox
    property int val: 20

    content: [

        Row {

            spacing: 10

            CustomSlider {

                id: spacing_slider

                width: Math.min(200, Math.max(200, parent.parent.width-spacing_spinbox.width-50))
                y: (parent.height-height)/2

                minimumValue: 0
                maximumValue: 30

                stepSize: 1
                scrollStep: 1

                onValueChanged:
                    entrytop.val = value

            }

            CustomSpinBox {

                id: spacing_spinbox

                width: 75

                minimumValue: 0
                maximumValue: 30

                suffix: " px"

                value: entrytop.val

                onValueChanged: {
                    if(value%5 == 0)
                        spacing_slider.value = value
                }

            }

        }

    ]

    function setData() {
        spacing_slider.value = settings.thumbnailSpacingBetween
        entrytop.val = spacing_slider.value
    }

    function saveData() {
        settings.thumbnailSpacingBetween = spacing_spinbox.value
    }

}
