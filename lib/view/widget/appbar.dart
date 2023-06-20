import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../storage/jwt_storage.dart';
import '../../view_model/current_user_view_model.dart';
import '../../view_model/logout_view_model.dart';

enum SampleItem { itemOne, itemTwo }

class AppbarTop extends ConsumerWidget implements PreferredSizeWidget {
  const AppbarTop({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsyncValue = ref.watch(getCurrentUserInfoProvider);
    final currentUser = currentUserAsyncValue.maybeWhen(
      data: (data) => data.currentUser,
      orElse: () => null,
    );
    final company = currentUserAsyncValue.maybeWhen(
      data: (data) => data.company,
      orElse: () => null,
    );
    
    double screenWidth = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: MediaQuery.of(context).size.width < 1070,
        title: SvgPicture.asset(
          'assets/paletPointWhite 1.svg',
          semanticsLabel: 'logo',
          width: 180.0,
          fit: BoxFit.fill,
        ),
        actions: <Widget>[
          if (screenWidth > 1070)
            Flexible(
              child: currentUserAsyncValue.when(
                data: (data) => AutoSizeText(
                  company?.name ?? '',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
            ),
          SizedBox(
            width: screenWidth * 0.013,
          ),
          if (screenWidth > 600)
            Flexible(
              child: currentUserAsyncValue.when(
                data: (data) => AutoSizeText(
                  currentUser?.fullName ?? '',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                loading: () => CircularProgressIndicator(),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
            ),
          SizedBox(
            width: screenWidth * 0.013,
          ),
          Flexible(
            child: IconButton(
              icon: Icon(
                Icons.format_list_bulleted,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              tooltip: 'Menu',
              onPressed: () {
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;
                final RelativeRect position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(
                        Offset(button.size.width * 0.75, button.size.height),
                        ancestor: overlay),
                    button.localToGlobal(button.size.bottomRight(Offset.zero),
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );

                showMenu(
                    context: context,
                    position: position,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    items: <PopupMenuEntry<SampleItem>>[
                      const PopupMenuItem<SampleItem>(
                        value: SampleItem.itemOne,
                        child: Text('Çıkış Yap'),
                      ),
                    ]).then((SampleItem? item) async {
                  if (item == SampleItem.itemOne) {
                    final logoutViewModel =
                        ref.read(logoutViewModelProvider.notifier);
                    await logoutViewModel.logout();

                    if (logoutViewModel.state == LogoutState.success) {
                      final _jwt = await jwtStorageService().getJwtData();
                      debugPrint('asasa${_jwt}');
                      
                      Navigator.pushNamed(context, '/login');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Çıkış işlemi başarısız oldu: ${logoutViewModel.errorMessage}')),
                      );
                    }
                  }
                });
              },
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
