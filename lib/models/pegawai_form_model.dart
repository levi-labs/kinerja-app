class PegawaiFormModel {
  int? id;
  String namaLengkap;
  String nip;
  String jabatan;
  String noHp;
  String alamat;
  String email;

  PegawaiFormModel({
    this.id,
    required this.namaLengkap,
    required this.nip,
    required this.jabatan,
    required this.noHp,
    required this.alamat,
    required this.email,
  });

  factory PegawaiFormModel.fromJson(Map<String, dynamic> json) =>
      PegawaiFormModel(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        nip: json["nip"],
        jabatan: json["jabatan"],
        noHp: json["no_hp"],
        alamat: json["alamat"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lengkap": namaLengkap,
        "nip": nip,
        "jabatan": jabatan,
        "no_hp": noHp,
        "alamat": alamat,
        "email": email,
      };
}
