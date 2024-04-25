import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_mixin.dart';
import 'package:evangelism_admin/core/prospect/presentation/interface/pages/prospect_details.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/presentation/widgets/error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchProspectPage extends HookWidget with ProspectMixin {
  final String localeID;
  SearchProspectPage({super.key, required this.localeID});

  @override
  Widget build(BuildContext context) {
    final allProspects =
        useMemoized(() => listAllProspects(documentID: localeID));
    final searchController = useTextEditingController();

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
                controller: searchController,
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
                  stream: allProspects,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const ErrorViewWidget();
                    } else if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.isEmpty) {
                      return const ErrorViewWidget();
                    } else {
                      var prospects = snapshot.data!;
                      return ListView.separated(
                          padding: const EdgeInsets.only(
                              bottom: 0, left: 16, right: 16),
                          shrinkWrap: true,
                          itemBuilder: (__, index) {
                            var prospect = prospects[index];
                            return ListTile(
                              splashColor: ExtraColors.background,
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ProspectDetailsPage(
                                          documentID: prospect.id);
                                    },
                                  ),
                                );
                              },
                              contentPadding: const EdgeInsets.all(0),
                              leading: const Icon(
                                  CupertinoIcons.person_alt_circle,
                                  color: ExtraColors.secondaryText,
                                  size: 50),
                              title: Text(prospect.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: ExtraColors.primaryText)),
                              subtitle: Text(prospect.mobile,
                                  style: const TextStyle(
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: ExtraColors.secondaryText)),
                            );
                          },
                          separatorBuilder: (__, _) => const Divider(),
                          itemCount: prospects.length);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
