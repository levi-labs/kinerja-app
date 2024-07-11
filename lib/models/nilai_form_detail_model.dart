class NilaiDetailPegawai {
  int id;
  int pegawaiId;
  int indikatorId;
  String nilaiIndikator;
  String tanggalNilai;

  NilaiDetailPegawai({
    required this.id,
    required this.pegawaiId,
    required this.indikatorId,
    required this.nilaiIndikator,
    required this.tanggalNilai,
  });

  factory NilaiDetailPegawai.fromJson(Map<String, dynamic> json) =>
      NilaiDetailPegawai(
        id: json["id"],
        pegawaiId: json["pegawai_id"],
        indikatorId: json["indikator_id"],
        nilaiIndikator: json["nilai_indikator"],
        tanggalNilai: json["tanggal_nilai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pegawai_id": pegawaiId,
        "indikator_id": indikatorId,
        "nilai_indikator": nilaiIndikator,
        "tanggal_nilai": tanggalNilai,
      };
}
