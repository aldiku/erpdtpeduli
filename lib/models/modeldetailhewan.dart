// To parse this JSON data, do
//
//     final modeldetailhewan = modeldetailhewanFromJson(jsonString);

import 'dart:convert';

Modeldetailhewan modeldetailhewanFromJson(String str) =>
    Modeldetailhewan.fromJson(json.decode(str));

String modeldetailhewanToJson(Modeldetailhewan data) =>
    json.encode(data.toJson());

class Modeldetailhewan {
  Modeldetailhewan({
    this.id,
    this.idHewan,
    this.kodeHewan,
    this.avaliable,
    this.idVendor,
    this.idMitra,
    this.stock,
    this.sell,
    this.price,
    this.free,
    this.tglLahir,
    this.tipe,
    this.idCabang,
    this.idUserInsert,
    this.status,
    this.yearActive,
    this.video,
    this.foto1,
    this.foto2,
    this.foto3,
    this.foto4,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.mitraName,
    this.namaMuqorib,
  });

  String? id;
  String? idHewan;
  String? kodeHewan;
  String? avaliable;
  String? idVendor;
  String? idMitra;
  String? stock;
  String? sell;
  String? price;
  String? free;
  String? tglLahir;
  String? tipe;
  String? idCabang;
  String? idUserInsert;
  String? status;
  String? yearActive;
  dynamic video;
  dynamic foto1;
  dynamic foto2;
  dynamic foto3;
  dynamic foto4;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? mitraName;
  dynamic namaMuqorib;

  factory Modeldetailhewan.fromJson(Map<String, dynamic> json) =>
      Modeldetailhewan(
        id: json["id"],
        idHewan: json["id_hewan"],
        kodeHewan: json["kode_hewan"],
        avaliable: json["avaliable"],
        idVendor: json["id_vendor"],
        idMitra: json["id_mitra"],
        stock: json["stock"],
        sell: json["sell"],
        price: json["price"],
        free: json["free"],
        tglLahir: json["tgl_lahir"],
        tipe: json["tipe"],
        idCabang: json["id_cabang"],
        idUserInsert: json["id_user_insert"],
        status: json["status"],
        yearActive: json["year_active"],
        video: json["video"],
        foto1: json["foto_1"],
        foto2: json["foto_2"],
        foto3: json["foto_3"],
        foto4: json["foto_4"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        mitraName: json["mitra_name"],
        namaMuqorib: json["nama_muqorib"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_hewan": idHewan,
        "kode_hewan": kodeHewan,
        "avaliable": avaliable,
        "id_vendor": idVendor,
        "id_mitra": idMitra,
        "stock": stock,
        "sell": sell,
        "price": price,
        "free": free,
        "tgl_lahir": tglLahir,
        "tipe": tipe,
        "id_cabang": idCabang,
        "id_user_insert": idUserInsert,
        "status": status,
        "year_active": yearActive,
        "video": video,
        "foto_1": foto1,
        "foto_2": foto2,
        "foto_3": foto3,
        "foto_4": foto4,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "name": name,
        "mitra_name": mitraName,
        "nama_muqorib": namaMuqorib,
      };
}
