#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "services/connman/ConnmanServiceModel.h"
#include "services/connman/MockConnmanServiceModel.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    const bool fullscreen = qEnvironmentVariableIntValue("APP_FULLSCREEN") == 1;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("appFullscreen", fullscreen);

    bool useConnman = true;
    if (qEnvironmentVariableIsSet("USE_CONNMAN"))
        useConnman = qEnvironmentVariableIntValue("USE_CONNMAN") != 0;
#ifdef Q_OS_WIN
    useConnman = false;
#endif

    QObject *connmanServices = useConnman
        ? static_cast<QObject *>(new ConnmanServiceModel(&app))
        : static_cast<QObject *>(new MockConnmanServiceModel(&app));
    engine.rootContext()->setContextProperty("connmanServices", connmanServices);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Clock", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
