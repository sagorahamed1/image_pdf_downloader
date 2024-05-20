import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../flutter_downloader/flutter_downloader.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController urlflutterFileDownloaderController =
      TextEditingController();
  TextEditingController urlFlutterDoownloaderController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Home Screen"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextFormField(
              controller: urlflutterFileDownloaderController,
              decoration: const InputDecoration(
                  hintText: "enter Url", enabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                FileDownloader.downloadFile(
                  url: urlflutterFileDownloaderController.text,
                  onDownloadError: (errorMessage) {
                    print("======<<< >> $errorMessage");
                  },
                  onDownloadCompleted: (path) {
                    print("======>>> $path");
                  },
                );
                urlflutterFileDownloaderController.clear();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                    child: Text(
                  "Download File",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                var result = await FilePicker.platform.pickFiles();
                if (result == null) {
                  return;
                } else {
                  final file = result.files.first;
                  openFile(file);
                }
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                    child: Text(
                  "Pic File ",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () async {
               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  FlutterDownLoaderAndroidAIos()));
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                    child: Text(
                  "Flutter Downloader Android And IOS",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<void> startDownload(String url, String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String savedDir = '${directory.path}/downloads';

    Directory(savedDir).createSync(recursive: true);

     await FlutterDownloader.enqueue(
      url: url,
      savedDir: savedDir,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification:
          true,
    );
  }
}
