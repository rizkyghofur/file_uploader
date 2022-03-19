import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class AmbilFile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AmbilFile();
  }
}

class _AmbilFile extends State<AmbilFile> {
  FilePickerResult selectedfile;
  Response response;
  String progress;
  Dio dio = new Dio();

  fileTerpilih() async {
    selectedfile = await FilePicker.platform.pickFiles();
    setState(() {});
  }

  unggahFile() async {
    String uploadurl = "https://file.io/";

    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(selectedfile.files.single.path,
          filename: basename(selectedfile.files.single.path)),
    });

    response = await dio.post(
      uploadurl,
      data: formdata,
      onSendProgress: (int terkirim, int total) {
        String persentase = (terkirim / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$terkirim" +
              " bit " "$total bit - " +
              persentase +
              " % terupload";
        });
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());
    } else {
      print("Error during connection to server.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih File dan Upload"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: progress == null
                  ? Text("Persentase: 0%")
                  : Text(
                      basename("Persentase: $progress"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: selectedfile == null
                  ? Text("Belum ada file terpilih")
                  : Text(
                      basename(selectedfile.files.single.path),
                    ),
            ),
            Container(
              // ignore: deprecated_member_use
              child: RaisedButton.icon(
                onPressed: () {
                  fileTerpilih();
                },
                icon: Icon(Icons.folder_open),
                label: Text("Pilih File"),
                color: Colors.blueAccent,
                colorBrightness: Brightness.dark,
              ),
            ),
            selectedfile == null
                ? Container()
                : Container(
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                      onPressed: () {
                        unggahFile();
                      },
                      icon: Icon(Icons.folder_open),
                      label: Text("Upload File"),
                      color: Colors.blueAccent,
                      colorBrightness: Brightness.dark,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
