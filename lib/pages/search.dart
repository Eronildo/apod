import 'package:apod/pages/detail.dart';
import 'package:apod/repository/repository.dart';
import 'package:apod/widgets/apod_widget.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    useListenable(searchController);

    final apodValue =
        ref.watch(filteredApodsProvider(searchText: searchController.text));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            hintText: 'Filter APODs',
            hintStyle: TextStyle(color: Colors.white30),
          ),
        ),
      ),
      body: Center(
        child: apodValue.when(
          data: (apods) => Visibility(
            visible: apods.isNotEmpty,
            replacement: const Text('No PODs found, try clear the filter'),
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(fetchApodProvider);
                return ref.read(fetchApodProvider.future);
              },
              child: ListView.builder(
                itemCount: apods.length,
                itemBuilder: (context, index) {
                  final apod = apods[index];
                  return ApodWidget(
                    title: apod.title,
                    date: apod.date,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return DetailPage(apod: apod);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          error: (error, stackTrace) => Text('Error $error'),
          loading: () => const CircularProgressIndicator(),
          skipLoadingOnReload: true,
        ),
      ),
    );
  }
}
