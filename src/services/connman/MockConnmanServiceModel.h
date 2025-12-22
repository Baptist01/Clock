#pragma once

#include <QAbstractListModel>

class MockConnmanServiceModel : public QAbstractListModel
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

    explicit MockConnmanServiceModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    bool isAvailable() const;

    Q_INVOKABLE void refresh();

signals:
    void availableChanged();

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

    QList<ServiceEntry> m_services;
    bool m_available = true;
};
