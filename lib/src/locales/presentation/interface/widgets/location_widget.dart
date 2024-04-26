import 'package:evangelism_admin/core/prospect/presentation/interface/pages/search_prospect.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  final List<Locales> locales;
  const LocationWidget({super.key, required this.locales});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemBuilder: (_, index) {
          var locale = locales[index];
          return ListTile(
            splashColor: ExtraColors.background,
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SearchProspectPage(
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: ExtraColors.black)),
            subtitle: Text(locale.timeframe,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: ExtraColors.grey)),
            trailing: const Icon(CupertinoIcons.placemark, size: 27),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemCount: locales.length);
  }
}
