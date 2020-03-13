
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tubles/core/models/tubles_model.dart';

class TublesServices {
  static List<TublesModel> getTubles() {
    return <TublesModel>[
      TublesModel(
        title: "Tambal Ban Eko",
        description: "Menerima jasa tambah angin dan tambal ban bocor",
        location: LatLng(-6.149685895080451, 106.81719303131105)
      ),
      TublesModel(
        title: "Tambal Ban Purwanta",
        description: "Ban bocor udah jadi makanan sehari-hari kami",
        location: LatLng(-6.1523313283353565, 106.82363033294679)
      ),
      TublesModel(
        title: "Tambal Ban Dirgahayu",
        description: "Menerima segala jenis ban bocor dan angin",
        location: LatLng(-6.153568703887092, 106.81946754455568)
      ),
      TublesModel(
        title: "Tambal Ban Adimakmur",
        description: "Isi angin harga murah dan alat lengkap",
        location: LatLng(-6.157494152083896, 106.838436126709)
      ),
      TublesModel(
        title: "Tambal Ban Yurani",
        description: "Menerima pelayanan spesial ban bocor, ganti karet ban, pelek, dan isi angin",
        location: LatLng(-6.161376903822747, 106.82165622711183)
      ),
      TublesModel(
        title: "Tambal Ban Kuningan",
        description: "Respon cepat dan pelayanan terbaik",
        location: LatLng(-6.232776052438292, 106.82560443878174)
      ),
    ];
  }
}