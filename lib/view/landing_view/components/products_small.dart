import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ProductsSmall extends StatelessWidget {
  final int sectionIndex;
  final int ?index;
  final String ?title;
  final String ?productDetails;
  final String ?productImage;

  const ProductsSmall({
    Key? key, 
    required this.sectionIndex,
    this.index,
    this.title,
    this.productDetails,
    this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 80.0, right: 80.0, top: 40.0, bottom: 40.0),
      child: Container(
        height: 400,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          shadows:[ 
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              offset: const Offset(0, 12),
              blurRadius: 20,
            ),
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: ProductImage(productImage: productImage ?? " "),
            ),
            Expanded(
              flex: 6,
              child: ProductTitle(
                title: title ?? " ",
                productDetails: productDetails ?? " "
              ),
            ),
            // SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String ?productDetails;
  final String ?title;

  const ProductTitle({super.key, this.productDetails, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentGeometry.lerp(Alignment.topCenter, Alignment.center, 2.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(height: 30),
          AutoSizeText(title ?? " ",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            minFontSize: 10,  
          ),
          AutoSizeText(productDetails ?? " ",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
            minFontSize: 8, 
          ),
        ], 
      ),
    );
  }
  
}

class ProductImage extends StatelessWidget {
  final String ?productImage;
  const ProductImage({super.key, this.productImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(30.0),
      alignment: AlignmentDirectional.center,
      constraints: const BoxConstraints(
        maxHeight: 400,
        maxWidth: 300,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        child: Image.network(
            productImage ?? " ",
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
            fit: BoxFit.cover,
            width: 360,
            height: 360,
          ),
      ),
    );
  }
}
