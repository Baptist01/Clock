cmake_minimum_required(VERSION 3.16)

project(Clock VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick DBus)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appClock
    src/main.cpp
    src/services/connman/ConnmanServiceModel.cpp
    src/services/connman/ConnmanServiceModel.h
)

qt_add_qml_module(appClock
    URI Clock
    QML_FILES 
        qml/Main.qml
        QML_FILES qml/controls/IconButton.qml
        QML_FILES qml/styles/Colors.qml
        QML_FILES qml/pages/ClockPage.qml
        QML_FILES qml/pages/WifiInfoPage.qml
        QML_FILES qml/pages/AboutInfoPage.qml
        QML_FILES qml/pages/SettingsListPage.qml
        QML_FILES qml/pages/WifiDetailPage.qml
        QML_FILES qml/pages/DisplayInfoPage.qml
        QML_FILES qml/pages/SoundInfoPage.qml
        QML_FILES qml/pages/NotificationsInfoPage.qml
        QML_FILES qml/pages/BluetoothInfoPage.qml
        QML_FILES qml/pages/DateTimeInfoPage.qml
        QML_FILES qml/pages/LanguageInfoPage.qml
        QML_FILES qml/pages/PrivacyInfoPage.qml
        QML_FILES qml/pages/UpdatesInfoPage.qml
        QML_FILES qml/pages/DeveloperOptionsPage.qml
        QML_FILES qml/pages/AboutInfoPage.qml
        QML_FILES qml/components/BackButtonComponent.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appClock PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appClock
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appClock
    PRIVATE Qt6::Quick Qt6::DBus
)

include(GNUInstallDirs)
install(TARGETS appClock
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
