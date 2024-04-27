import 'package:evangelism_admin/shared/data/collection_ids.dart';
import 'package:evangelism_admin/shared/data/firestore_service.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';

abstract class LocaleRemoteDatabase {
  Stream<Locales> getLocale();
  Stream<List<Locales>> listLocales();
}

class LocaleRemoteDatabaseImpl implements LocaleRemoteDatabase {
  @override
  Stream<Locales> getLocale() {
    final locale = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .where('status', isEqualTo: 'active')
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      final doc = querySnapshot.docs.first;
      return Locales.fromJson(doc.data());
    });
    return locale;
  }

  @override
  Stream<List<Locales>> listLocales() {
    final locales = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Locales.fromJson(e.data())).toList());
    return locales;
  }
}
