// To parse this JSON data, do
//
//     final skalaFormModel = skalaFormModelFromJson(jsonString);

// List<SkalaFormModel> skalaFormModelFromJson(String str) =>
//     List<SkalaFormModel>.from(
//         json.decode(str).map((x) => SkalaFormModel.fromJson(x)));

// String skalaFormModelToJson(List<SkalaFormModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NilaiFormModel {
  // DateTime tanggalNilai;
  String tanggalNilai;

  NilaiFormModel({
    required this.tanggalNilai,
  });

  factory NilaiFormModel.fromJson(Map<String, dynamic> json) => NilaiFormModel(
        // tanggalNilai: DateTime.parse(json["tanggal_nilai"]),
        tanggalNilai: json["tanggal_nilai"],
      );

  Map<String, dynamic> toJson() => {
        // "tanggal_nilai":
        //     "${tanggalNilai.year.toString().padLeft(4, '0')}-${tanggalNilai.month.toString().padLeft(2, '0')}-${tanggalNilai.day.toString().padLeft(2, '0')}",
        "tanggal_nilai": tanggalNilai,
      };
}
