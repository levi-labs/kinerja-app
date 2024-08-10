class NilaiDetailList {
  int id;
  String namaLengkap;
  String nilaiIndikator;
  String nilaiHasil;
  String indikator;
  String tanggalNilai;

  NilaiDetailList({
    required this.id,
    required this.namaLengkap,
    required this.nilaiIndikator,
    required this.nilaiHasil,
    required this.indikator,
    required this.tanggalNilai,
  });

  factory NilaiDetailList.fromJson(Map<String, dynamic> json) =>
      NilaiDetailList(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        nilaiIndikator: json["nilai_indikator"],
        nilaiHasil: json["nilai_hasil"],
        indikator: json["indikator"],
        tanggalNilai: json["tanggal_nilai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "nilai_indikator": nilaiIndikator,
        "nilai_hasil": nilaiHasil,
        "indikator": indikator,
        "tanggal_nilai": tanggalNilai,
      };
}
