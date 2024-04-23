import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/shared/data/collection_ids.dart';
import 'package:evangelism_admin/shared/data/firestore_service.dart';

abstract class ProspectRemoteDatabase {
  Future<Prospect> createProspect(Prospect prospect);
  Stream<Prospect> getProspect(String documentID);
  Stream<List<Prospect>> listProspects(List<String> documentIDs);
}

class ProspectRemoteDatabaseImpl implements ProspectRemoteDatabase {
  @override
  Future<Prospect> createProspect(Prospect prospect) async {
    final Prospect createdProspect = Prospect(
      initialContact: prospect.initialContact,
      evangelismSetting: prospect.evangelismSetting,
      name: prospect.name,
      mobile: prospect.mobile,
      demographics: prospect.demographics,
      gender: prospect.gender,
      religiousAffiliation: prospect.religiousAffiliation,
      baptismalStatus: prospect.baptismalStatus,
      interactionDetails: prospect.interactionDetails,
      id: prospect.id,
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
  Stream<List<Prospect>> listProspects(List<String> documentID) {
    final prospect = FirestoreService.instance
        .collection(DatabaseCollections.prospects)
        .where(FieldPath.documentId, whereIn: documentID)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Prospect.fromJson(e.data())).toList());
    return prospect;
  }
}
