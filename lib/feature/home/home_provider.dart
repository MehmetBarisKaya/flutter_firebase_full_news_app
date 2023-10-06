// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_project/product/models/index.dart';
import 'package:riverpod_project/product/utility/firebase/firebase_collections.dart';
import 'package:riverpod_project/product/utility/firebase/firebase_utility.dart';

class HomeProvider extends StateNotifier<HomeState> with FirebaseUtility {
  HomeProvider() : super(const HomeState());

  List<Tag> _fullTaglist = [];

  // ignore: unnecessary_getters_setters
  List<Tag> get fullTaglist => _fullTaglist;

  set fullTaglist(List<Tag> value) {
    _fullTaglist = value;
  }

  Future<void> _fetchNews() async {
    final newsCollectionReference = FirebaseCollections.news.reference;
    final response = await newsCollectionReference.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();
    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(news: values);
    }
  }

  Future<void> _fetchTags() async {
    final tagItems =
        await fetchList<Tag, Tag>(const Tag(), FirebaseCollections.tag);
    state = state.copyWith(tags: tagItems);
    _fullTaglist = tagItems ?? [];

    // final newsCollectionReference = FirebaseCollections.tag.reference;
    // final response = await newsCollectionReference.withConverter<Tag>(
    //   fromFirestore: (snapshot, options) {
    //     return const Tag().fromFirebase(snapshot);
    //   },
    //   toFirestore: (value, options) {
    //     return value.toJson();
    //   },
    // ).get();
    // if (response.docs.isNotEmpty) {
    //   final values = response.docs.map((e) => e.data()).toList();
    //   state = state.copyWith(tags: values);
    // }
  }

  Future<void> _fetchRecommendeds() async {
    final recommendedItems = await fetchList<Recommended, Recommended>(
      const Recommended(),
      FirebaseCollections.recommended,
    );
    state = state.copyWith(recommendeds: recommendedItems);
  }

  Future<void> fetchAndLoad() async {
    state = state.copyWith(isLoading: true);

    await Future.wait([_fetchNews(), _fetchTags(), _fetchRecommendeds()]);
    state = state.copyWith(isLoading: false);
  }

  void updateSelectedTag(Tag? tag) {
    if (tag == null) return;
    state = state.copyWith(selectedTag: tag);
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.news,
    this.tags,
    this.isLoading,
    this.recommendeds,
    this.selectedTag,
  });

  final List<News>? news;
  final List<Tag>? tags;
  final List<Recommended>? recommendeds;
  final Tag? selectedTag;

  final bool? isLoading;

  @override
  List<Object?> get props => [news, tags, recommendeds, isLoading, selectedTag];

  HomeState copyWith({
    List<News>? news,
    List<Tag>? tags,
    List<Recommended>? recommendeds,
    Tag? selectedTag,
    bool? isLoading,
  }) {
    return HomeState(
      news: news ?? this.news,
      tags: tags ?? this.tags,
      recommendeds: recommendeds ?? this.recommendeds,
      selectedTag: selectedTag ?? this.selectedTag,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
