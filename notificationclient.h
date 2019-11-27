#ifndef NOTIFICATIONCLIENT_H
#define NOTIFICATIONCLIENT_H

#include <QObject>
#include <QtAndroidExtras>
#include <prayer.h>

class NotificationClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString notification READ notification WRITE setNotification NOTIFY notificationChanged)
public:

    void setNotification(const QString &notification);
    QString notification() const;

    static void fromJavaCount(JNIEnv *env, jobject thiz, jint x)
    {
        Q_UNUSED(env)
        Q_UNUSED(thiz)
        callback(x); 
    }

    static void fromJavaOptions(JNIEnv *env, jobject thiz, jint x)
    {
        Q_UNUSED(env)
        Q_UNUSED(thiz)
    }

    void registerNativeMethods() {
        JNINativeMethod methods[] {{"callNativeCount", "(I)V", reinterpret_cast<void *>(fromJavaCount)},
                                   {"callNativeOptions", "(I)V", reinterpret_cast<void *>(fromJavaOptions)}
        };
        QAndroidJniObject javaClass("org/qtproject/example/notification/NotificationClient");
        QAndroidJniEnvironment env;
        jclass objectClass = env->GetObjectClass(javaClass.object<jobject>());
        env->RegisterNatives(objectClass,
                             methods,
                             sizeof(methods) / sizeof(methods[0]));
        env->DeleteLocalRef(objectClass);
    }

    static NotificationClient* Instance(QObject *parent)
    {
        if(!_self) {
            _self = new NotificationClient(parent);
        }
        return _self;
    }

signals:
    void notificationChanged();
    void notifPressed(int i);

public slots:


    void updateAndroidNotification();

    void updateShow(int count){
        //QString::number(qobject_cast<Prayer*>(Instance(0)->parent())->CUR_PRAYS)
        QAndroidJniObject javaNotification = QAndroidJniObject::fromString(QString::number(count));
        QAndroidJniObject::callStaticMethod<void>("org/qtproject/example/notification/PrayerService",
                                                                  "show_update_notif",
                                                                  "(Ljava/lang/String;)V",
                                                                  javaNotification.object<jstring>());
    }

private:
    QString m_notification;
    static NotificationClient* _self;

    static int callback(int val)
    {
        //emit Instance(0)->notifPressed(val);
        qobject_cast<Prayer*>(Instance(0)->parent())->Push(val);
    }

protected:
    explicit NotificationClient(QObject *parent = 0);
};

#endif // NOTIFICATIONCLIENT_H
