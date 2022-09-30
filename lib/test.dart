import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q4k/constants.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  // 1- crating firebase
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  // final island = FirebaseStorage.instance.ref();

  // final appDocDir = await getApplicationDocumentsDirectory();
  // final path = '${appDocDir.path}/${island.name}';
  // 2- calling files
  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance
        .ref('/material/web_programming/audio')
        .listAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: const Text('Download'),
      ),
      body: FutureBuilder<ListResult>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some error occured'),
                  );
                } else {
                  final files = snapshot.data!.items;
                  return Column(
                    children: [
                      buildHeader(files.length),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          final file = files[index];

                          return ListTile(
                            title: Text(file.name),
                          );
                        },
                        itemCount: files.length,
                      ))
                    ],
                  );
                }
            }
          }),
    );
  }

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        title: Text(
          '$length Files',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        leading: Container(
          width: 52,
          height: 52,
          child: const Icon(
            Icons.copy,
            color: Colors.white,
          ),
        ),
      );

  // trying documentation
  Future downloadFile(int index, Reference ref) async {
    //   final ref = FirebaseStorage.instance.ref();

    //   final dir = await getApplicationDocumentsDirectory();
    //   final file = File('${dir.path}/${ref.name}');
    //   await ref.writeToFile(file);

    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Text(
    //       'Downloaded ${ref.name}',
    //     )),
    //   );
  }
}
