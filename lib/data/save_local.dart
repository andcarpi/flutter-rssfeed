import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SaveLocal {
  final List feedList;
  SaveLocal({this.feedList});

  Future<File> get fileFeed async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File(dir.path + "/feeds.json");
    if (!file.existsSync()) {
      await file.writeAsString(json.encode([]));
    }

    return file;
  }

  read () async {
    final File file = await fileFeed;
    String data = file.readAsStringSync();
    return json.decode(data);
  }

  save(data) async {
    final File file = await fileFeed;
    return file.writeAsStringSync(json.encode(data));
    
  }
}