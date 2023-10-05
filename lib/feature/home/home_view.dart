import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:riverpod_project/product/models/news_model.dart';
import 'package:riverpod_project/product/utility/exception/custom_excepiton.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //FutureBuilder
  //datayı init olduğu anda çekip set state ile göstermek
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _HomeListView(),
    );
  }
}

class _HomeListView extends StatelessWidget {
  const _HomeListView();

  @override
  Widget build(BuildContext context) {
    final CollectionReference news =
        FirebaseFirestore.instance.collection('news');

    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        // ignore: unnecessary_null_comparison
        if (value == null) {
          throw FirebaseCustomException('$value not null');
        }
        return value.toJson();
      },
    ).get();
    return FutureBuilder(
      future: response,
      builder: (context, AsyncSnapshot<QuerySnapshot<News?>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Placeholder();
          case ConnectionState.waiting:
            return const LinearProgressIndicator();
          case ConnectionState.active:
            return const LinearProgressIndicator();

          case ConnectionState.done:
            if (snapshot.hasData) {
              final values = snapshot.data!.docs.map((e) => e.data()).toList();
              return ListView.builder(
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          values[index]?.backgroundImage ?? '',
                          height: context.sized.dynamicHeight(0.1),
                        ),
                        Text(
                          values[index]?.title ?? '',
                          style: context.general.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
        }
      },
    );
  }
}
