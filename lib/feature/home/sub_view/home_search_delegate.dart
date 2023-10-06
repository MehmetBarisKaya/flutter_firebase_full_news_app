import 'package:flutter/material.dart';
import 'package:riverpod_project/product/models/tag.dart';

class HomeSearchDelegate extends SearchDelegate<Tag?> {
  HomeSearchDelegate(this.tagItems);

  final List<Tag> tagItems;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear_all_outlined),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = tagItems.where(
      (element) => element.name?.toLowerCase().contains(query) ?? false,
    );
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(result.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = tagItems.where(
      (element) => element.name?.toLowerCase().contains(query) ?? false,
    );
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            onTap: () {
              close(context, result.elementAt(index));
            },
            title: Text(result.elementAt(index).name ?? ''),
          ),
        );
      },
    );
  }
}
