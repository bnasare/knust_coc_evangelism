import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_mixin.dart';
import 'package:evangelism_admin/shared/presentation/widgets/error_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../shared/presentation/theme/extra_colors.dart';

class ProspectDetailsPage extends HookWidget with ProspectMixin {
  final String documentID;
  ProspectDetailsPage({super.key, required this.documentID});

  @override
  Widget build(BuildContext context) {
    final singleProspect =
        useMemoized(() => getAProspect(documentID: documentID));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prospect Details'),
      ),
      body: StreamBuilder(
        stream: singleProspect,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorViewWidget();
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null) {
            return const ErrorViewWidget();
          } else {
            var prospect = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: null,
                  title: Text(_titles[index],
                      style: const TextStyle(
                          fontSize: 18, color: ExtraColors.primaryText)),
                  subtitle: Text(_getSubtitle(prospect, index),
                      style: const TextStyle(
                          letterSpacing: 1.5,
                          fontSize: 16.5,
                          color: ExtraColors.secondaryText)),
                );
              },
            );
          }
        },
      ),
    );
  }

  final List<String> _titles = [
    'NAME',
    'MOBILE',
    'DEMOGRAPHICS',
    'GENDER',
    'RELIGIOUS AFFILATION',
    'BAPTISMAL STATUS',
    'INTERACTION DETAILS',
    'INITIAL CONTACT',
    'EVANGELISM SETTING'
  ];

  String _getSubtitle(Prospect prospect, int index) {
    switch (index) {
      case 0:
        return prospect.name;
      case 1:
        return prospect.mobile;
      case 2:
        return prospect.demographics;
      case 3:
        return prospect.gender;
      case 4:
        return prospect.religiousAffiliation;
      case 5:
        return prospect.baptismalStatus;
      case 6:
        return prospect.interactionDetails;
      case 7:
        return prospect.initialContact;
      case 8:
        return prospect.evangelismSetting;
      default:
        return '';
    }
  }
}
