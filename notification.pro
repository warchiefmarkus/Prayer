QT += core sql qml quick androidextras

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android-sources

TARGET = PrayCounter

SOURCES += \
    main.cpp \
    notificationclient.cpp \
    prayer.cpp

OTHER_FILES += \
    qml/main.qml \
    android-sources/src/org/qtproject/example/notification/NotificationClient.java \
    android-sources/AndroidManifest.xml

RESOURCES += \
    main.qrc

HEADERS += \
    notificationclient.h \
    prayer.h

DISTFILES += \
    android-sources/res/layout/mylayout.xml \
    android-sources/src/org/qtproject/example/notification/PrayerService.java \
    android-sources/res/button_bgnd_left.xml \
    android-sources/res/drawable/button_bgnd_left.xml
