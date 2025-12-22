#include "MockConnmanServiceModel.h"

MockConnmanServiceModel::MockConnmanServiceModel(QObject *parent)
    : QAbstractListModel(parent)
{
    QList<ServiceEntry> services;
    services.append({"mock/service/1", "Office Wi-Fi", "wifi", "ready", 82, true, "wpa2"});
    services.append({"mock/service/2", "Guest Network", "wifi", "idle", 55, false, "wpa2"});
    services.append({"mock/service/3", "Lab AP", "wifi", "online", 71, true, "wpa2"});
    services.append({"mock/service/4", "Cafe Hotspot", "wifi", "idle", 34, false, "open"});

    setServices(std::move(services));
}

int MockConnmanServiceModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_services.size();
}

QVariant MockConnmanServiceModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_services.size())
        return {};

    const ServiceEntry &entry = m_services.at(index.row());

    switch (role) {
    case NameRole:
        return entry.name;
    case TypeRole:
        return entry.type;
    case StateRole:
        return entry.state;
    case StrengthRole:
        return entry.strength;
    case FavoriteRole:
        return entry.favorite;
    case SecurityRole:
        return entry.security;
    case PathRole:
        return entry.path;
    default:
        return {};
    }
}

QHash<int, QByteArray> MockConnmanServiceModel::roleNames() const
{
    return {
        {NameRole, "name"},
        {TypeRole, "type"},
        {StateRole, "state"},
        {StrengthRole, "strength"},
        {FavoriteRole, "favorite"},
        {SecurityRole, "security"},
        {PathRole, "path"},
    };
}

bool MockConnmanServiceModel::isAvailable() const
{
    return m_available;
}

void MockConnmanServiceModel::refresh()
{
    setServices(m_services);
}

void MockConnmanServiceModel::setServices(QList<ServiceEntry> services)
{
    beginResetModel();
    m_services = std::move(services);
    endResetModel();
}
