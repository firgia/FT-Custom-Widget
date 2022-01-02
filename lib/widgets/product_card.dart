import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

part 'product_card.builder.dart';
part 'product_card.item.dart';

class ProductCardData {
  final ImageProvider image;
  final String name;
  final String location;
  final double price;

  const ProductCardData({
    required this.image,
    required this.name,
    required this.location,
    required this.price,
  });
}

class ProductCard extends _ProductCardGenerator {
  const ProductCard({
    required ProductCardData data,
    required Function() onPressed,
    Key? key,
  }) : super(
          isLoading: false,
          useBuilder: false,
          data: data,
          onPressed: onPressed,
          key: key,
        );

  const ProductCard.loading({Key? key})
      : super(
          isLoading: true,
          useBuilder: false,
          key: key,
        );

  const ProductCard.builder({
    required List<ProductCardData> data,
    required Function(int index, ProductCardData data) onPressed,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    String? label,
    Key? key,
  }) : super(
          isLoading: false,
          useBuilder: true,
          label: label,
          builderData: data,
          builderOnPressed: onPressed,
          shrinkWrap: shrinkWrap,
          physics: physics,
          key: key,
        );

  const ProductCard.loadingBuilder({
    required int total,
    bool shrinkWrap = false,
    ScrollPhysics? physics,
    String? label,
    Key? key,
  }) : super(
          isLoading: true,
          useBuilder: true,
          label: label,
          builderTotalItemLoading: total,
          shrinkWrap: shrinkWrap,
          physics: physics,
          key: key,
        );
}

class _ProductCardGenerator extends StatelessWidget {
  const _ProductCardGenerator({
    required this.useBuilder,
    required this.isLoading,
    this.label,
    this.data,
    this.onPressed,
    this.builderData,
    this.builderOnPressed,
    this.builderTotalItemLoading,
    this.shrinkWrap,
    this.physics,
    Key? key,
  }) : super(key: key);

  final bool isLoading;
  final bool useBuilder;

  /* ---------------------------> SINGLE WIDGET <---------------------------- */
  final ProductCardData? data;
  final Function()? onPressed;

  /* ------------------------------> BUILDER <------------------------------- */
  final String? label;
  final List<ProductCardData>? builderData;
  final Function(int index, ProductCardData data)? builderOnPressed;
  final int? builderTotalItemLoading;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    if (useBuilder) {
      if (isLoading) {
        assert(
          builderTotalItemLoading != null,
          "builderTotalItemLoading is required",
        );
      } else {
        assert(
          builderData != null && builderOnPressed != null,
          "builderData And builderOnPressed is required",
        );
      }
    } else if (!isLoading) {
      assert(
        data != null && onPressed != null,
        "data And onPressed is required",
      );
    }

    return (useBuilder)
        ? (isLoading)
            ? _LoadingBuilder(
                total: builderTotalItemLoading!,
                shrinkWrap: shrinkWrap ?? false,
                label: label,
                physics: physics,
              )
            : _Builder(
                data: builderData!,
                label: label,
                onPressed: builderOnPressed!,
                shrinkWrap: shrinkWrap ?? false,
                physics: physics,
              )
        : (isLoading)
            ? const _ItemLoading()
            : _Item(data: data!, onPressed: onPressed!);
  }
}
