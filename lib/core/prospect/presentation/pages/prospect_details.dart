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
            title: Text('NAME',
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
            title: Text('MOBILE',
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
            title: Text('LANDMARK',
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
            title: Text('GENDER',
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
            title: Text('RELIGIOUS AFFILATION',
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
            title: Text('BAPTISMAL STATUS',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('Yes',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('LESSONS TAUGHT',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text(
                'Baptism, Christ\'s Confirmation, The Lord\'s Supper',
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: ExtraColors.secondaryText)),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: null,
            title: Text('GROUP',
                style: TextStyle(fontSize: 18, color: ExtraColors.primaryText)),
            subtitle: Text('12',
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
