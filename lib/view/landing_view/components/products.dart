
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/get_current_user_info_model.dart';
import '../../../view_model/current_user_landing_page.dart';

class Products extends ConsumerWidget {
  final int sectionIndex;
  const Products({Key? key, required this.sectionIndex}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const Color surfaceContainer = Color(0xFFECEEEB);

    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Container(
            decoration: const BoxDecoration(
              color: surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ProductTitle(),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: _ProductDetailState(),
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(width: 50),
        const Expanded(
          flex: 6,
          child: ProductImage(),
        ),
      ],
    );
  }
}

class ProductTitle extends ConsumerStatefulWidget {
  const ProductTitle({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductTitleState();
}

class _ProductTitleState extends ConsumerState<ProductTitle> {
  @override
  Widget build(BuildContext context) {
    return AutoSizeText("Palet Point",
        style: Theme.of(context).textTheme.displayMedium, maxLines: 2);
  }
}

class _ProductDetailState extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoFuture = ref.watch(getCurrentUserLandingProvider);
    return userInfoFuture.when(
      data: (CurrentUserInfoModel data) {
        final user = data.currentUser;
        final company = data.company;

        // return user and company object
        final userProperties = user!.toMap().values.toList();
        final companyProperties = company!.toMap().values.toList();

        return ListView(
          children: [
            Text(
              "User Info:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Wrap(
              spacing: 8.0, 
              runSpacing: 4.0, 
              children: userProperties
                  .map(
                    (prop) => Text('${prop.toString()},',
                        style: Theme.of(context).textTheme.bodySmall),
                  )
                  .toList(),
            ),
            Text(
              "Company Info:",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0, 
              children: companyProperties
                  .map(
                    (prop) => Text('${prop.toString()},',
                        style: Theme.of(context).textTheme.bodySmall),
                  )
                  .toList(),
            ),
          ],
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}
class ProductImage extends ConsumerStatefulWidget {
  const ProductImage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductImageState();
}

class _ProductImageState extends ConsumerState<ProductImage> {
  static const Color surfaceContainer = Color(0xFFECEEEB);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60.0),
      decoration: const BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Image.asset(
        'assets/images/product_image.jpg',
        fit: BoxFit.contain,
      ),
    );
  }
}