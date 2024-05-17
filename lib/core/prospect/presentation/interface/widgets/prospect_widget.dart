import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/extra_colors.dart';
import '../../../domain/entities/prospect.dart';
import '../pages/prospect_details.dart';

class ProspectWidget extends StatelessWidget {
  final List<Prospect> prospects;
  const ProspectWidget({super.key, required this.prospects});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(bottom: 0, left: 16, right: 16),
        shrinkWrap: true,
        itemBuilder: (__, index) {
          var prospect = prospects[index];
          return ListTile(
            splashColor: ExtraColors.background,
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProspectDetailsPage(documentID: prospect.id);
                  },
                ),
              );
            },
            contentPadding: const EdgeInsets.all(0),
            leading: const Icon(CupertinoIcons.person_alt_circle,
                color: ExtraColors.secondaryText, size: 50),
            title: Text(prospect.name,
                maxLines: 1,
                style: const TextStyle(
                    fontSize: 16, color: ExtraColors.primaryText)),
            subtitle: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '${prospect.mobile} - ${prospect.demographics}',
                style: const TextStyle(
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: ExtraColors.secondaryText)),
          );
        },
        separatorBuilder: (__, _) =>
            Divider(color: ExtraColors.lightGrey.withOpacity(0.3)),
        itemCount: prospects.length);
  }
}
