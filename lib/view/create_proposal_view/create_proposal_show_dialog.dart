import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'create_proposal_view_table.dart';

class CreateProposalShowDialog extends ConsumerStatefulWidget {
  final int itemIndex;
  const CreateProposalShowDialog({
    super.key,
    required this.itemIndex,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<CreateProposalShowDialog> {
  String? fileName;

  @override
  void initState() {
    // debugPrint('init $fileName');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CreateProposalShowDialog oldWidget) {
    // debugPrint('didUpdate $fileName');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final formItems = ref.read(formItemProvider.notifier);
    // debugPrint('build $fileName');
    return AlertDialog(
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      titlePadding: const EdgeInsets.all(0.0),
      actionsAlignment: MainAxisAlignment.center,
      title: Container(
        width: 450,
        height: 60,
        constraints: const BoxConstraints(
          minWidth: 200,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text('Dosya Yükleme')),
            ),
            // const SizedBox(
            //   width: 100,
            // ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                iconSize: 30,
                color: Theme.of(context).colorScheme.shadow,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
      content: Container(
        height: 100,
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  PlatformFile file = result.files.first;
                  MultipartFile fileToMultipart = MultipartFile.fromBytes(
                    file.bytes!,
                    filename: file.name,
                  );
                  ref
                      .read(formItemProvider.notifier)
                      .updateImage(widget.itemIndex, [fileToMultipart]);

                  setState(() {
                    fileName = file.name;
                    print(fileName);
                    isImageSelected = true;
                    didUpdateWidget(widget);
                  });
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size(120, 40)),
                overlayColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.shadow,
                    ),
                  ),
                ),
              ),
              child: Text('Dosya Ekle',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.shadow,
                      )),
            ),
            if (fileName != null)
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Chip(
                  side: BorderSide.none,
                  // labelPadding: EdgeInsets.all(10),
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  label: Container(
                    height: 30,
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      fileName!,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(120, 45)),
          ),
          onPressed: () {
            setState(() {
              fileName = fileName;
              isImageSelected = true;
              didUpdateWidget(widget);
            });
            Navigator.of(context).pop();
          },
          child: Text(
            'Kaydet',
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ],
    );
  }
}
