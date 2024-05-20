import 'dart:ffi';

class DashboardFormModel {
  final int? jumlahPegawai;
  final int? jumlahKriteria;
  final int? jumlahIndikator;
  final int? jumlahUser;

  DashboardFormModel({
    this.jumlahPegawai,
    this.jumlahKriteria,
    this.jumlahIndikator,
    this.jumlahUser,
  });
  factory DashboardFormModel.fromJson(Map<String, dynamic> json) {
    return DashboardFormModel(
      jumlahPegawai: json['pegawai'] as int?,
      jumlahKriteria: json['kriteria'] as int?,
      jumlahIndikator: json['indikator'] as int?,
      jumlahUser: json['user'] as int?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'pegawai': jumlahPegawai,
      'kriteria': jumlahKriteria,
      'indikator': jumlahIndikator,
      'user': jumlahUser,
    };
  }
}
