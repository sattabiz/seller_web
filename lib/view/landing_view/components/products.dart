import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Products extends StatelessWidget {
  final int sectionIndex;
  final String  ?productDetails;
  final String ?productImage;
  final int ?index;
  const Products({
    Key? key, 
    required this.sectionIndex,
    this.index, this.productDetails, this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 40.0, bottom: 40.0),
      child: Container(
        
        height: 400,
        decoration:  BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20), 
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: ProductTitle(productDetails: productDetails ?? " ",),
            ),
            // SizedBox(width: 50),
            Expanded(
            flex: 6,
            child: ProductImage(productImage: productImage ?? " "),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String ?productDetails;

  const ProductTitle({super.key, this.productDetails});

  @override
  Widget build(BuildContext context) {
    const Color surfaceContainer = Color(0xFFECEEEB);
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: AutoSizeText(productDetails ?? " ",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w400,
          ), maxLines: 4),
    );
  }
  
}

class ProductImage extends StatelessWidget {
  final String ?productImage;
  const ProductImage({super.key, this.productImage});

  static const Color surfaceContainer = Color(0xFFECEEEB);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(60.0),
      alignment: AlignmentDirectional.center,
      constraints: const BoxConstraints(
        maxHeight: 400,
        maxWidth: 200,
      ),
      decoration: const BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
            productImage ?? " ",
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
            fit: BoxFit.cover,
            width: 320,
            height: 320,
          ),
      ),
    );
  }
}
