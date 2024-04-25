import 'package:evangelism_admin/shared/data/collection_ids.dart';
import 'package:evangelism_admin/shared/data/firestore_service.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';

abstract class LocaleRemoteDatabase {
  Stream<Locales> getLocale(String status);
  Stream<List<Locales>> listLocales();
}

class LocaleRemoteDatabaseImpl implements LocaleRemoteDatabase {
  @override
  Stream<Locales> getLocale(String status) {
    final locale = FirestoreService.instance
        .collection(DatabaseCollections.locales)
        .where(status, isEqualTo: status)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return Locales.fromJson(doc.data());
      } else {
        throw Exception("Document not found");
      }
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
