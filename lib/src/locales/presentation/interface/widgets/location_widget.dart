import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/prospect/presentation/interface/pages/all_prospect.dart';
import '../../../../../shared/presentation/theme/extra_colors.dart';
import '../../../domain/entities/locales.dart';

class LocationWidget extends StatelessWidget {
  final List<Locales> locales;
  const LocationWidget({super.key, required this.locales});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        itemBuilder: (_, index) {
          var locale = locales[index];
          return ListTile(
            splashColor: ExtraColors.background,
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AllProspectsPage(
                        localeID: locale.id, locale: locale.name);
                  },
                ),
              );
            },
            tileColor: ExtraColors.primaryText,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            title: Text(locale.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ExtraColors.black)),
            subtitle: FittedBox(
              child: Text(locale.timeframe,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ExtraColors.grey)),
            ),
            trailing: const Icon(CupertinoIcons.placemark, size: 27),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemCount: locales.length);
  }
}
