import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:evangelism_admin/core/prospect/presentation/pages/search_prospect.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/utils/navigation.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  createState() => _LocationPage();
}

class _LocationPage extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
          appBar: AppBar(title: const Text('Location')),
          body: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (_, __) {
                return ListTile(
                  onTap: () {
                    NavigationHelper.navigateTo(
                        context, const SearchProspectPage());
                  },
                  tileColor: ExtraColors.primaryText,
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  title: const Text('Asokore Mampong',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: ExtraColors.black)),
                  subtitle: const Text('April 28th, 2024 - May 3rd, 2024',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: ExtraColors.grey)),
                  trailing: const Icon(
                    Icons.person_pin_outlined,
                    color: ExtraColors.link,
                    size: 30,
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 20),
              itemCount: 3)),
    );
  }
}
