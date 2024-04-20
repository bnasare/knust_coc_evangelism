import 'package:evangelism_admin/core/prospect/presentation/pages/search_prospect.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  createState() => _LocationPage();
}

class _LocationPage extends State<LocationPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: const Text('Setting')),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 16, bottom: 16),
                child: SearchBar(
                  hintText: 'Find locales available',
                  textStyle: const MaterialStatePropertyAll(
                      TextStyle(color: ExtraColors.grey)),
                  controller: _searchController,
                  padding: const MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 15)),
                  leading: const Icon(CupertinoIcons.search,
                      color: ExtraColors.grey),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (_, __) {
                      return ListTile(
                        splashColor: ExtraColors.background,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const SearchProspectPage();
                              },
                            ),
                          );
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
                        trailing:
                            const Icon(CupertinoIcons.placemark, size: 27),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemCount: 16),
              ),
            ],
          ),
        ));
  }
}
