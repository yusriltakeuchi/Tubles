
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tubles/core/models/tubles_model.dart';

class TublesServices {
  static List<TublesModel> getTubles() {
    return <TublesModel>[
      TublesModel(
        title: "Tambal Ban Eko",
        description: "Menerima jasa tambah angin dan tambal ban bocor",
        location: LatLng(-6.151008613353333, 106.81737542152406)
      ),
      TublesModel(
        title: "Tambal Ban Purwanta",
        description: "Ban bocor udah jadi makanan sehari-hari kami",
        location: LatLng(-6.149291212377793, 106.82282567024231)
      ),
      TublesModel(
        title: "Tambal Ban Dirgahayu",
        description: "Menerima segala jenis ban bocor dan angin",
        location: LatLng(-6.153622038975415, 106.82315826416017)
      ),
      TublesModel(
        title: "Tambal Ban Adimakmur",
        description: "Isi angin harga murah dan alat lengkap",
        location: LatLng(-6.154624737639637, 106.81607723236085)
      ),
      TublesModel(
        title: "Tambal Ban Yurani",
        description: "Menerima pelayanan spesial ban bocor, ganti karet ban, pelek, dan isi angin",
        location: LatLng(-6.1452910333251065, 106.81787967681886)
      ),
    ];
  }
}