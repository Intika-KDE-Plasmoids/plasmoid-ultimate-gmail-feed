add_definitions(-DTRANSLATION_DOMAIN="plasma_applet_org.kde.plasma.ultimategmailfeed")
option (USE_QT5 "Use Qt5 instead of Qt4" ON)

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS Network)
find_package(KF5Notifications)

set(ultimategmailfeedplugin_SRCS
    ultimategmailfeedplugin.cpp
    networkstatus.cpp
    notification.cpp
)

install(FILES qmldir DESTINATION ${QML_INSTALL_DIR}/org/kde/plasma/private/ultimategmailfeed)
add_library(ultimategmailfeedplugin SHARED ${ultimategmailfeedplugin_SRCS})

target_link_libraries(ultimategmailfeedplugin
                        Qt5::Quick
                        Qt5::Network
                        KF5::Notifications
                        )

install(TARGETS ultimategmailfeedplugin DESTINATION ${QML_INSTALL_DIR}/org/kde/plasma/private/ultimategmailfeed)