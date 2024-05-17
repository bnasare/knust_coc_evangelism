// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../shared/presentation/theme/extra_colors.dart';
import '../../../../../shared/presentation/widgets/error_view.dart';
import '../../../domain/entities/prospect.dart';
import '../../bloc/prospect_mixin.dart';
import '../widgets/prospect_widget.dart';

class AllProspectsPage extends HookWidget with ProspectMixin {
  final String localeID;
  final String locale;
  AllProspectsPage({super.key, required this.localeID, required this.locale});

  @override
  Widget build(BuildContext context) {
    final allProspects =
        useMemoized(() => listAllProspects(documentID: localeID));
    final searchController = useTextEditingController();
    final searchResults = useState<List<Prospect>?>(null);
    final totalProspects = useState<int?>(null);

    void handleSearch(String query) async {
      if (query.isEmpty) {
        searchResults.value = null;
      } else {
        List<Prospect> allProspects =
            await listAllProspects(documentID: localeID).first;
        List<Prospect> filteredLocales = allProspects
            .where((prospect) =>
                prospect.name.toLowerCase().contains(query.toLowerCase()) ||
                prospect.religiousAffiliation
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                prospect.initialContact
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
        searchResults.value = filteredLocales;
      }
    }

    Timer? searchDebouncer;
    void handleSearchDebounced(String value) async {
      Timer? timer = Timer(const Duration(milliseconds: 500), () {
        if (value == searchController.text) {
          handleSearch(value);
        }
      });
      searchDebouncer?.cancel();
      searchDebouncer = timer;
    }

    useEffect(() {
      final StreamSubscription<List<Prospect>> subscription =
          listAllProspects(documentID: localeID).listen(
              (allProspectsAvailable) {
        totalProspects.value = allProspectsAvailable.length;
      }, onError: (error) {
        debugPrint(error.toString());
        totalProspects.value = 0;
      });

      return subscription.cancel;
    }, []);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Locate Prospect'),
        actions: [
          searchController.text.isEmpty && totalProspects.value != 0 ||
                  searchResults.value != null && searchResults.value!.isNotEmpty
              ? IconButton(
                  onPressed: () => createPDF(localeID, context, locale,
                      searchResults.value, searchController.text),
                  icon: const Icon(CupertinoIcons.doc_text_fill,
                      color: ExtraColors.linkLight, size: 18),
                )
              : const SizedBox.shrink(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: ExtraColors.darkGrey.withOpacity(0.3),
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16, bottom: 16),
              child: SearchBar(
                trailing: [
                  if (searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        searchController.clear();
                        searchResults.value = null;
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: const Icon(CupertinoIcons.clear_circled),
                    ),
                ].whereType<Widget>().toList(),
                onChanged: (value) => handleSearchDebounced(value),
                hintText: 'Search by name,affilitation,initial contact',
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
              child: searchResults.value != null &&
                      searchController.text.isNotEmpty
                  ? searchResults.value!.isEmpty
                      ? const ErrorViewWidget()
                      : ProspectWidget(prospects: searchResults.value!)
                  : searchController.text.isEmpty || searchResults.value == null
                      ? StreamBuilder(
                          stream: allProspects,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const ErrorViewWidget();
                            } else if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.data!.isEmpty) {
                              return const ErrorViewWidget();
                            } else {
                              var prospects = snapshot.data!;
                              return ProspectWidget(prospects: prospects);
                            }
                          })
                      : const ErrorViewWidget(),
            )
          ],
        ),
      ),
    );
  }
}
