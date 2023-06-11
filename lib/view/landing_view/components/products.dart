import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Products extends ConsumerWidget {
  final int sectionIndex;
  const Products({Key? key, required this.sectionIndex})
    : super(key: key);

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
              children:  const <Widget>[
                ProductTitle(),               
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60.0, right: 20.0),
                    child: ProductDetail(),
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
    return  AutoSizeText(
      "Palet Point", 
      style: Theme.of(context).textTheme.displayMedium, 
      maxLines: 2
    );
  }
}

class ProductDetail extends ConsumerStatefulWidget {
  const ProductDetail({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {

  @override
  Widget build(BuildContext context) {
    const productDetails = "Glopal Pallet Company is committed to ensure safe transportation of your products while helping you lower your packaging costs. Driven with this purpose, we provide the best quality hardwood, softwood and combo pallets with high load-bearing capacity. We can custom design any size pallets to perfectly meet the specific needs of your products.  Our experts will be happy to assist you in identifying the perfect size and material that will help you save space and packaging costs.All products can be Heat Treated to meet ISPM-15 specifications. Heat Treat certificates are available upon request.";
    return AutoSizeText(
      productDetails,
      softWrap: true,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.titleLarge, 
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