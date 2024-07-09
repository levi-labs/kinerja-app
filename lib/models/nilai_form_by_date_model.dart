class NilaiByDate {
  int id;
  String namaLengkap;
  DateTime tanggalNilai;
  double totalNilai;
  String? skala;
  String? keterangan;

  NilaiByDate({
    required this.id,
    required this.namaLengkap,
    required this.tanggalNilai,
    required this.totalNilai,
    this.skala,
    this.keterangan,
  });

  factory NilaiByDate.fromJson(Map<String, dynamic> json) => NilaiByDate(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        tanggalNilai: DateTime.parse(json["tanggal_nilai"]),
        totalNilai: json["total_nilai"]?.toDouble(),
        skala: json["skala"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "tanggal_nilai":
            "${tanggalNilai.year.toString().padLeft(4, '0')}-${tanggalNilai.month.toString().padLeft(2, '0')}-${tanggalNilai.day.toString().padLeft(2, '0')}",
        "total_nilai": totalNilai,
        "skala": skala,
        "keterangan": keterangan,
      };
}
