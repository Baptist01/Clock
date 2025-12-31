cmake_minimum_required(VERSION 3.16)

project(Clock VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

set(plain_qml_files
    qml/Main.qml
    qml/pages/ClockPage.qml
    qml/pages/WifiInfoPage.qml
    qml/pages/SettingsListPage.qml
    qml/pages/DisplayInfoPage.qml
    qml/pages/SoundInfoPage.qml
    qml/pages/NotificationsInfoPage.qml
    qml/pages/BluetoothInfoPage.qml
    qml/pages/DateTimeInfoPage.qml
    qml/pages/LanguageInfoPage.qml
    qml/pages/PrivacyInfoPage.qml
    qml/pages/AboutInfoPage.qml
    qml/components/BackButtonComponent.qml
)

set(qml_singletons
    qml/theme/Styling.qml
)

set_source_files_properties(${qml_singletons}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_executable(appClock
    src/main.cpp
    src/app/timezonemanager.cpp
    src/app/timezonemanager.h
)

qt_add_qml_module(appClock
    URI Clock
    VERSION 1.0
    QML_FILES ${plain_qml_files} ${qml_singletons}
    QML_FILES qml/components/Divider.qml
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
    PRIVATE
      Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appClock
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
