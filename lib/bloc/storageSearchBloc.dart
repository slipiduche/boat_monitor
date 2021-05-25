import 'package:rxdart/rxdart.dart';

class StorageSearchBloc {
  dispose() {
    _storageSearchController?.close();
  }

  static final StorageSearchBloc _singleton = new StorageSearchBloc._internal();

  factory StorageSearchBloc() {
    return _singleton;
  }

  StorageSearchBloc._internal();
  final _storageSearchController = new BehaviorSubject<String>();
  Stream<String> get storageSearch => _storageSearchController.stream;
  String get storageSearchValue => _storageSearchController.value;
  set setStorageSearch(String event) => _storageSearchController.add(event);
}
