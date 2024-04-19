import 'package:flutter/material.dart';

import '../../../../shared/presentation/theme/extra_colors.dart';

class ProspectDetailsPage extends StatefulWidget {
  const ProspectDetailsPage({super.key});

  @override
  State<ProspectDetailsPage> createState() => _ProspectDetailsPageState();
}

class _ProspectDetailsPageState extends State<ProspectDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prospect Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        children: const [
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('Name',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('Dennis Osei',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('Mobile',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('0269865678',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('Landmark',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('Behind the chief\'s house',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('Gender',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('Male',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('Religious Affiliation',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('Church Of Christ',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('Baptismal Status',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('Yes',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
        ],
      ),
    );
  }
}
