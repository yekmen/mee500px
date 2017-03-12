#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QtNetwork/QNetworkProxyFactory>

#include <QtDeclarative>
#include "swipecontrol.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QNetworkProxyFactory::setUseSystemConfiguration(true);

    QmlApplicationViewer viewer;
    SwipeControl * swipeControl = new SwipeControl(&viewer, true);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.rootContext()->setContextProperty("appVersion", APPLICATION_VERSION);

    viewer.setMainQmlFile(QLatin1String("qml/Mee500px/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
