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
import QtQuick.XmlListModel 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.private.ultimategmailfeed 0.1

Item {
    id: mainItem
    
    // Updater 1/3 ==================================================================================================================================
    property string updateResponse;
    property string currentVersion: '2.1';
    property bool checkUpdateStartup: Plasmoid.configuration.checkUpdateStartup
    // ==============================================================================================================================================
    
    property string subtext: ""
    property string title: Plasmoid.title
        
    Plasmoid.toolTipSubText: subtext
    Plasmoid.icon: xmlModel2.count > 0 ? "mail-unread-new" : "mail-unread"
    Plasmoid.compactRepresentation: CompactRepresentation {}
    Plasmoid.fullRepresentation: FullRepresentation {}
    Plasmoid.switchWidth: units.gridUnit * 8
    Plasmoid.switchHeight: units.gridUnit * 8
    
    PlasmaCore.DataSource {
            id: executable
            engine: "executable"
            connectedSources: []
            onNewData: {
                var exitCode = data["exit code"]
                var exitStatus = data["exit status"]
                var stdout = data["stdout"]
                var stderr = data["stderr"]
                exited(exitCode, exitStatus, stdout, stderr)
                disconnectSource(sourceName) // cmd finished
            }
            function exec(cmd) {
                connectSource(cmd)
            }
            signal exited(int exitCode, int exitStatus, string stdout, string stderr)
    }
    
    NetworkStatus {
        id: networkStatus
        onIsOnlineChanged: checkMailOneShotTimer.start()
    }
    
    Timer {
        id: checkMailOneShotTimer
        interval: 1000
        onTriggered: polltimer.restart()
    }
    
    Notification {
        id: notification
    }
    

    XmlListModel {
        id: xmlModel2

        property int newMailCount: 0
        property int newMailId: -1

        source: ""
        //query: "/"
        query: "/"
        namespaceDeclarations: "declare default element namespace 'http://purl.org/atom/ns#';"

        XmlRole { name: "id"; query: "id/string()"; isKey: true }

        onRowsInserted: {
            newMailCount += last-first+1
            newMailId = first
        }

    }

    XmlListModel {
        id: xmlModel

        source: ""
        query: "/"
        namespaceDeclarations: "declare default element namespace 'http://purl.org/atom/ns#';"

        XmlRole { name: "author"; query: "author/name/string()" }
        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "link"; query: "link/@href/string()" }

        onStatusChanged: {
            switch (status) {
                case XmlListModel.Null:
                    mainItem.subtext = "Offline - " + plasmoid.configuration.userName
                    break
                case XmlListModel.Ready:
                    plasmoid.status = (xmlModel.count > 0) ? PlasmaCore.Types.ActiveStatus : PlasmaCore.Types.PassiveStatus
                    if (xmlModel.count > 0) {
                        mainItem.subtext = i18np("1 unread message", "%1 unread messages - " + plasmoid.configuration.userName, xmlModel.count)
                    } else {
                        mainItem.subtext = i18n("No unread messages - " + plasmoid.configuration.userName)
                    }
                    if (xmlModel2.newMailCount > 0) {
                        var message
                        if (xmlModel2.newMailCount == 1) 
                            message = "<b>"+get(xmlModel2.newMailId).author+": "+"</b>"+get(xmlModel2.newMailId).title
                        else 
                            if (xmlModel2.newMailCount == 20) {message =  i18np("1 new message", "%1 new messages at least", xmlModel2.newMailCount)} 
                            else {message =  i18np("1 new message", "%1 new messages", xmlModel2.newMailCount)}
                        notification.send("new-mail-arrived", mainItem.title, message, "ultimategmailfeed", "ultimategmailfeed")
                        xmlModel2.newMailCount = 0
                    }
                    break
                case XmlListModel.Loading:
                    mainItem.subtext = i18n("Checking for new messages...")
                    break
                case XmlListModel.Error:
                    mainItem.subtext = errorString()
                    break
                default:
                    console.log(status)
                    break
            }
        }
    }
        
    Timer {
        id: polltimer
        repeat: true
        //triggeredOnStart: true
        interval: plasmoid.configuration.pollinterval * 60000
        onTriggered: autoOrNot()
    }
    
    function manuelCheck() {
    
        if (plasmoid.configuration.multiLine) {
            plasmoid.configuration.multiLineCode = "br/"
            plasmoid.configuration.multiLineCodeHeight = 30
        }
        else {
            plasmoid.configuration.multiLineCode = ""
            plasmoid.configuration.multiLineCodeHeight = 10
        }
    
        xmlModel2.source = xmlModel.source = plasmoid.configuration.transProt 
                          + plasmoid.configuration.userName 
                          + "%40" 
                          + plasmoid.configuration.realM 
                          + "@"
                          + plasmoid.configuration.serverURL
        xmlModel2.query = xmlModel.query = plasmoid.configuration.serverQuery
        xmlModel.reload()
        xmlModel2.reload()
    }
    
    function autoOrNot() {
        if (plasmoid.configuration.manualCheck == false) {
            networkStatus.isOnline ? manuelCheck() : mainItem.subtext = i18n("Offline - " + plasmoid.configuration.userName)
        }
    }
    
    function action_openInboxMail() {
        executable.exec(plasmoid.configuration.commandOpenMail)
    }
    
    // Updater 2/3 ==================================================================================================================================
    
    PlasmaCore.DataSource {
        id: executableNotification
        engine: "executable"
        onNewData: disconnectSource(sourceName) // cmd finished
        function exec(cmd) {
            connectSource(cmd)
        }
    }
    
    Timer {
        id:timerStartUpdater
        interval: 300000
        onTriggered: updaterNotification(false)
    }
    
    function availableUpdate() {
        var notificationCommand = "notify-send --icon=ultimategmailfeed 'Plasmoid Ultimate Gmail Feed' 'An update is available \n<a href=\"https://www.opendesktop.org/p/1248550/\">Update link</a>' -t 30000";
        executableNotification.exec(notificationCommand);
    }

    function noAvailableUpdate() {
        var notificationCommand = "notify-send --icon=ultimategmailfeed 'Plasmoid Ultimate Gmail Feed' 'Your current version is up to date' -t 30000";
        executableNotification.exec(notificationCommand);
    }
    
    function updaterNotification(notifyUpdated) {
        var xhr = new XMLHttpRequest;
        xhr.responseType = 'text';
        xhr.open("GET", "https://raw.githubusercontent.com/intika/Ultimate-Gmail-Feed/master/version");
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                updateResponse = xhr.responseText;
                console.log('.'+updateResponse+'.');
                console.log('.'+currentVersion+'.');
                //console.log('.'+xhr.status+'.');
                //console.log('.'+xhr.statusText+'.');
                if (updateResponse.localeCompare(currentVersion) && updateResponse.localeCompare('') && updateResponse.localeCompare('404: Not Found\n')) {
                    availableUpdate();
                } else if (notifyUpdated) {
                    noAvailableUpdate();
                }
            }
        };
        xhr.send();
    }
    
    function action_checkUpdate() {
        updaterNotification(true);
    }
    // ==============================================================================================================================================
    
    function action_checkMail() {
        networkStatus.isOnline ? manuelCheck() : mainItem.subtext = i18n("Offline - " + plasmoid.configuration.userName)
    }
    
    function action_openInbox() {
    
        if (plasmoid.configuration.openURLInsteadMain) {
            Qt.openUrlExternally(plasmoid.configuration.transProt + "mail.google.com")
        }
        else {
            executable.exec(plasmoid.configuration.commandOpen)
        }
        
    }
    
    Component.onCompleted: { 
        plasmoid.status = PlasmaCore.Types.PassiveStatus
        plasmoid.setAction("openInbox", i18n("Open inbox"), "folder-mail")
        plasmoid.setAction("checkMail", i18n("Check mail"), "mail-receive")
        plasmoid.setActionSeparator("separator0")

        // Updater 3/3 ==============================================================================================================================
        plasmoid.setAction("checkUpdate", i18n("Check for updates on github"), "view-grid");
        plasmoid.setActionSeparator("separator1")
        if (checkUpdateStartup) {timerStartUpdater.start();}
        // ==========================================================================================================================================
        
        if (plasmoid.configuration.manualCheck == false) {
            polltimer.start()
        }
    }
    
}

