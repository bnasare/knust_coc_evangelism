import 'dart:async';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/presentation/widgets/error_view.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/presentation/bloc/locale_mixin.dart';
import 'package:evangelism_admin/src/locales/presentation/interface/widgets/location_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LocationPage extends HookWidget with LocaleMixin {
  LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final allLocales = useMemoized(() => listAllLocales(context: context));
    final searchController = useTextEditingController();
    final searchResults = useState<List<Locales>?>(null);

    void handleSearch(String query) async {
      if (query.isEmpty) {
        searchResults.value = null;
      } else {
        List<Locales> allLocales = await listAllLocales(context: context).first;
        List<Locales> filteredLocales = allLocales
            .where((locale) =>
                locale.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
        searchResults.value = filteredLocales;
      }
    }

    // Optional: Declare a Timer variable to store the debouncer timer
    Timer? searchDebouncer;

    void handleSearchDebounced(String value) async {
      // Create a timer with a specific duration (e.g., 500 milliseconds)
      Timer? timer = Timer(const Duration(milliseconds: 500), () {
        // If the timer finishes and the search text hasn't changed, call handleSearch
        if (value == searchController.text) {
          handleSearch(value);
        }
      });

      // Cancel any previous timers before starting a new one
      searchDebouncer?.cancel();
      searchDebouncer = timer;
    }

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
                      trailing: [
                        if (searchController.text.isNotEmpty)
                          IconButton(
                            onPressed: () {
                              searchController.clear();
                              searchResults.value = null;
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            icon: const Icon(CupertinoIcons.clear_circled),
                          ),
                      ].whereType<Widget>().toList(),
                      onChanged: (value) => handleSearchDebounced(value),
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
              child: searchResults.value != null &&
                      searchController.text.isNotEmpty
                  ? searchResults.value!.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 80),
                          child: ErrorViewWidget(),
                        )
                      : LocationWidget(locales: searchResults.value!)
                  : searchController.text.isEmpty || searchResults.value == null
                      ? StreamBuilder(
                          stream: allLocales,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const ErrorViewWidget();
                            } else if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.data!.isEmpty) {
                              return const ErrorViewWidget();
                            } else {
                              var locales = snapshot.data!;
                              return LocationWidget(locales: locales);
                            }
                          },
                        )
                      : const ErrorViewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
