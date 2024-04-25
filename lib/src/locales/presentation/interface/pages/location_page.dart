import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:evangelism_admin/core/prospect/presentation/interface/pages/search_prospect.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/presentation/widgets/error_view.dart';
import 'package:evangelism_admin/src/locales/presentation/bloc/locale_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LocationPage extends HookWidget with LocaleMixin {
  LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final allLocales = useMemoized(() => listAllLocales(context: context));
    final searchController = useTextEditingController();

    return ColorfulSafeArea(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: ExtraColors.background,
              height: 150,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Locales',
                    style: TextStyle(
                        color: ExtraColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 20, bottom: 0),
                    child: SearchBar(
                      hintText: 'Find locales available',
                      textStyle: const MaterialStatePropertyAll(
                          TextStyle(color: ExtraColors.grey)),
                      controller: searchController,
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 15)),
                      leading: const Icon(CupertinoIcons.search,
                          color: ExtraColors.grey),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: allLocales,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const ErrorViewWidget();
                  } else if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.isEmpty) {
                    return const ErrorViewWidget();
                  } else {
                    var locales = snapshot.data!;
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
                                        localeID: locale.id);
                                  },
                                ),
                              );
                            },
                            tileColor: ExtraColors.primaryText,
                            shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
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
                            trailing:
                                const Icon(CupertinoIcons.placemark, size: 27),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemCount: locales.length);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
