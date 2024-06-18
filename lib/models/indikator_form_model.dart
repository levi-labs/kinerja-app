import 'package:kinerja_app/models/kriteria_form_model.dart';

class IndikatorFormModel {
  int? id;
  int kriteriaId;
  String nama;
  String bobot;
  String nilaiPembanding;
  KriteriaFormModel? kriteria;

  IndikatorFormModel({
    this.id,
    required this.kriteriaId,
    required this.nama,
    required this.bobot,
    required this.nilaiPembanding,
    this.kriteria,
  });

  factory IndikatorFormModel.fromJson(Map<String, dynamic> json) =>
      IndikatorFormModel(
          id: json["id"],
          kriteriaId: json["kriteria_id"],
          nama: json["nama"],
          bobot: json["bobot"],
          nilaiPembanding: json["nilai_pembanding"],
          kriteria: KriteriaFormModel.fromJson(json["kriteria"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "kriteria_id": kriteriaId,
        "nama": nama,
        "bobot": bobot,
        "nilai_pembanding": nilaiPembanding,
        "kriteria": kriteria == null ? null : kriteria!.toJson(),
      };
}
