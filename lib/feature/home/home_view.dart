// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

import 'package:riverpod_project/feature/home/home_provider.dart';
import 'package:riverpod_project/feature/home/sub_view/home_search_delegate.dart';
import 'package:riverpod_project/product/constant/color_constant.dart';
import 'package:riverpod_project/product/constant/string_constant.dart';
import 'package:riverpod_project/product/models/news_model.dart';
import 'package:riverpod_project/product/models/tag.dart';
import 'package:riverpod_project/product/utility/exception/custom_excepiton.dart';
import 'package:riverpod_project/product/utility/firebase/firebase_collections.dart';
import 'package:riverpod_project/product/widget/card/home_news_card.dart';
import 'package:riverpod_project/product/widget/card/recommended_card.dart';
import 'package:riverpod_project/product/widget/text/sub_title_text.dart';
import 'package:riverpod_project/product/widget/text/title_text.dart';

part './sub_view/home_chips.dart';
part 'sub_view/home_news_list_view.dart';

final _homeProvider = StateNotifierProvider<HomeProvider, HomeState>((ref) {
  return HomeProvider();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(_homeProvider.notifier).fetchAndLoad();
      ref.read(_homeProvider.notifier).addListener(
        (state) {
          if (state.selectedTag != null) {
            _controller.text = state.selectedTag?.name ?? '';
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.padding.normal,
        child: Stack(
          children: [
            ListView(
              children: [
                const _Header(),
                _CustomField(_controller),
                const _TagListView(),
                const _BrowseHoorizontalListView(),
                Padding(
                  padding: context.padding.onlyTopLow,
                  child: const _RecommendedHeader(),
                ),
                const _RecommendedListView(),
              ],
            ),
            if (ref.watch(_homeProvider).isLoading ?? false)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

class _CustomField extends ConsumerWidget {
  const _CustomField(
    this.controller,
  );
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onTap: () async {
        final response = await showSearch<Tag?>(
          context: context,
          delegate: HomeSearchDelegate(
            ref.read(_homeProvider.notifier).fullTaglist,
          ),
        );
        ref.read(_homeProvider.notifier).updateSelectedTag(response);
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        suffixIcon: Icon(Icons.mic_outlined),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: ColorConstant.grayLighter,
        hintText: StringConstant.homeSearchHint,
      ),
    );
  }
}

class _TagListView extends ConsumerWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagItems = ref.watch(_homeProvider).tags ?? [];

    return SizedBox(
      height: context.sized.dynamicHeight(0.1),
      child: ListView.builder(
        itemCount: tagItems.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tag = tagItems[index];
          if (tag.active ?? false) {
            return _ActiveChip(tag);
          } else {}

          return _PassiveChip(tag);
        },
      ),
    );
  }
}

class _BrowseHoorizontalListView extends ConsumerWidget {
  const _BrowseHoorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItems = ref.watch(_homeProvider).news;
    return SizedBox(
      height: context.sized.dynamicHeight(0.3),
      child: ListView.builder(
        itemCount: newsItems?.length ?? 0,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return HomeNewsCard(newsItem: newsItems?[index]);
        },
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: TitleText(title: StringConstant.homeTitle),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(StringConstant.homeSeeAll),
        ),
      ],
    );
  }
}

class _RecommendedListView extends ConsumerWidget {
  const _RecommendedListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendedsItems = ref.watch(_homeProvider).recommendeds ?? [];
    return ListView.builder(
      itemCount: recommendedsItems.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: context.padding.onlyTopLow,
          child: RecommendedCard(recommendedsItems: recommendedsItems[index]),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: StringConstant.homeBrowse),
        Padding(
          padding: context.padding.onlyTopLow,
          child: const SubTitleText(subTitle: StringConstant.homeMessage),
        ),
      ],
    );
  }
}
