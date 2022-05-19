import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../layout/app_layout.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_saver/file_saver.dart';

class HewanDetail extends StatefulWidget {
  String? id;
  String? idHewan;
  String? price;
  String? idCabang;
  String? status;
  String? video;
  String? foto1;
  String? foto2;
  String? foto3;
  String? foto4;
  String? mitraName;
  String? namaMuqorib;
  DateTime? updatedAt;

  HewanDetail(
      {this.id,
      this.idHewan,
      this.price,
      this.idCabang,
      this.status,
      this.video,
      this.foto1,
      this.foto2,
      this.foto3,
      this.foto4,
      this.mitraName,
      this.namaMuqorib,
      this.updatedAt});

  @override
  _HewanDetailState createState() => _HewanDetailState();
}

class _HewanDetailState extends State<HewanDetail> {
  final ImagePicker _picker = ImagePicker();

  bool processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: AppLayout(
        content: Column(children: <Widget>[
          Container(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
                Text("${widget.idHewan}"),
              ],
            ),
          ),
          Card(
            child: Table(
                // border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(64),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Nama Muqorib"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("${widget.namaMuqorib}"),
                      )
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Nama Mitra"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("${widget.mitraName}"),
                      )
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Harga Hewan"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("${widget.price}"),
                      )
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Foto Sebelum"),
                      ),
                      Row(children: [
                        if (widget.foto1 != null)
                          InkWell(
                            splashColor: Colors.indigo[900],
                            onTap: () => _selectPhoto(),
                            child: Container(
                              width: 150.0,
                              height: 100.0,
                              child: Image.network(
                                  "https://qurban.dtpeduli.org/uploads/laporan/${widget.foto1}",
                                  width: 150.0,
                                  height: 100.0,
                                  fit: BoxFit.cover),
                            ),
                          )
                      ])
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Foto Sesudah"),
                      ),
                      Row(children: [
                        if (widget.foto2 == null)
                          IconButton(
                              onPressed: () => _selectPhoto(),
                              icon: Icon(Icons.add_a_photo)),
                        if (widget.foto2 != null)
                          InkWell(
                            splashColor: Colors.indigo[900],
                            onTap: () => _selectPhoto(),
                            child: Container(
                              child: Image.network(
                                  "https://qurban.dtpeduli.org/uploads/laporan/${widget.foto2}",
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover),
                            ),
                          )
                      ])
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Foto Suasana"),
                      ),
                      Row(children: [
                        if (widget.foto3 == null)
                          IconButton(
                              onPressed: () => _selectPhoto(),
                              icon: Icon(Icons.add_a_photo)),
                        if (widget.foto3 != null)
                          InkWell(
                            splashColor: Colors.indigo[900],
                            onTap: () => _selectPhoto(),
                            child: Container(
                              child: Image.network(
                                  "https://qurban.dtpeduli.org/uploads/laporan/${widget.foto3}",
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover),
                            ),
                          )
                      ])
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Foto Penyaluran"),
                      ),
                      Row(children: [
                        if (widget.foto4 == null)
                          IconButton(
                              onPressed: () => _selectPhoto(),
                              icon: Icon(Icons.add_a_photo)),
                        if (widget.foto4 != null)
                          InkWell(
                            splashColor: Colors.indigo[900],
                            onTap: () => _selectPhoto(),
                            child: Container(
                              child: Image.network(
                                  "https://qurban.dtpeduli.org/uploads/laporan/${widget.foto4}",
                                  width: 300.0,
                                  height: 200.0,
                                  fit: BoxFit.cover),
                            ),
                          )
                      ])
                    ],
                  ),
                ]),
          ),
          Row(
            children: [Text("Video :"), Text("${widget.video}")],
          ),
          Row(
            children: [Text("Status :"), Text("${widget.status}")],
          ),
          Row(
            children: [Text("Updated At :"), Text("${widget.updatedAt}")],
          ),
        ]),
      ),
    ));
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Galery"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery);
                    },
                  )
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 58);
    if (pickedFile == null) {
      return;
    }
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
    if (file == null) {
      return;
    }
    // file = await compressImage(file.path, 35);
    var compress = await handleCompressImage(file.path, file.readAsBytesSync());
    await _uploadFile(file.path);
  }

  // Future<File> compressImage(String path, int quality) async {

  //   Configuration config = Configuration(
  //     outputType: ImageOutputType.webpThenJpg,
  //     useJpgPngNativeCompressor: false,
  //     quality: 40,
  //   );
  // final newPath = p.join((await getTemporaryDirectory()).path,
  //     '${DateTime.now()}.${p.extension(path)}');
  // final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
  //     quality: quality);
  // return result!;
  // }
  Future handleCompressImage(String path, bytes) async {
    setState(() {
      processing = true;
    });
    Configuration config = Configuration(
      outputType: ImageOutputType.webpThenJpg,
      useJpgPngNativeCompressor: false,
      quality: 40,
    );
    final param = ImageFileConfiguration(
        input: ImageFile(filePath: path, rawBytes: bytes), config: config);
    final output = await compressor.compress(param);
    await FileSaver.instance
        .saveFile("Hewan", bytes, '.jpg', mimeType: MimeType.JPEG);
    return output;
    // final Uint8List bytes = await _readFileByte(output);
  }

  Future _uploadFile(String path) async {
    // String name = "hewantest";
    print("fungsi upload jalan");
    return "sukses";
  }

  // Future<Uint8List> _readFileByte(File file) async {
  //   Uint8List bytes;
  //   await file.readAsBytes().then((value) {
  //     return  Uint8List.fromList(value);
  //   });
  // }
}
