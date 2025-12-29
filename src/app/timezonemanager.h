#pragma once

#include <QObject>
#include <QStringList>

class TimeZoneManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString timeZoneId READ timeZoneId WRITE setTimeZoneId NOTIFY timeZoneIdChanged)
    Q_PROPERTY(QStringList availableTimeZones READ availableTimeZones CONSTANT)
    Q_PROPERTY(QString timeFormat READ timeFormat WRITE setTimeFormat NOTIFY timeFormatChanged)
    Q_PROPERTY(QStringList availableTimeFormats READ availableTimeFormats CONSTANT)
    Q_PROPERTY(QString dateFormat READ dateFormat WRITE setDateFormat NOTIFY dateFormatChanged)
    Q_PROPERTY(QStringList availableDateFormats READ availableDateFormats CONSTANT)

public:
    explicit TimeZoneManager(QObject *parent = nullptr);

    QString timeZoneId() const;
    void setTimeZoneId(const QString &id);

    QStringList availableTimeZones() const;

    QString timeFormat() const;
    void setTimeFormat(const QString &format);

    QString dateFormat() const;
    void setDateFormat(const QString &format);

    QStringList availableTimeFormats() const;
    QStringList availableDateFormats() const;

    Q_INVOKABLE QString formattedTime(const QString &format) const;
    Q_INVOKABLE QString formattedDate(const QString &format) const;

signals:
    void timeZoneIdChanged();
    void timeFormatChanged();
    void dateFormatChanged();

private:
    QString m_timeZoneId;
    QStringList m_availableTimeZones;
    QString m_timeFormat;
    QStringList m_availableTimeFormats;
    QString m_dateFormat;
    QStringList m_availableDateFormats;
};
