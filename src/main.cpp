#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    const bool fullscreen = qEnvironmentVariableIntValue("APP_FULLSCREEN") == 1;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("appFullscreen", fullscreen);

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
