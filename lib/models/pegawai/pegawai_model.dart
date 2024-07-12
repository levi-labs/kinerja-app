class PegawaiModel {
  int id;
  String namaLengkap;
  String nip;
  String noHp;
  String jabatan;
  String alamat;
  String email;

  PegawaiModel({
    required this.id,
    required this.namaLengkap,
    required this.nip,
    required this.noHp,
    required this.jabatan,
    required this.alamat,
    required this.email,
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
        id: json["id"],
        namaLengkap: json["nama_lengkap"],
        nip: json['nip'],
        noHp: json['no_hp'],
        jabatan: json['jabatan'],
        alamat: json['alamat'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_lurator": namaLengkap,
        "nip": nip,
        "no_hp": noHp,
        "jabatan": jabatan,
        "alamat": alamat,
        "email": email,
      };
}
