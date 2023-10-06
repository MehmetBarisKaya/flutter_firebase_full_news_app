import 'package:flutter/material.dart';
import 'package:riverpod_project/product/enums/image_size.dart';
import 'package:riverpod_project/product/models/recommended.dart';

class RecommendedCard extends StatelessWidget {
  const RecommendedCard({
    required this.recommendedsItems,
    super.key,
  });

  final Recommended recommendedsItems;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          recommendedsItems.image ?? '',
          height: ImageSizes.normal.value.toDouble(),
          errorBuilder: (context, error, stackTrace) => const Placeholder(),
        ),
        Expanded(
          child: ListTile(
            title: Text(recommendedsItems.name ?? ''),
            subtitle: Text(recommendedsItems.description ?? ''),
          ),
        ),
      ],
    );
  }
}
