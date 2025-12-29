#include "timezonemanager.h"

#include <QDateTime>
#include <QSettings>
#include <QTimeZone>

#include <algorithm>

TimeZoneManager::TimeZoneManager(QObject *parent)
    : QObject(parent)
{
    /// set sate logic
    const QList<QByteArray> zoneIds = QTimeZone::availableTimeZoneIds();
    m_availableTimeZones.reserve(zoneIds.size());
    for (const QByteArray &id : zoneIds) {
        m_availableTimeZones.append(QString::fromUtf8(id));
    }
    std::sort(m_availableTimeZones.begin(), m_availableTimeZones.end());

    const QString systemId = QString::fromUtf8(QTimeZone::systemTimeZoneId());
    QSettings settings("Clock", "Clock");
    const QString savedId = settings.value("timezone/id").toString();
    if (!savedId.isEmpty() && QTimeZone(savedId.toUtf8()).isValid()) {
        m_timeZoneId = savedId;
    } else {
        m_timeZoneId = systemId;
    }

    /// set time logic
    m_availableTimeFormats = {
        QStringLiteral("hh:mm:ss"),
        QStringLiteral("hh:mm")
    };

    const QString savedTimeFormat = settings.value("timeformat/format").toString();
    if (!savedTimeFormat.isEmpty()) {
        m_timeFormat = savedTimeFormat;
    } else {
        m_timeFormat = QStringLiteral("hh:mm:ss");
    }

    if (!m_availableTimeFormats.contains(m_timeFormat)) {
        m_availableTimeFormats.prepend(m_timeFormat);
    }

    /// set date logic
    m_availableDateFormats = {
        QStringLiteral("MM dd"),
        QStringLiteral("dd MM"),
        QStringLiteral("dd.MM.yyyy"),
        QStringLiteral("dd-MM-yyyy"),
        QStringLiteral("dd.MM.yy"),
        QStringLiteral("dd-MM-yy"),
        QStringLiteral("yyyy-MM-dd"),
        QStringLiteral("yyyy.MM.dd"),
        QStringLiteral("yy-MM-dd"),
        QStringLiteral("yy.MM.dd")
    };

    const QString savedDateFormat = settings.value("dateformat/format").toString();
    if (!savedDateFormat.isEmpty()) {
        m_dateFormat = savedDateFormat;
    } else {
        m_dateFormat = QStringLiteral("yyyy-MM-dd");
    }

    if (!m_availableDateFormats.contains(m_dateFormat)) {
        m_availableDateFormats.prepend(m_dateFormat);
    }
}

QString TimeZoneManager::timeZoneId() const
{
    return m_timeZoneId;
}

void TimeZoneManager::setTimeZoneId(const QString &id)
{
    if (!QTimeZone(id.toUtf8()).isValid() || id == m_timeZoneId) {
        return;
    }

    m_timeZoneId = id;
    QSettings settings("Clock", "Clock");
    settings.setValue("timezone/id", m_timeZoneId);
    emit timeZoneIdChanged();
}

QStringList TimeZoneManager::availableTimeZones() const
{
    return m_availableTimeZones;
}

QString TimeZoneManager::timeFormat() const
{
    return m_timeFormat;
}

void TimeZoneManager::setTimeFormat(const QString &format)
{
    if (format.isEmpty() || format == m_timeFormat) {
        return;
    }

    m_timeFormat = format;
    QSettings settings("Clock", "Clock");
    settings.setValue("timeformat/format", m_timeFormat);
    emit timeFormatChanged();
}

QStringList TimeZoneManager::availableTimeFormats() const
{
    return m_availableTimeFormats;
}

QString TimeZoneManager::formattedTime(const QString &format) const
{
    const QDateTime nowUtc = QDateTime::currentDateTimeUtc();
    const QDateTime nowInZone = nowUtc.toTimeZone(QTimeZone(m_timeZoneId.toUtf8()));
    return nowInZone.toString(format);
}

QString TimeZoneManager::dateFormat() const
{
    return m_dateFormat;
}

void TimeZoneManager::setDateFormat(const QString &format)
{
    if (format.trimmed().isEmpty() || format == m_dateFormat) {
        return;
    }

    m_dateFormat = format;
    QSettings settings("Clock", "Clock");
    settings.setValue("dateformat/format", m_dateFormat);
    emit dateFormatChanged();
}

QStringList TimeZoneManager::availableDateFormats() const
{
    return m_availableDateFormats;
}

QString TimeZoneManager::formattedDate(const QString &format) const
{
    const QDateTime nowUtc = QDateTime::currentDateTimeUtc();
    const QDateTime nowInZone = nowUtc.toTimeZone(QTimeZone(m_timeZoneId.toUtf8()));
    return nowInZone.toString(format);
}
