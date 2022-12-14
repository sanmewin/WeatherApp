
import 'package:location/location.dart';

class getLocation{
  double ?latitude;
  double ?longitide;
  Future locationService() async {
  var location = Location();

  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      return;
    }
  }

  var permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission != PermissionStatus.granted) {
      return;
    }
  }
  var loc = await location.getLocation();
  latitude =loc.latitude;
  longitide=loc.longitude;
  print("${loc.latitude} ${loc.longitude}");
}
}
