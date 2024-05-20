import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class FlutterDownLoaderAndroidAIos extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FlutterDownLoaderAndroidAIos> {
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');


    FlutterDownloader.registerCallback(downloadCallback);
    _requestPermissions();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Downloader Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startDownload,
          child: Text('Start Download'),
        ),
      ),
    );
  }


  void _startDownload() async {
    final taskId = await FlutterDownloader.enqueue(
      url: 'https://tourism.gov.in/sites/default/files/2019-04/dummy-pdf_2.pdf',
      savedDir: '/sdcard/Download',
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );
    print('Download started=======================> : $taskId');
    //https://assets-global.website-files.com/654366841809b5be271c8358/659efd7c0732620f1ac6a1d6_why_flutter_is_the_future_of_app_development%20(1).webp
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  void _requestPermissions() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }


}

