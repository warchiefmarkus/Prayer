#ifndef PRAYER_H
#define PRAYER_H


#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQmlContext>
#include <QDebug>
#include <QtSql>
#include <QDate>
#include <QSqlTableModel>
#include <QDebug>

class PraysModel : public QSqlQueryModel
{
    Q_OBJECT
private:
    QHash<int, QByteArray> roleNames() const{
        return roles;
    }
    QHash<int, QByteArray> roles;

public:
    void setRoleNames(QHash<int, QByteArray> rol){
        roles = rol;
    }

    void generateRoleNames(){
        QHash<int, QByteArray> roleNames;
        for(int i = 0; i <record().count(); i++){
            roleNames[Qt::UserRole+ i + 1] = record().fieldName(i).toLatin1();
        }
        setRoleNames(roleNames);      
    }

    explicit PraysModel(QObject *parent = 0){}

    void setQuery(const QString &query, const QSqlDatabase &db = QSqlDatabase()){
        QSqlQueryModel::setQuery(query,db);
        generateRoleNames();
    }

    void setQuery(const QSqlQuery &query){
        QSqlQueryModel::setQuery(query);
        generateRoleNames();
    }

    QVariant data(const QModelIndex &index, int role) const{

        QVariant value = QSqlQueryModel::data(index,role);       
        if (role<Qt::UserRole){
            value = QSqlQueryModel::data(index, role);
        }
        else
        {
            int columnIdx = role - Qt::UserRole - 1;
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            value = QSqlQueryModel::data(modelIndex,Qt::DisplayRole);
        }
        return value;
    }
};

class Prayer : public  QQmlApplicationEngine
{
    Q_OBJECT
public:
    explicit Prayer(QWindow *parent = 0);
    ~Prayer();

    int CIRCLE;

    QSqlDatabase sdb;
    PraysModel prays;

    void Push(int toAdd);
    void Backup();

    void OpenDB();

    void ChangeRecDB(QString day, int count);
    void PlusCurRecDB(int plusCount);

signals:
    void updateShow(int count);

public slots:    
    void onPush(int);
    void spin_edit(int val);
};

#endif // PRAYER_H
