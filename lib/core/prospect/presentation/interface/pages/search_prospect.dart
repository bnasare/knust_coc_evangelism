// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_mixin.dart';
import 'package:evangelism_admin/core/prospect/presentation/interface/pages/prospect_details.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/presentation/widgets/error_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../../../shared/presentation/widgets/snackbar.dart';

class SearchProspectPage extends HookWidget with ProspectMixin {
  final String localeID;
  final String locale;
  SearchProspectPage({super.key, required this.localeID, required this.locale});

  @override
  Widget build(BuildContext context) {
    final allProspects =
        useMemoized(() => listAllProspects(documentID: localeID));
    final searchController = useTextEditingController();
    int rowNumber = 1;

    Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
      final path = (await getExternalStorageDirectory())?.path;
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('$path/$fileName');
    }

    Future<void> createPDF(String localeID) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Dialog(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("Generating PDF...", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          );
        },
      );

      final Stream<List<Prospect>> allProspectsStream =
          listAllProspects(documentID: localeID);
      final Completer<void> completer = Completer<void>();

      final StreamSubscription<List<Prospect>> subscription =
          allProspectsStream.listen(
        (List<Prospect> allProspects) async {
          if (allProspects.isEmpty) {
            debugPrint('No prospects available to generate PDF.');
            Navigator.pop(context);
            SnackBarHelper.showErrorSnackBar(
                context, 'No prospects available to generate PDF.');
            completer.complete();
            return;
          }

          PdfDocument document = PdfDocument();
          var page = document.pages.add();

          PdfGrid grid = PdfGrid();
          grid.style = PdfGridStyle(
              font: PdfStandardFont(PdfFontFamily.helvetica, 20),
              cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));
          grid.columns.add(count: 3);
          grid.headers.add(1);

          final PdfFont headerFont = PdfStandardFont(
              PdfFontFamily.helvetica, 25,
              style: PdfFontStyle.bold);

          PdfGridRow header = grid.headers[0];
          header.cells[0].value = 'Name - No.';
          header.cells[1].value = 'Residence';
          header.cells[2].value = 'Affiliation';

          for (int i = 0; i < header.cells.count; i++) {
            header.cells[i].style.font = headerFont;
          }

          for (var prospect in allProspects) {
            PdfGridRow row = grid.rows.add();
            row.cells[0].value =
                '$rowNumber. ${prospect.name}- ${prospect.mobile}';
            rowNumber++;
            row.cells[1].value = prospect.demographics;
            row.cells[2].value = prospect.religiousAffiliation;
          }

          // Configure the layout format to paginate automatically
          PdfLayoutFormat gridLayoutFormat =
              PdfLayoutFormat(layoutType: PdfLayoutType.paginate);

// Draw the grid and get the result to know where the grid ends
          PdfLayoutResult? gridLayoutResult = grid.draw(
            page: page,
            bounds: Rect.fromLTWH(
                0, 0, page.getClientSize().width, page.getClientSize().height),
            format: gridLayoutFormat,
          );

          // Check if the grid did not fit on a single page and a new page was created
          PdfPage lastPage = gridLayoutResult!.page;

// Draw the red line on the last page of the grid
          lastPage.graphics.drawLine(
            PdfPen(PdfColor(255, 0, 0), width: 1),
            Offset(0, gridLayoutResult.bounds.bottom + 10),
            Offset(lastPage.getClientSize().width,
                gridLayoutResult.bounds.bottom + 10),
          );

          List<int> bytes = await document.save();
          document.dispose();

          // Save and launch the file
          await saveAndLaunchFile(
              bytes, '$locale Prospects(${allProspects.length}).pdf');

          Navigator.pop(context);
          // Complete the completer to indicate that the PDF creation is done
          completer.complete();
        },
        onError: (error) {
          Navigator.pop(context);
          debugPrint(error.toString());
          SnackBarHelper.showErrorSnackBar(context, error.toString());
          completer.completeError(error);
        },
      );

      // To ensure the subscription is cancelled after the PDF is generated
      completer.future.then((_) => subscription.cancel());

      return completer.future;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Locate Prospect'), actions: [
        IconButton(
          onPressed: () => createPDF(localeID),
          icon: const Icon(CupertinoIcons.doc_text_fill,
              color: ExtraColors.linkLight),
        )
      ]),
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
                              subtitle: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  '${prospect.mobile} - ${prospect.demographics}',
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
