#include "ConnmanServiceModel.h"

#include <QDBusArgument>
#include <QDBusConnection>
#include <QDBusObjectPath>

ConnmanServiceModel::ConnmanServiceModel(QObject *parent)
    : QAbstractListModel(parent)
    , m_manager("net.connman", "/", "net.connman.Manager", QDBusConnection::systemBus())
{
    updateAvailable(m_manager.isValid());

    if (m_manager.isValid()) {
        QDBusConnection::systemBus().connect(
            "net.connman",
            "/",
            "net.connman.Manager",
            "ServicesChanged",
            this,
            SLOT(handleServicesChanged(QDBusMessage)));
        refresh();
    }
}

int ConnmanServiceModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_services.size();
}

QVariant ConnmanServiceModel::data(const QModelIndex &index, int role) const
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

QHash<int, QByteArray> ConnmanServiceModel::roleNames() const
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

bool ConnmanServiceModel::isAvailable() const
{
    return m_available;
}

void ConnmanServiceModel::refresh()
{
    if (!m_manager.isValid()) {
        updateAvailable(false);
        setServices({});
        return;
    }

    QDBusMessage reply = m_manager.call("GetServices");
    if (reply.type() != QDBusMessage::ReplyMessage || reply.arguments().isEmpty()) {
        setServices({});
        return;
    }

    setServices(parseServicesArgument(reply.arguments().constFirst()));
}

void ConnmanServiceModel::handleServicesChanged(const QDBusMessage &message)
{
    if (message.arguments().isEmpty()) {
        refresh();
        return;
    }

    setServices(parseServicesArgument(message.arguments().constFirst()));
}

void ConnmanServiceModel::setServices(QList<ServiceEntry> services)
{
    beginResetModel();
    m_services = std::move(services);
    endResetModel();
}

QList<ConnmanServiceModel::ServiceEntry> ConnmanServiceModel::parseServicesArgument(const QVariant &arg) const
{
    QList<ServiceEntry> services;

    if (!arg.canConvert<QDBusArgument>())
        return services;

    QDBusArgument dbusArg = arg.value<QDBusArgument>();
    dbusArg.beginArray();
    while (!dbusArg.atEnd()) {
        QDBusObjectPath path;
        QVariantMap dict;
        dbusArg.beginStructure();
        dbusArg >> path >> dict;
        dbusArg.endStructure();

        ServiceEntry entry;
        entry.path = path.path();
        entry.name = dict.value("Name").toString();
        if (entry.name.isEmpty())
            entry.name = dict.value("SSID").toString();
        if (entry.name.isEmpty())
            entry.name = entry.path;
        entry.type = dict.value("Type").toString();
        entry.state = dict.value("State").toString();
        entry.strength = dict.value("Strength").toInt();
        entry.favorite = dict.value("Favorite").toBool();

        const QVariant securityVar = dict.value("Security");
        if (securityVar.metaType().id() == QMetaType::QStringList)
            entry.security = securityVar.toStringList().join(", ");
        else
            entry.security = securityVar.toString();

        services.append(entry);
    }
    dbusArg.endArray();

    return services;
}

void ConnmanServiceModel::updateAvailable(bool available)
{
    if (m_available == available)
        return;

    m_available = available;
    emit availableChanged();
}
