import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/models/pegawai_form_model.dart';
import 'dart:convert';

NilaiCreateFormModel nilaicreateFormModelFromJson(String str) =>
    NilaiCreateFormModel.fromJson(json.decode(str));

String nilaicreateFormModelToJson(NilaiCreateFormModel data) =>
    json.encode(data.toJson());

class NilaiCreateFormModel {
  String? tanggalNilai;
  List<PegawaiFormModel> pegawai;
  List<IndikatorFormModel> indikator;

  NilaiCreateFormModel({
    this.tanggalNilai,
    required this.pegawai,
    required this.indikator,
  });

  factory NilaiCreateFormModel.fromJson(Map<String, dynamic> json) =>
      NilaiCreateFormModel(
        tanggalNilai: json["tanggal_nilai"],
        pegawai: json["pegawai"] != null && json["pegawai"] is List
            ? List<PegawaiFormModel>.from((json["pegawai"] as List)
                .map((x) => PegawaiFormModel.fromJson(x)))
            : [],
        indikator: json["indikator"] != null && json["indikator"] is List
            ? List<IndikatorFormModel>.from((json["indikator"] as List)
                .map((x) => IndikatorFormModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "tanggal_nilai": tanggalNilai,
        "pegawai":
            pegawai.isNotEmpty ? pegawai.map((x) => x.toJson()).toList() : [],
        "indikator": indikator.isNotEmpty
            ? indikator.map((x) => x.toJson()).toList()
            : [],
      };
}
