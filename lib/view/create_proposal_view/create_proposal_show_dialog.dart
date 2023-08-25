import 'dart:developer';
import 'dart:html' as html;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider = StateProvider<List<File>>((ref) {
  return [];
});

final imagenameProvider =
    StateNotifierProvider.autoDispose<SelectedNameNotifier, List<String>>(
        (ref) {
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

class SelectedFilesNotifier extends StateNotifier<List<String>> {
  SelectedFilesNotifier() : super([]);

  void addFile(String file) {
    state = [...state, file];
  }

  void clearFiles() {
    state = [];
  }
}

class CreateProposalShowDialog extends StatefulWidget {
  CreateProposalShowDialog({Key? key}) : super(key: key);

  @override
  State<CreateProposalShowDialog> createState() =>
      _CreateProposalShowDialogState();
}

class _CreateProposalShowDialogState extends State<CreateProposalShowDialog> {
  List<PlatformFile>? _paths;
  List<Uint8List> pickedImagesInBytes = [];
  Future<String?> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      onFileLoading: (status) => print(status),
      allowedExtensions: ['pdf', 'jpg', 'png'],
    );

    result!.files.forEach((element) {
      setState(() {
        pickedImagesInBytes.add(element.bytes!);
        //selectedImageInBytes = fileResult.files.first.bytes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
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
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    ref.read(imageProvider.notifier).state = [file];
                  } else {
                    // User canceled the picker
                  }
                  /* List<FormItem> _formItems = await ref.watch(formItemProvider);
                  OfferModel _contentItems =
                      await ref.watch(offerModelProvider);
                  try {
                    _paths = (await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowMultiple: false,
                      onFileLoading: (FilePickerStatus status) => print(status),
                      allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
                    ))
                        ?.files;
                  } on PlatformException catch (e) {
                    log('Unsupported operation' + e.toString());
                  } catch (e) {
                    log(e.toString());
                  }
                  setState(() {
                    if (_paths != null) {
                      if (_paths != null) {
                        //passing file bytes and file name for API call
                        debugPrint(_paths!.first.path!);
                        PostService.uploadFile(
                            _paths!.first.path!, _paths!.first.name,_formItems, _contentItems);
                      }
                    }
                  }); */
                  /* var result = await uploadFile();                                        ///////////////calisan kisim
                  ref.read(imageProvider.notifier).state = pickedImagesInBytes;
                  final bytes = Uint8List.fromList([
                    137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68,
                    82, 0, 0, 0,
                    1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137, 0, 0, 0, 10,
                    73, 68, 65,
                    84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1, 13, 10, 45, 180, 0,
                    0, 0, 0, 73,
                    69, 78, 68, 174, 66, 96, 130 // prevent dartfmt
                  ]);

                  // copy from decodeImageFromList of package:flutter/painting.dart
                  final codec = await instantiateImageCodec(bytes);
                  final frameInfo = await codec.getNextFrame();
                  var x = frameInfo.image; */ //////////////////////////////////////////calisan kisim
                  /* List<html.File>? imageFiles =
                    await ImagePickerWeb.getMultiImagesAsFile();
                final formData = FormData.fromMap({
                  'file':
                      imageFiles! // <------ I guess this is where the issue is, I also tried file instead of File(file.name)
                });  */

                  /* FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp4', 'mkv'],
                );
                if (result != null) {
                  PlatformFile file = result.files.first;
    
                  print(file.name);
                  print(file.bytes);
                  print(file.size);
                  print(file.extension);
                  print(file.path);
                  var multipartFile = await MultipartFile.fromFile(
                    file.path!,
                  );
                  FormData formData = FormData.fromMap({
                    "image": multipartFile, //define your json data here
                  }); */
                  /* debugPrint(formData.toString());
                  ref.read(imageProvider.notifier).state = formData; */
                  /* try {
                  _paths = (await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowMultiple: false,
                    onFileLoading: (FilePickerStatus status) => print(status),
                    allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
                  ))
                      ?.files;
                } on PlatformException catch (e) {
                  log('Unsupported operation' + e.toString());
                } catch (e) {
                  log(e.toString());
                }
                setState(() {
                  if (_paths != null) {
                    if (_paths != null) {
                      //passing file bytes and file name for API call
                      ApiClient.uploadFile(
                          _paths!.first.bytes!, _paths!.first.name);
                    }
                  }
                }); */
                  /* FilePickerResult? result = await FilePicker.platform.pickFiles();
    
                if (result != null) {
                  Uint8List fileBytes = result.files.first.bytes!;
                  String fileName = result.files.first.name;
    
                  // Upload file
                  await FirebaseStorage.instance
                      .ref('uploads/$fileName')
                      .putData(fileBytes);
                } */
                  /* FilePickerResult? result = await FilePicker.platform
                    .pickFiles(type: FileType.image, allowMultiple: true);
                if (result != null && result.files.isNotEmpty) {
                   List<MultipartFile> imageToBase64 = result.files            //convert image to base64 
                          .map((file) => MultipartFile.fromBytes(
                                file.bytes as List<int>,
                                filename: base64Encode(file.bytes as List<int>),   //iki defa encode olmadigina emin olun
                              ))
                          .toList(); 
                  List<String> filenames = result.files
                      .map((file) => file.name)
                      .toList(); //take image path name
                  List<String> imageToBase64 = result.files
                      .map((file) => base64Encode(file.bytes as List<int>))
                      .toList();
                  List<String> image = result.files
                      .map((file) => file.extension as String)
                      .toList();
                  for (int i = 0; i < image.length; i++) {
                     debugPrint(image[i].toString());
                  }
                  ref
                        .read(imageToBase64Provider.notifier).state = image;
                  ref
                        .read(imagePathProvider.notifier).state = filenames;
                  if (imageToBase64 != null) {}
                } 
               /*  List<File>? imageFiles = await .getMultiImagesAsFile();
                debugPrint(imageFiles.toString());
                ref.read(imagePathProvider.notifier).state = imageFiles!; */ */
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
                /* ref.watch(createImageProvider); */
              },
            ),
          ],
        );
      },
      /* child: AlertDialog(
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
                List<html.File>? imageFiles =
                    await ImagePickerWeb.getMultiImagesAsFile();
                final formData = FormData.fromMap({
                  'file':
                      imageFiles! // <------ I guess this is where the issue is, I also tried file instead of File(file.name)
                }); 
                /* FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp4', 'mkv'],
                );
                if (result != null) {
                  PlatformFile file = result.files.first;
    
                  print(file.name);
                  print(file.bytes);
                  print(file.size);
                  print(file.extension);
                  print(file.path);
                  var multipartFile = await MultipartFile.fromFile(
                    file.path!,
                  );
                  FormData formData = FormData.fromMap({
                    "image": multipartFile, //define your json data here
                  }); */
                  debugPrint(formData.toString());
                  ref.read(imageProvider.notifier).state = formData;
                  /* try {
                  _paths = (await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowMultiple: false,
                    onFileLoading: (FilePickerStatus status) => print(status),
                    allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
                  ))
                      ?.files;
                } on PlatformException catch (e) {
                  log('Unsupported operation' + e.toString());
                } catch (e) {
                  log(e.toString());
                }
                setState(() {
                  if (_paths != null) {
                    if (_paths != null) {
                      //passing file bytes and file name for API call
                      ApiClient.uploadFile(
                          _paths!.first.bytes!, _paths!.first.name);
                    }
                  }
                }); */
                  /* FilePickerResult? result = await FilePicker.platform.pickFiles();
    
                if (result != null) {
                  Uint8List fileBytes = result.files.first.bytes!;
                  String fileName = result.files.first.name;
    
                  // Upload file
                  await FirebaseStorage.instance
                      .ref('uploads/$fileName')
                      .putData(fileBytes);
                } */
                  /* FilePickerResult? result = await FilePicker.platform
                    .pickFiles(type: FileType.image, allowMultiple: true);
                if (result != null && result.files.isNotEmpty) {
                   List<MultipartFile> imageToBase64 = result.files            //convert image to base64 
                          .map((file) => MultipartFile.fromBytes(
                                file.bytes as List<int>,
                                filename: base64Encode(file.bytes as List<int>),   //iki defa encode olmadigina emin olun
                              ))
                          .toList(); 
                  List<String> filenames = result.files
                      .map((file) => file.name)
                      .toList(); //take image path name
                  List<String> imageToBase64 = result.files
                      .map((file) => base64Encode(file.bytes as List<int>))
                      .toList();
                  List<String> image = result.files
                      .map((file) => file.extension as String)
                      .toList();
                  for (int i = 0; i < image.length; i++) {
                     debugPrint(image[i].toString());
                  }
                  ref
                        .read(imageToBase64Provider.notifier).state = image;
                  ref
                        .read(imagePathProvider.notifier).state = filenames;
                  if (imageToBase64 != null) {}
                } 
               /*  List<File>? imageFiles = await .getMultiImagesAsFile();
                debugPrint(imageFiles.toString());
                ref.read(imagePathProvider.notifier).state = imageFiles!; */ */
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
              ref.watch(createImageProvider);
            },
          ),
        ],
      ), */
    );
  }
}

//Boyut ayarlama, 5mb limitleme
//jpg ve pdf
