import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http ;
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final center = LatLng(19.366822, -99.195206);
  String selectedStyle = 'mapbox://styles/zabdielcead/ckedblzsg0ltf19p48s4z10zh';
  /*
  https://studio.mapbox.com/
  ne la pagina de mapbox en el avatar vamos a la opción de studio -> y creamos el newstyle 
   */
  final oscuroStyle = 'mapbox://styles/zabdielcead/ckedblzsg0ltf19p48s4z10zh';
  final streetStyle = 'mapbox://styles/zabdielcead/ckedbowye0o1y19mrmldygfjg';
 
  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    print('_onMapCreated');
    _estiloaddImage();
  }
 
  void _estiloaddImage()  async{
    print('_estiloaddImage');
    //addImageFromAsset("iconPrueba", "assets/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }
 

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }


  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  } 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: crearMapa(),
        floatingActionButton: botonesFlotantes(),

    );
  }

  Column botonesFlotantes() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
           //simbolos
          FloatingActionButton(
                child: Icon(Icons.sentiment_dissatisfied),
                onPressed: (){
                  mapController.addSymbol(SymbolOptions(
                    geometry: center,
                    iconSize: 3,
                    textField: 'Montaña creada',
                    textColor: '#ccccc',
                    iconImage: 'networkImage',
                    //iconImage: 'assetImage',
                    //iconImage: 'attraction-15',
                    textOffset: Offset(0, 3)
                  ));
                }
          ),
          SizedBox(height: 5,),
          //zoom in
          FloatingActionButton(
                child: Icon(Icons.zoom_in),
                onPressed: (){
                  //mapController.animateCamera(CameraUpdate.tiltTo(40)); //inclina el mapa como waze 
                  mapController.animateCamera(CameraUpdate.zoomIn());
                }
          ),
          SizedBox(height: 5,),
           FloatingActionButton(
                child: Icon(Icons.zoom_out),
                onPressed: (){
                  //mapController.animateCamera(CameraUpdate.tiltTo(40)); //inclina el mapa como waze 
                  mapController.animateCamera(CameraUpdate.zoomOut());
                }
          ),
          SizedBox(height: 5,),
          //cambiar estilo
          FloatingActionButton(
                    child: Icon(Icons.add_to_home_screen),
                    onPressed: () {
                      if(selectedStyle == oscuroStyle){
                          selectedStyle = streetStyle;
                      }else{
                          selectedStyle = oscuroStyle;
                      }
                     
                     

                      _estiloaddImage();
                      setState(() {  });
                    }
          )
        ]
      );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
            styleString: selectedStyle,
            onMapCreated: _onMapCreated,
            initialCameraPosition:
             CameraPosition(
                target: center,
                zoom: 15
              ),
          );
  }
}