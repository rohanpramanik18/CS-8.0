import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_pro/addProject/addWorker.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong2/latlong.dart';
import 'package:learn_pro/addProject/projectDetails.dart';
import 'package:learn_pro/addProject/projectSummary.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class AddMap extends StatefulWidget {
  @override
  State<AddMap> createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  List<LatLng> tappedPoints = [];
  late Address addr;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var markers = tappedPoints.map((latlng) {
      return new Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => new Container(
          child: Icon(
            Icons.location_on,
          ),
        ),
      );
    }).toList();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tap to add pins"),
        actions: <Widget>[
          MaterialButton(
            color: Colors.white,
            child: Text(
              "Continue",
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              //print(tappedPoints[0]);

              final coordinates = new Coordinates(
                  tappedPoints[0].latitude, tappedPoints[0].longitude);
              var addresses = await Geocoder.local
                  .findAddressesFromCoordinates(coordinates);
              addr = addresses.first;
              ProjectDetails.address = addr.addressLine.toString();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProjectSummary()));

              /*if (widget.resultsPage) {
                //go to results page
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShowResult(first.locality)));
              } else {
                // go to success pages
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateReport(first)));
              }*/
            },
          ),
        ],
      ),
      body: new Padding(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
          children: [
            new Padding(
              padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: new Text(""),
            ),
            new Flexible(
              child: new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(19.0760, 72.8777),
                  zoom: 10.0,
                  onTap: _handleTap,
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}"
                      //"https://tile.openstreetmap.org/{z}/{x}/{y}.png", This is for openstreet maps, above is for gmaps
                      ),
                  new MarkerLayerOptions(markers: markers)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(TapPosition tapPosition, LatLng latlng) {
    setState(() {
      try {
        tappedPoints.removeAt(0);
      } catch (e) {
        print("empty");
      }
      print(
          "Latitude : ${latlng.latitude} and Longitude : ${latlng.longitude}");
      tappedPoints.add(latlng);
    });
  }
}
