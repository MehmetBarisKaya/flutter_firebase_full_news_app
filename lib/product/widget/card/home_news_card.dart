// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:riverpod_project/product/constant/color_constant.dart';
import 'package:riverpod_project/product/enums/widget_size.dart';
import 'package:riverpod_project/product/models/news_model.dart';
import 'package:riverpod_project/product/widget/text/sub_title_text.dart';

class HomeNewsCard extends StatelessWidget {
  const HomeNewsCard({
    required this.newsItem,
    super.key,
  });

  final News? newsItem;

  @override
  Widget build(BuildContext context) {
    if (newsItem == null) return const SizedBox.shrink();
    return Stack(
      children: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: Image.network(
            newsItem!.backgroundImage ?? '',
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.padding.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_add_rounded,
                    color: ColorConstant.white,
                    size: WidgetSize.iconNormal.value.toDouble(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: context.padding.low,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubTitleText(
                        subTitle: newsItem!.category ?? '',
                        color: ColorConstant.grayLighter,
                      ),
                      Text(
                        newsItem!.title ?? '',
                        style:
                            context.general.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
