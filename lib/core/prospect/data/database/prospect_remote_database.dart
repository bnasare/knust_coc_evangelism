import '../../domain/entities/prospect.dart';
import '../../../../shared/data/collection_ids.dart';
import '../../../../shared/data/firestore_service.dart';

abstract class ProspectRemoteDatabase {
  Future<Prospect> createProspect(Prospect prospect);
  Stream<Prospect> getProspect(String documentID);
  Stream<List<Prospect>> listProspects(String documentID);
}

class ProspectRemoteDatabaseImpl implements ProspectRemoteDatabase {
  @override
  Future<Prospect> createProspect(Prospect prospect) async {
    final Prospect createdProspect = Prospect(
      evangelismSetting: prospect.evangelismSetting,
      initialContact: prospect.initialContact,
      name: prospect.name,
      mobile: prospect.mobile,
      demographics: prospect.demographics,
      gender: prospect.gender,
      religiousAffiliation: prospect.religiousAffiliation,
      baptismalStatus: prospect.baptismalStatus,
      interactionDetails: prospect.interactionDetails,
      id: prospect.id,
      localeID: prospect.localeID,
      createdAt: prospect.createdAt,
    );

    final data = createdProspect.toJson();
    await FirestoreService.instance
        .collection(DatabaseCollections.prospects)
        .doc(createdProspect.id)
        .set(data);
    return createdProspect;
  }

  @override
  Stream<Prospect> getProspect(String documentID) {
    final prospect = FirestoreService.instance
        .collection(DatabaseCollections.prospects)
        .doc(documentID)
        .snapshots()
        .map((event) => Prospect.fromJson(event.data()!));
    return prospect;
  }

  @override
  Stream<List<Prospect>> listProspects(String documentID) {
    final prospect = FirestoreService.instance
        .collection(DatabaseCollections.prospects)
        .where('localeID', isEqualTo: documentID)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) {
      if (event.docs.isEmpty) {
        throw Exception("No documents found");
      }
      final prospectsList = event.docs.map((e) {
        return Prospect.fromJson(e.data());
      }).toList();
      return prospectsList;
    });
    return prospect;
  }
}
