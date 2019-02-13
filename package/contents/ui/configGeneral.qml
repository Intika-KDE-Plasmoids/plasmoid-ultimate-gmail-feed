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
    
    property alias cfg_pollinterval: spinbox.value
    property alias cfg_manualCheck: manualCheckCheckbox.checked
    property alias cfg_multiLine: multiLineCheckbox.checked
    property alias cfg_openURLInsteadMail: openURLInsteadMail.checked
    property alias cfg_openURLInsteadMain: openURLInsteadMain.checked
    property alias cfg_userName: userName.text
    property alias cfg_realM: realM.text
    property alias cfg_serverURL: serverURL.text
    property alias cfg_serverQuery: serverQuery.text
    property alias cfg_transProt: transProt.text
    property alias cfg_commandOpen: commandOpen.text
    property alias cfg_commandOpenMail: commandOpenMail.text
    
    QtLayouts.ColumnLayout {
        anchors.left: parent.left
        QtLayouts.ColumnLayout {
        
            QtControls.GroupBox {
            QtLayouts.Layout.fillWidth: true
            flat: true

                QtLayouts.ColumnLayout {
                
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Email account : ")
                            }

                            TextField {
                                id: userName
                                Layout.fillWidth: true
                                text: i18n(cfg_userName)
                            }
                            
                            PlasmaComponents.Label {
                                text: i18n("@")
                            }
                            
                            TextField {
                                id: realM
                                Layout.fillWidth: true
                                text: i18n(cfg_realM)
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Transfer Protocol : ")
                            }

                            TextField {
                                id: transProt
                                Layout.fillWidth: true
                                text: i18n(cfg_transProt)
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("RSS Server : ")
                            }

                            TextField {
                                id: serverURL
                                Layout.fillWidth: true
                                text: i18n(cfg_serverURL)
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Server Query : ")
                            }

                            TextField {
                                id: serverQuery
                                Layout.fillWidth: true
                                text: i18n(cfg_serverQuery)
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Command to run on 'Open inbox' : ")
                            }

                            TextField {
                                id: commandOpen
                                Layout.fillWidth: true
                                text: i18n(cfg_commandOpen)
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Command to run on 'eMail click' : ")
                            }

                            TextField {
                                id: commandOpenMail
                                Layout.fillWidth: true
                                text: i18n(cfg_commandOpenMail)
                            }
                            
                        }
                        
                        QtLayouts.RowLayout {
                        
                            PlasmaComponents.Label {
                                text: i18n("Polling interval :")
                            }

                            SpinBox {
                                id: spinbox
                                suffix: i18ncp("Polling interval in minutes", "min", "min", value)
                                Layout.fillWidth: true
                                minimumValue: 1
                                maximumValue: 999999
                            }
                            
                        }
                
                        QtControls.CheckBox {
                            id: manualCheckCheckbox
                            text: i18n("Check mailbox manually only (ignore polling interval)")
                        }
                        
                        QtControls.CheckBox {
                            id: multiLineCheckbox
                            text: i18n("Display message subject in a new line")                            
                        }
                            
                        QtControls.CheckBox {
                            id: openURLInsteadMail
                            text: i18n("Open email link instead of a command on 'eMail click'")
                        }
                        
                        QtControls.CheckBox {
                            id: openURLInsteadMain
                            text: i18n("Open email link instead of a command on 'Open inbox'")
                        }
                        
                }
            }
        }
    }
} 

