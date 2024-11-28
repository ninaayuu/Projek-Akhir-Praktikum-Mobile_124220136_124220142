class School {
  final String kode_prop;
  final String propinsi;
  final String kode_kab_kota;
  final String kabupaten_kota;
  final String kode_kec;
  final String kecamatan;
  final String id;
  final String npsn;
  final String sekolah;
  final String bentuk;
  final String status;
  final String alamat_jalan;
  final double lintang;
  final double bujur;

  School({
    required this.kode_prop,
    required this.propinsi,
    required this.kode_kab_kota,
    required this.kabupaten_kota,
    required this.kode_kec,
    required this.kecamatan,
    required this.id,
    required this.npsn,
    required this.sekolah,
    required this.bentuk,
    required this.status,
    required this.alamat_jalan,
    required this.lintang,
    required this.bujur,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      kode_prop: json['kode_prop'],
      propinsi: json['propinsi'],
      kode_kab_kota: json['kode_kab_kota'],
      kabupaten_kota: json['kabupaten_kota'],
      kode_kec: json['kode_kec'],
      kecamatan: json['kecamatan'],
      id: json['id'],
      npsn: json['npsn'],
      sekolah: json['sekolah'],
      bentuk: json['bentuk'],
      status: json['status'],
      alamat_jalan: json['alamat_jalan'],
      lintang: double.parse(json['lintang']),
      bujur: double.parse(json['bujur']),
    );
  }
}