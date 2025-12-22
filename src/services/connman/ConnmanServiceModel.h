#pragma once

#include <QAbstractListModel>
#include <QDBusInterface>
#include <QDBusMessage>

class ConnmanServiceModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool available READ isAvailable NOTIFY availableChanged)

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        TypeRole,
        StateRole,
        StrengthRole,
        FavoriteRole,
        SecurityRole,
        PathRole
    };
    Q_ENUM(Roles)

    explicit ConnmanServiceModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    bool isAvailable() const;

    Q_INVOKABLE void refresh();

signals:
    void availableChanged();

private slots:
    void handleServicesChanged(const QDBusMessage &message);

private:
    struct ServiceEntry {
        QString path;
        QString name;
        QString type;
        QString state;
        int strength = 0;
        bool favorite = false;
        QString security;
    };

    void setServices(QList<ServiceEntry> services);
    QList<ServiceEntry> parseServicesArgument(const QVariant &arg) const;
    void updateAvailable(bool available);

    QList<ServiceEntry> m_services;
    QDBusInterface m_manager;
    bool m_available = false;
};
