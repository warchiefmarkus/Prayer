#include "prayer.h"
#include <notificationclient.h>

Prayer::Prayer(QWindow *parent) : QQmlApplicationEngine(parent)
{
    CIRCLE = 20;
}

Prayer::~Prayer()
{

}

void Prayer::Push(int toAdd)
{
    qDebug() << "CALLED PUSH";
    Backup();
    PlusCurRecDB(toAdd);
    QString day = (QString::number(QDate::currentDate().year())+QString::number(QDate::currentDate().month())+QString::number(QDate::currentDate().day()));
    QSqlQuery query(sdb);
    query.exec("SELECT count FROM Prays WHERE day = "+day);
    query.next();

    QQmlContext* context = rootContext();
    context->setContextProperty("spin_value", query.value(0).toInt());

    //emit updateShow(query.value(0).toInt());
    // HACK! - function call instead of signals
    qobject_cast<NotificationClient*>(children().at(0))->updateShow(query.value(0).toInt());
}

void Prayer::ChangeRecDB(QString day, int count)
{
     qDebug() << "CALLED CHANGEREC";
     QSqlQuery query(sdb);

     // if record exist update, else insert it
     if (!query.exec("insert into Prays values('" + day + "'," +  QString::number(count) + ")")){
         query.exec("UPDATE Prays SET count = " +  QString::number(count) + " WHERE day = '" + day + "'");
     }
     prays.setQuery("SELECT * FROM Prays");
     query.exec("SELECT count FROM Prays WHERE day = "+day);
     query.next();
     // HACK! - function call instead of signals
     //emit updateShow(query.value(0).toInt());
     qobject_cast<NotificationClient*>(children().at(0))->updateShow(query.value(0).toInt());
}

void Prayer::PlusCurRecDB(int plusCount)
{
    qDebug() << " CALLED PLUSREC";
    QString day = (QString::number(QDate::currentDate().year())+QString::number(QDate::currentDate().month())+QString::number(QDate::currentDate().day()));
    QSqlQuery query(sdb);
    // if record exist update, else insert it
    if (!query.exec("insert into Prays values('" + day + "'," +  QString::number(plusCount) + ")")){
        query.exec("UPDATE Prays SET count = count +" +  QString::number(plusCount) + " WHERE day = '" + day + "'");
    }
    prays.setQuery("SELECT * FROM Prays");
}

void Prayer::OpenDB()
{
    QDir dir;
    sdb = QSqlDatabase::addDatabase("QSQLITE");

    QString dirs = "/mnt/sdcard";
    if(!(dir.exists(dirs+"/Prays"))){

        dir.mkpath(dirs+"/Prays");
    }
    sdb.setDatabaseName(dirs+"/Prays/Prays.sqlite");

    //-- If cant open
    if (!sdb.open()) {
         qDebug() << sdb.lastError().text();
    }
    //-- If Opened
    else{
        QSqlQuery query(sdb);
        if(!query.exec("SELECT * FROM Prays")){

            query.exec("create table Prays (day varchar(20) primary key, count int)");
        }

        // Set Table of records as Model
        QQmlContext* context = rootContext();
        prays.setQuery("SELECT * FROM Prays",sdb);
        context->setContextProperty("praysModel", &prays);

        QString day = (QString::number(QDate::currentDate().year())+QString::number(QDate::currentDate().month())+QString::number(QDate::currentDate().day()));
        QSqlQuery querys(sdb);
        // If there is today record in table load count in spinbox
        if(querys.exec("SELECT count FROM Prays WHERE day = "+day)){
            querys.next();
            context->setContextProperty("spin_value", querys.value(0).toInt());
        }
    }
}

void Prayer::Backup()
{
    QString dir = "/mnt/sdcard";
    QString day = (QString::number(QDate::currentDate().year())+QString::number(QDate::currentDate().month())+QString::number(QDate::currentDate().day()));
    QFile dbOriginal(dir+"/Prays/Prays.sqlite");
    if (QFile(dir+"/Prays/"+day+"-"+"Prays.sqlite").exists()){
        QFile(dir+"/Prays/"+day+"-"+"Prays.sqlite").remove();
    }
    dbOriginal.copy(dir+"/Prays/"+day+"-"+"Prays.sqlite");
}


//-----On Count Button pushed
void Prayer::onPush(int i)
{
    Push(i);
    //notificationClient->setNotification("Pushed +1");
}

void Prayer::spin_edit(int val)
{
    ChangeRecDB((QString::number(QDate::currentDate().year())+QString::number(QDate::currentDate().month())+QString::number(QDate::currentDate().day())),val);
}

