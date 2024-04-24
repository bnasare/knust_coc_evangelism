import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evangelism_admin/shared/data/collection_ids.dart';
import 'package:evangelism_admin/shared/data/firestore_service.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';

abstract class LocaleRemoteDatabase {
  Stream<Locales> getLocale(String documentID);
  Future<List<Locales>> listLocales();
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
Future<List<Locales>> listLocales() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(DatabaseCollections.locales)
        .get();

    log("Documents fetched: ${querySnapshot.docs.length}");

    final localesList =
        querySnapshot.docs.map((doc) => Locales.fromJson(doc.data())).toList();

    return localesList;
  }

}
