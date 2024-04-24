import 'package:evangelism_admin/injection_container.dart';
import 'package:evangelism_admin/src/locale/domain/entities/locale.dart';
import 'package:evangelism_admin/src/locale/presentation/bloc/locale_bloc.dart';
import 'package:flutter/material.dart';

mixin LocaleMixin {
  final bloc = sl<LocaleBloc>();

  Stream<List<Locale>> listAllLocales({
    required BuildContext context,
  }) async* {
    final result = await bloc.listAllLocales().first;
    yield result.fold(
      (l) => List<Locale>.empty(),
      (r) => r,
    );
  }

  Stream<Locale> getALocale({
    required BuildContext context,
    required String documentID,
  }) async* {
    final result = await bloc.getALocale(documentID).first;
    yield result.fold(
      (l) => Locale.initial(),
      (r) => r,
    );
  }
}
