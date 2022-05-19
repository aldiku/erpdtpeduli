// To parse this JSON data, do
//
//     final modelhewan = modelhewanFromJson(jsonString);

import 'dart:convert';

Modelhewan modelhewanFromJson(String str) =>
    Modelhewan.fromJson(json.decode(str));

String modelhewanToJson(Modelhewan data) => json.encode(data.toJson());

class Modelhewan {
  Modelhewan({
    this.total,
    required this.rows,
    this.offset,
    this.next,
    this.limit,
    this.currentPage,
    this.totalPage,
  });

  String? total;
  List<Row> rows;
  int? offset;
  bool? next;
  int? limit;
  int? currentPage;
  int? totalPage;

  factory Modelhewan.fromJson(Map<String, dynamic> json) => Modelhewan(
        total: json["total"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
        offset: json["offset"],
        next: json["next"],
        limit: json["limit"],
        currentPage: json["currentPage"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
        "offset": offset,
        "next": next,
        "limit": limit,
        "currentPage": currentPage,
        "totalPage": totalPage,
      };
}

class Row {
  Row({
    this.idMitra,
    this.id,
    this.kantorTransaksi,
    this.kantorMitra,
    this.noHewanQurban,
    this.video,
    this.foto1,
    this.foto2,
    this.foto3,
    this.foto4,
    this.dateAdd,
    this.status,
    this.deskripsi,
    this.muqorib,
    this.tipeHewanQurban,
    this.userAdd,
    this.printLaporan,
    this.isDeleted,
    this.rating,
    this.token,
  });

  String? idMitra;
  String? id;
  String? kantorTransaksi;
  String? kantorMitra;
  String? noHewanQurban;
  String? video;
  String? foto1;
  String? foto2;
  String? foto3;
  String? foto4;
  DateTime? dateAdd;
  String? status;
  String? deskripsi;
  String? muqorib;
  String? tipeHewanQurban;
  String? userAdd;
  String? printLaporan;
  String? isDeleted;
  String? rating;
  String? token;

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        idMitra: json["id_mitra"],
        id: json["id"],
        kantorTransaksi: json["kantor_transaksi"],
        kantorMitra: json["kantor_mitra"],
        noHewanQurban: json["no_hewan_qurban"],
        video: json["video"],
        foto1: json["foto_1"],
        foto2: json["foto_2"],
        foto3: json["foto_3"],
        foto4: json["foto_4"],
        dateAdd: DateTime.parse(json["date_add"]),
        status: json["status"],
        deskripsi: json["deskripsi"],
        muqorib: json["muqorib"],
        tipeHewanQurban: json["tipe_hewan_qurban"],
        userAdd: json["user_add"],
        printLaporan: json["print_laporan"],
        isDeleted: json["is_deleted"],
        rating: json["rating"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id_mitra": idMitra,
        "id": id,
        "kantor_transaksi": kantorTransaksi,
        "kantor_mitra": kantorMitra,
        "no_hewan_qurban": noHewanQurban,
        "video": video,
        "foto_1": foto1,
        "foto_2": foto2,
        "foto_3": foto3,
        "foto_4": foto4,
        "date_add": dateAdd.toString(),
        "status": status,
        "deskripsi": deskripsi,
        "muqorib": muqorib,
        "tipe_hewan_qurban": tipeHewanQurban,
        "user_add": userAdd,
        "print_laporan": printLaporan,
        "is_deleted": isDeleted,
        "rating": rating,
        "token": token,
      };
}
