import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageToBase64Provider = StateNotifierProvider.autoDispose<SelectedFilesNotifier, List<MultipartFile>>((ref) {
  return SelectedFilesNotifier();
});
final imagePathProvider = StateNotifierProvider.autoDispose<SelectedNameNotifier, List<String>>((ref) {
  return SelectedNameNotifier();
});
class SelectedNameNotifier extends StateNotifier<List<String>> {
  SelectedNameNotifier() : super([]);

  void addFile(String file) {
    state = [...state, file];
  }

  void clearFiles() {
    state = [];
  }
}

class SelectedFilesNotifier extends StateNotifier<List<MultipartFile>> {
  SelectedFilesNotifier() : super([]);

  void addFile(MultipartFile file) {
    state = [...state, file];
  }

  void clearFiles() {
    state = [];
  }
}

class CreateProposalShowDialog extends ConsumerWidget {
const CreateProposalShowDialog({ Key? key }) : super(key: key);
@override
  Widget build(BuildContext context, WidgetRef ref) {
return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Dosya Yükleme'),
              const SizedBox(
                width: 100,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          content: Row(
            children: [
              InkWell(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: true);
                  if (result != null && result.files.isNotEmpty) {
                    List<MultipartFile> imageToBase64 = result.files            //convert image to base64 
                        .map((file) => MultipartFile.fromBytes(
                              file.bytes as List<int>,
                              filename: base64Encode(file.bytes as List<int>),
                            ))
                        .toList();
                    List<String> filenames = result.files.map((file) => file.name).toList();      //take image path name              
                    if (imageToBase64 != null) {
                      
                    }
                  }
                },
                child: Container(
                  width: 85,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all()),
                  child: const Center(
                    child: Text('Dosya Ekle'),
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Kaydet'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}


//Boyut ayarlama, 5mb limitleme
//jpg ve pdf