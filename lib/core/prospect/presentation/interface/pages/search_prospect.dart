import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_mixin.dart';
import 'package:evangelism_admin/core/prospect/presentation/interface/pages/prospect_details.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProspectPage extends StatefulWidget with ProspectMixin {
  final String localeID;
  SearchProspectPage({super.key, required this.localeID});

  @override
  createState() => _SearchProspectPage();
}

class _SearchProspectPage extends State<SearchProspectPage> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locate Prospect')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16, bottom: 16),
              child: SearchBar(
                hintText: 'Search prospect by tags',
                textStyle: const MaterialStatePropertyAll(
                    TextStyle(color: ExtraColors.grey)),
                controller: _searchController,
                padding: const MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 15)),
                leading:
                    const Icon(CupertinoIcons.search, color: ExtraColors.grey),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                  stream: widget.listAllProspects(documentID: widget.localeID),
                  builder: (context, snapshot) {
                    return ListView.separated(
                        padding: const EdgeInsets.only(
                            bottom: 0, left: 16, right: 16),
                        shrinkWrap: true,
                        itemBuilder: (__, _) {
                          return ListTile(
                            splashColor: ExtraColors.background,
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const ProspectDetailsPage();
                                  },
                                ),
                              );
                            },
                            contentPadding: const EdgeInsets.all(0),
                            leading: const Icon(
                                CupertinoIcons.person_alt_circle,
                                color: ExtraColors.secondaryText,
                                size: 50),
                            title: const Text('Dennis Osei',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: ExtraColors.primaryText)),
                            subtitle: const Text('0269865678',
                                style: TextStyle(
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: ExtraColors.secondaryText)),
                          );
                        },
                        separatorBuilder: (__, _) => const Divider(),
                        itemCount: 8);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
