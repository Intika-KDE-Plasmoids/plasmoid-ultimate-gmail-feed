/**********************************************************************************
 *  Copyright (c) 2014 Anthony Vital <anthony.vital@gmail.com>                    *
 *  Copyright (c) 2018 intika <intika.dev@gmail.com>                              *
 *                                                                                *
 *  This file is part of Ultimate Gmail Feed.                                     *
 *                                                                                *
 *  Ultimate Gmail Feed is free software: you can redistribute it and/or modify   *
 *  it under the terms of the GNU General Public License as published by          *
 *  the Free Software Foundation, either version 3 of the License, or             *
 *  (at your option) any later version.                                           *
 *                                                                                *
 *  Ultimate Gmail Feed is distributed in the hope that it will be useful,        *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of                *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 *
 *  GNU General Public License for more details.                                  *
 *                                                                                *
 *  You should have received a copy of the GNU General Public License             *
 *  along with Ultimate Gmail Feed. If not, see <http://www.gnu.org/licenses/>.   *
 *********************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Layouts 1.0 as QtLayouts
import QtQuick.Controls 1.0 as QtControls
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: generalPage
    
    width: childrenRect.width
    height: childrenRect.height
    
    property alias cfg_leftclickCheck: leftclickCheckCheckbox.checked
    property alias cfg_invertMailList: invertMailListCheckbox.checked
    property alias cfg_middleClickMail: middleClickMailCheckbox.checked
    property alias cfg_popupHeight: popupHeight.value
    property alias cfg_popupWidth: popupWidth.value
    property alias cfg_lineHeight: lineHeight.value
    property alias cfg_lineWidth: lineWidth.value
    
    QtLayouts.ColumnLayout {
        anchors.left: parent.left
        QtLayouts.ColumnLayout {
        
            QtControls.GroupBox {
            QtLayouts.Layout.fillWidth: true
            flat: true

                QtLayouts.ColumnLayout {
                    
                        QtControls.CheckBox {
                            id: invertMailListCheckbox
                            text: i18n("Invert mail list order")                            
                        }
                
                        QtControls.CheckBox {
                            id: leftclickCheckCheckbox
                            text: i18n("Check mailbox on left click")
                        }
                    
                        QtControls.CheckBox {
                            id: middleClickMailCheckbox
                            text: i18n("Middle click open inbox application/link")                            
                        }
                    
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Popup height (work outside system tray) : ")
                            }

                            SpinBox {
                                id: popupHeight
                                suffix: i18ncp("Popup height in px", "px", "px", value)
                                Layout.fillWidth: true
                                minimumValue: 1
                                maximumValue: 9999
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Popup width (work outside system tray) : ")
                            }

                            SpinBox {
                                id: popupWidth
                                suffix: i18ncp("Popup width in px", "px", "px", value)
                                Layout.fillWidth: true
                                minimumValue: 1
                                maximumValue: 9999
                            }
                            
                        }
                    
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Mail line height : ")
                            }

                            SpinBox {
                                id: lineHeight
                                suffix: i18ncp("Line height in px", "px", "px", value)
                                Layout.fillWidth: true
                                minimumValue: 1
                                maximumValue: 9999
                            }
                            
                        }
                    
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Mail line width : ")
                            }

                            SpinBox {
                                id: lineWidth
                                suffix: i18ncp("Line width in px", "px", "px", value)
                                Layout.fillWidth: true
                                minimumValue: 1
                                maximumValue: 9999
                            }
                            
                        }
                }
            }
        }
    }
} 

