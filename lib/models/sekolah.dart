class Sekolah {
  final String id;
  final String npsn;
  final String sekolah;
  final String bentuk;
  final String status;
  final String alamat_jalan;
  final double lintang;
  final double bujur;
  final String? imageUrl; 

  Sekolah({
    required this.id,
    required this.npsn,
    required this.sekolah,
    required this.bentuk,
    required this.status,
    required this.alamat_jalan,
    required this.lintang,
    required this.bujur,
    this.imageUrl, 
  });

  factory Sekolah.fromJson(Map<String, dynamic> json) {
    return Sekolah(
      id: json['id'],
      npsn: json['npsn'],
      sekolah: json['sekolah'],
      bentuk: json['bentuk'],
      status: json['status'],
      alamat_jalan: json['alamat_jalan'],
      lintang: double.parse(json['lintang']),
      bujur: double.parse(json['bujur']),
      imageUrl: json['imageUrl'], 
    );
  }
}