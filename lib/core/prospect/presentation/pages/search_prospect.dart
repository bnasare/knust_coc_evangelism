import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProspectPage extends StatefulWidget {
  const SearchProspectPage({super.key});

  @override
  createState() => _SearchProspectPage();
}

class _SearchProspectPage extends State<SearchProspectPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Locate Prospects'),
      ),
      body: Column(
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
            child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                shrinkWrap: true,
                itemBuilder: (__, _) {
                  return const ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(CupertinoIcons.person_alt_circle,
                        color: ExtraColors.secondaryText, size: 50),
                    title: Text('Dennis Osei',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ExtraColors.primaryText)),
                    subtitle: Text('0269865678',
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: ExtraColors.secondaryText)),
                  );
                },
                separatorBuilder: (__, _) => const Divider(),
                itemCount: 8),
          )
        ],
      ),
    );
  }
}
