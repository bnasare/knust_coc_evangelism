// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:evangelism_admin/core/prospect/domain/entities/prospect.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_bloc.dart';
import 'package:evangelism_admin/injection_container.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/presentation/bloc/locale_bloc.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../../shared/presentation/widgets/snackbar.dart';

mixin ProspectMixin {
  final bloc = sl<ProspectBloc>();
  final localeBloc = sl<LocaleBloc>();

  Future<bool> createAProspect(
      {required BuildContext context, required Prospect prospect}) async {
    final result = await bloc.createAProspect(prospect);
    return result.fold((l) {
      SnackBarHelper.showErrorSnackBar(context, l.message);
      return false;
    }, (r) {
      SnackBarHelper.showSuccessSnackBar(context,
          "${r.name} has been successfully added to the prospect list! 🎉");
      return true;
    });
  }

  Stream<Prospect> getAProspect({required String documentID}) {
    final result = bloc.getAProspect(documentID);
    return result.map((either) {
      return either.fold((failure) {
        log('Failed to fetch locales: $failure');
        return Prospect.initial();
      }, (prospect) {
        return prospect;
      });
    });
  }

  Stream<List<Prospect>> listAllProspects({required String documentID}) {
    final result = bloc.listAllProspects(documentID);
    return result.map((either) {
      return either.fold((failure) {
        log('Failed to fetch locales: $failure');
        return [];
      }, (prospects) {
        return prospects;
      });
    });
  }

  Stream<Locales> getALocale() {
    final subject = BehaviorSubject<Locales>();
    final result = localeBloc.getALocale();

    result.listen((either) {
      final locales = either.fold((failure) {
        log('Failed to fetch locales: $failure');
        return Locales.initial();
      }, (locales) {
        return locales;
      });
      subject.add(locales);
    }, onError: (error) {
      subject.addError(error);
    });

    return subject.stream;
  }

  Future<List<String>> loadRecentGroupPicks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recentGroupPicks') ?? [];
  }

  Future<void> saveRecentGroupPicks(List<String> recentGroupPicks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentGroupPicks', recentGroupPicks);
  }

  Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
    final path = (await getExternalStorageDirectory())?.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$fileName');
  }

  Future<void> createPDF(String localeID, BuildContext context, Locale locale,
      List<Prospect>? searchResults) async {
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

    final Completer<void> completer = Completer<void>();

    List<Prospect> prospectsToGenerate;
    if (searchResults != null && searchResults.isNotEmpty) {
      prospectsToGenerate = searchResults;
    } else {
      prospectsToGenerate = await listAllProspects(documentID: localeID).first;
    }

    if (prospectsToGenerate.isEmpty) {
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

    final PdfFont headerFont =
        PdfStandardFont(PdfFontFamily.helvetica, 25, style: PdfFontStyle.bold);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Name - No.';
    header.cells[1].value = 'Residence';
    header.cells[2].value = 'Affiliation';

    for (int i = 0; i < header.cells.count; i++) {
      header.cells[i].style.font = headerFont;
    }

    int rowNumber = 1;

    for (var prospect in prospectsToGenerate) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = '$rowNumber. ${prospect.name}- ${prospect.mobile}';
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
      Offset(
          lastPage.getClientSize().width, gridLayoutResult.bounds.bottom + 10),
    );

    List<int> bytes = await document.save();
    document.dispose();

    // Save and launch the file
    await saveAndLaunchFile(
        bytes, '$locale Prospects(${prospectsToGenerate.length}).pdf');

    Navigator.pop(context);
    // Complete the completer to indicate that the PDF creation is done
    completer.complete();

    // To ensure the subscription is cancelled after the PDF is generated

    return completer.future;
  }
}
