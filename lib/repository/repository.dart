import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@riverpod
Future<List<Apod>> filteredApods(
  FilteredApodsRef ref, {
  String searchText = '',
}) async {
  final apods = await ref.watch(fetchApodProvider.future);

  if (searchText.isEmpty) return apods;

  final text = searchText.toLowerCase();

  return apods
      .where((apod) =>
          apod.title.toLowerCase().contains(text) ||
          apod.date.toLowerCase().contains(text))
      .toList();
}

@riverpod
Future<List<Apod>> fetchApod(FetchApodRef ref) =>
    ref.watch(repositoryProvider).getApods();

@riverpod
Repository repository(RepositoryRef ref) => Repository();

class Repository {
  static const _scheme = 'https';
  static const _host = 'api.nasa.gov';
  final dio = Dio();

  Future<List<Apod>> getApods() async {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: 'planetary/apod',
      queryParameters: {
        'api_key': const String.fromEnvironment('ApiKey'),
        'count': '20'
      },
    );

    final response = await dio.getUri(uri);

    final apodsResponse = ApodsResponse.fromJson({'apods': response.data});
    return apodsResponse.apods;
  }
}

@freezed
class Apod with _$Apod {
  factory Apod({
    required String date,
    required String explanation,
    required String? hdurl,
    required String title,
    required String url,
  }) = _Apod;

  factory Apod.fromJson(Map<String, dynamic> json) => _$ApodFromJson(json);
}

@freezed
class ApodsResponse with _$ApodsResponse {
  factory ApodsResponse({required List<Apod> apods}) = _ApodsResponse;

  factory ApodsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApodsResponseFromJson(json);
}
