import 'package:kinerja_app/models/indikator_form_model.dart';
import 'package:kinerja_app/models/nilai_form_detail_model.dart';

class NilaiEditForm {
  String pegawai;
  List<IndikatorFormModel> indikator;
  List<NilaiDetailPegawai> nilai;

  NilaiEditForm({
    required this.pegawai,
    required this.indikator,
    required this.nilai,
  });

  factory NilaiEditForm.fromJson(Map<String, dynamic> json) => NilaiEditForm(
        pegawai: json["pegawai"],
        indikator: List<IndikatorFormModel>.from(
            json["indikator"].map((x) => IndikatorFormModel.fromJson(x))),
        nilai: List<NilaiDetailPegawai>.from(
            json["nilai"].map((x) => NilaiDetailPegawai.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pegawai": pegawai,
        "indikator": List<dynamic>.from(indikator.map((x) => x.toJson())),
        "nilai": List<dynamic>.from(nilai.map((x) => x.toJson())),
      };
}
