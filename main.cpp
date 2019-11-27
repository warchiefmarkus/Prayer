#include <QtGui>
#include <QtQuick>
#include "notificationclient.h"
#include <prayer.h>
#include <QObject>


int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);

    Prayer view;

    NotificationClient *notificationClient = NotificationClient::Instance(&view);
    view.rootContext()->setContextProperty(QLatin1String("notificationClient"),
                                                     notificationClient);

    view.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    view.OpenDB();

    notificationClient->registerNativeMethods();

    QObject::connect((QObject*)view.rootObjects().at(0),SIGNAL(push(int)),&view,SLOT(onPush(int)));
    QObject::connect((QObject*)view.rootObjects().at(0),SIGNAL(spin_edit(int)),&view,SLOT(spin_edit(int)));
    //QObject::connect(notificationClient,SIGNAL(notifPressed(int)),&view,SLOT(onPush(int)));
    //QObject::connect(&view,SIGNAL(updateShow(int)),notificationClient,SLOT(updateShow(int)));

    return app.exec();
}
