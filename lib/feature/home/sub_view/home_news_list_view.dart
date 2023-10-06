part of '../home_view.dart';

// ignore: unused_element
class _HomeListView extends StatelessWidget {
  const _HomeListView();

  @override
  Widget build(BuildContext context) {
    final news = FirebaseCollections.news.reference;
    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        // ignore: unnecessary_null_comparison
        if (value == null) throw FirebaseCustomException('$value not null');
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
                shrinkWrap: true,
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
