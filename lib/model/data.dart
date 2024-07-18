class Report {
  String? id;
  String? namaPelapor;
  final String namaBarang;
  String? pathFoto;
  final String kronologi;
  final String nomor;
  String? waktu;
  final String update;

  Report({
    required this.namaBarang,
    this.id,
    this.namaPelapor,
    this.pathFoto,
    required this.kronologi,
    this.waktu,
    required this.nomor,
    required this.update,
  });

  factory Report.createFromJson(Map<dynamic, dynamic> json) {
    return Report(
      id: json['id'],
      namaBarang: json['namaBarang'],
      namaPelapor: json['nama'],
      pathFoto: json['foto'],
      kronologi: json['kronologi'],
      waktu: json['waktu'],
      nomor: json['nomor'],
      update: json['isFound'],
    );
  }
}
