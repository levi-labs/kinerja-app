// To parse this JSON data, do
//
//     final skalaFormModel = skalaFormModelFromJson(jsonString);

class SkalaFormModel {
  int? id;
  String nama;
  String interval;
  String keterangan;

  SkalaFormModel({
    this.id,
    required this.nama,
    required this.interval,
    required this.keterangan,
  });

  factory SkalaFormModel.fromJson(Map<String, dynamic> json) => SkalaFormModel(
        nama: json["nama"],
        interval: json["interval"],
        keterangan: json["keterangan"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "interval": interval,
        "keterangan": keterangan,
        "id": id,
      };
}
