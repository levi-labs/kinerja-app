import 'package:kinerja_app/models/nilai_detail_list_model.dart';

class NilaiDetailModel {
  String? namaLengkap;
  List<NilaiDetailList> listNilai;

  NilaiDetailModel({
    this.namaLengkap,
    required this.listNilai,
  });
  factory NilaiDetailModel.fromJson(Map<String, dynamic> json) =>
      NilaiDetailModel(
        namaLengkap: json["pegawai"],
        listNilai: List<NilaiDetailList>.from(
            json["data"].map((x) => NilaiDetailList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pegawai": namaLengkap,
        "data": List<dynamic>.from(listNilai.map((x) => x.toJson())),
      };
}
