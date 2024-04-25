import 'package:evangelism_admin/shared/data/collection_ids.dart';
import 'package:evangelism_admin/shared/data/firestore_service.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';

abstract class LocaleRemoteDatabase {
  Stream<Locales> getLocale(String documentID);
  Stream<List<Locales>> listLocales();
}

class LocaleRemoteDatabaseImpl implements LocaleRemoteDatabase {
  @override
  Stream<Locales> getLocale(String documentID) async* {
    final locale = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .doc(documentID)
        .snapshots()
        .map((event) => Locales.fromJson(event.data()!));
    yield* locale;
  }

  @override
  Stream<List<Locales>> listLocales() {
    final locales = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Locales.fromJson(e.data())).toList());
    return locales;
  }
}
