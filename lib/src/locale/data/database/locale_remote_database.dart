import 'package:evangelism_admin/shared/data/collection_ids.dart';
import 'package:evangelism_admin/shared/data/firestore_service.dart';
import 'package:evangelism_admin/src/locale/domain/entities/locale.dart';

abstract class LocaleRemoteDatabase {
  Stream<Locale> getLocale(String documentID);
  Stream<List<Locale>> listLocales();
}

class LocaleRemoteDatabaseImpl implements LocaleRemoteDatabase {
  @override
  Stream<Locale> getLocale(String documentID) async* {
    final locale = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .doc(documentID)
        .snapshots()
        .map((event) => Locale.fromJson(event.data()!));
    yield* locale;
  }

  @override
  Stream<List<Locale>> listLocales() async* {
    final locales = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Locale.fromJson(e.data())).toList());
    yield* locales;
  }
}
