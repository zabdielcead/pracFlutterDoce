import 'package:flutter/material.dart';
import 'package:mapbox_mapas/src/views/fullscreenmap.dart';
 
void main() => runApp(MyApp());
 // url mapbox https://account.mapbox.com/access-tokens
 // https://pub.dev/packages/mapbox_gl/versions/0.7.0 versiones de flutter
 //estilos de mapbox  https://github.com/tobrun/flutter-mapbox-gl en la carpeta de example -> lib
 // para subir la version en IOS Runner.xcodeproj click en Runner su ios Deployment Target a 10.0
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maps',
      home: Scaffold(
          body: FullScreenMap(),
        ),
    );
  }
}