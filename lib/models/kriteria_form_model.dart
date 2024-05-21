// To parse this JSON data, do
//
//     final kriteriaFormModel = kriteriaFormModelFromJson(jsonString);

class KriteriaFormModel {
  final int? id;
  final String? nama;

  KriteriaFormModel({
    this.id,
    this.nama,
  });

  factory KriteriaFormModel.fromJson(Map<String, dynamic> json) =>
      KriteriaFormModel(
        id: json["id"],
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
      };
}
