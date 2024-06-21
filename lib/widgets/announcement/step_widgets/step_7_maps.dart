import 'package:app_settings/app_settings.dart';
import 'package:avto_baraka/screen/imports/imports_announcement.dart';
import 'package:avto_baraka/screen/imports/imports_listing.dart';
import 'package:avto_baraka/style/sized_box_10.dart';

class Maps extends StatefulWidget {
  const Maps({
    Key? key,
    required this.currentPosition,
    required this.onCurrentPosition,
  }) : super(key: key);

  final LatLng currentPosition;
  final ValueChanged<LatLng> onCurrentPosition;

  @override
  MapsState createState() => MapsState();
}

class MapsState extends State<Maps> {
  final MapController _mapController = MapController();
  late LatLng _currentPosition;
  String _mapData = "";

  Position? _currentLocation;
  bool servicePosition = false;
  late LocationPermission permission;
  String? escription;
  @override
  void initState() {
    _currentPosition = widget.currentPosition;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height.isFinite
        ? MediaQuery.of(context).size.height
        : 600.0; // Замените 600.0 на разумное значение по умолчанию

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(S.of(context).xaritadaJoylashuvi),
        ),
        sizedBox10,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(_mapData),
        ),
        sizedBox10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                S.of(context).geolokatsiyaniYoqish,
                style: TextStyle(fontSize: 10.0, color: colorWhite),
              ),
            ),
            OutlinedButton(
              style: elevatedButton!.copyWith(
                backgroundColor: MaterialStatePropertyAll(
                  colorEmber,
                ),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(color: colorWhite, fontSize: 14.0),
                ),
              ),
              onPressed: () async {
                _getCurrentLocation();
                await _getAddressFromCoordinates();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).avtomatikTanlash),
                  Icon(
                    Icons.location_pin,
                    color: colorRed,
                    size: 14.0,
                  )
                ],
              ),
            ),
          ],
        ),
        sizedBox10,
        SizedBox(
          height: screenHeight / 2, // Пример ограничения высоты
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                width: 1.0,
                color: colorEmber,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition,
                  initialZoom: 16.0,
                  onTap: (tapPosition, point) => {
                    setState(() {
                      _currentPosition = point;
                      widget.onCurrentPosition(point);
                    })
                  },
                  onMapReady: () {
                    _mapController.mapEventStream.listen((MapEvent event) {
                      if (event is MapEventMoveEnd) {
                        setState(() {
                          _currentPosition = _mapController.camera.center;
                          widget
                              .onCurrentPosition(_mapController.camera.center);
                        });
                      }
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: _currentPosition,
                        child: Icon(
                          Icons.location_pin,
                          color: colorEmber,
                          size: 46.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _getCurrentLocation() async {
    servicePosition = await Geolocator.isLocationServiceEnabled();
    if (!servicePosition) {
      // debugPrint('Сервис не работает!!!');
      AppSettings.openAppSettings(type: AppSettingsType.location);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    _currentLocation = await Geolocator.getCurrentPosition();
    Geolocator.getCurrentPosition().then((value) {
      // lat = value.latitude;
      // long = value.longitude;

      setState(() {
        _currentPosition = LatLng(value.latitude, value.longitude);
        _mapController.move(_currentPosition, 16.0);
        widget.onCurrentPosition(LatLng(value.latitude, value.longitude));
      });
    });
    _getAddressFromCoordinates();
  }

  _getAddressFromCoordinates([lt, ln]) async {
    List<Placemark> placemarks;
    try {
      if (lt != null || ln != null) {
        placemarks = await placemarkFromCoordinates(lt, ln);
        // print('let: ${lt}, long: ${ln},');
        // lat = lt;
        // long = ln;
      } else {
        placemarks = await placemarkFromCoordinates(
            _currentLocation!.latitude, _currentLocation!.longitude);
      }
      Placemark place = placemarks[0];
      setState(() {
        _mapData = " ${place.locality}, ${place.thoroughfare}";
      });
    } catch (e) {
      debugPrint('_getAddressFromCoordinates error: $e');
    }
  }
}
