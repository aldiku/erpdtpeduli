import 'dart:convert';
import 'dart:io';
import '../config.dart';
import 'package:erpdtpeduli/models/modeldetailhewan.dart';
import 'package:flutter/material.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../layout/app_layout.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_saver/file_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HewanDetail extends StatefulWidget {
  String? id;
  String? idHewan;
  String? idCabang;
  String? status;
  String? video;
  String? foto1;
  String? foto2;
  String? foto3;
  String? foto4;
  String? idMitra;
  String? namaMuqorib;
  DateTime? updatedAt;

  HewanDetail(
      {this.id,
      this.idHewan,
      this.idCabang,
      this.status,
      this.video,
      this.foto1,
      this.foto2,
      this.foto3,
      this.foto4,
      this.idMitra,
      this.namaMuqorib,
      this.updatedAt});

  @override
  _HewanDetailState createState() => _HewanDetailState();
}

class _HewanDetailState extends State<HewanDetail> {
  final ImagePicker _picker = ImagePicker();
  late Modeldetailhewan detailhewan;

  bool processing = false;

  final _controllerFirstName = TextEditingController();
  String _FirstName = '';

  @override
  void initState() {
    _controllerFirstName.text = _FirstName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: AppLayout(
        content: SingleChildScrollView(
          child: Column(children: <Widget>[
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
                          child: Text("Foto Sebelum"),
                        ),
                        Row(children: [
                          if (widget.foto1 == '')
                            IconButton(
                                onPressed: () => _selectPhoto('1'),
                                icon: Icon(Icons.add_a_photo)),
                          if (widget.foto1 != '')
                            InkWell(
                              splashColor: Colors.indigo[900],
                              onTap: () => _selectPhoto('1'),
                              child: Container(
                                width: 90.0,
                                height: 60.0,
                                child: Image.network("${widget.foto1}",
                                    width: 90.0,
                                    height: 60.0,
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
                          if (widget.foto2 == '')
                            IconButton(
                                onPressed: () => _selectPhoto('2'),
                                icon: Icon(Icons.add_a_photo)),
                          if (widget.foto2 != '')
                            InkWell(
                              splashColor: Colors.indigo[900],
                              onTap: () => _selectPhoto('2'),
                              child: Container(
                                child: Image.network("${widget.foto2}",
                                    width: 90.0,
                                    height: 60.0,
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
                          if (widget.foto3 == '')
                            IconButton(
                                onPressed: () => _selectPhoto('3'),
                                icon: Icon(Icons.add_a_photo)),
                          if (widget.foto3 != '')
                            InkWell(
                              splashColor: Colors.indigo[900],
                              onTap: () => _selectPhoto('3'),
                              child: Container(
                                child: Image.network("${widget.foto3}",
                                    width: 90.0,
                                    height: 60.0,
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
                          if (widget.foto4 == '')
                            IconButton(
                                onPressed: () => _selectPhoto('4'),
                                icon: Icon(Icons.add_a_photo)),
                          if (widget.foto4 != '')
                            InkWell(
                              splashColor: Colors.indigo[900],
                              onTap: () => _selectPhoto('4'),
                              child: Container(
                                child: Image.network("${widget.foto4}",
                                    width: 90.0,
                                    height: 60.0,
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
                          child: Text("Video"),
                        ),
                        Row(children: [
                          if (widget.video == '')
                            IconButton(
                                onPressed: () => _selectPhoto('4'),
                                icon: Icon(Icons.video_call)),
                          if (widget.foto4 != '')
                            InkWell(
                              splashColor: Colors.indigo[900],
                              onTap: () => _selectPhoto('4'),
                              child: Container(
                                child: Image.network("${widget.video}",
                                    width: 90.0,
                                    height: 60.0,
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
                          child: Text("Nama Muqorib"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              "Foto juga akan tersimpan secara otomatis di folder android/data/com.aplikasi/files setelah di crop"),
                        )
                      ],
                    ),
                  ]),
            ),
            Row(
              children: [Text("Status :"), Text("${widget.status}")],
            ),
            Row(
              children: [Text("Updated At :"), Text("${widget.updatedAt}")],
            ),
          ]),
        ),
      ),
    ));
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<Modeldetailhewan> getData() async {
    Uri url = Uri.parse(Config.getDetailHewan + '/${widget.idHewan}');
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 60) {
      return Modeldetailhewan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load");
    }
  }

  Future _selectPhoto(String num) async {
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
                      _pickImage(ImageSource.camera, num);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.filter),
                    title: Text("Galery"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _pickImage(ImageSource.gallery, num);
                    },
                  )
                ],
              ),
              onClosing: () {},
            ));
  }

  Future _pickImage(ImageSource source, String num) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 58);
    if (pickedFile == null) {
      return;
    }
    // crop gambar ke format landscape 16:9
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
    if (file == null) {
      return;
    }

    //compress gambar ke ukuran kecil dengan kualitas standar
    var compress =
        await handleCompressImage(file.path, file.readAsBytesSync(), num);
    await _uploadFile(file.path, num, file.readAsBytesSync());
    final snackBar = SnackBar(
      content: const Text('Berhasil Disimpan, dan Diupload!'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future handleCompressImage(String path, bytes, String num) async {
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

    //simpan file setelah compress di hp di folder android/data/com.example.erpdtpeduli/files
    await FileSaver.instance.saveFile(
        "${widget.idHewan}-foto" + num, bytes, '.jpg',
        mimeType: MimeType.JPEG);
    return output;
  }

  Future _uploadFile(String path, String num, byte) async {
    final SharedPreferences prefs = await _prefs;
    var token = prefs.getString('token');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(Config.HewanUpload));
    request.headers["authorization"] = "Bearer " + token!;
    request.headers.addAll(headers);
    request.fields.addAll({
      'idHewan': '${widget.idHewan}',
      'name': 'foto_' + num,
      'overwrite': '1',
      'idMitra': '${widget.idMitra}'
    });
    request.files.add(await http.MultipartFile.fromPath('file', path,
        contentType: MediaType('image', 'jpg')));
    http.StreamedResponse streamResponse = await request.send();
    final response = await http.Response.fromStream(streamResponse);
    if (response.statusCode == 60) {
      var resMap = jsonDecode(response.body);
      debugPrint(response.body);
      return resMap;
    } else {
      var resMap = jsonDecode(response.body);
      debugPrint(response.body);
      return resMap;
    }
  }
}
