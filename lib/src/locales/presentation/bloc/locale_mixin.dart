import 'package:evangelism_admin/injection_container.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:evangelism_admin/src/locales/presentation/bloc/locale_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin LocaleMixin {
  final bloc = sl<LocaleBloc>();

  Future<List<Locales>> listAllLocales({required BuildContext context}) async {
    final result = await bloc.listAllLocales();
    return result.fold(
      (l) => [],
      (r) => r,
    );
  }

  Stream<Locales> getALocale({
    required String documentID,
  }) async* {
    final result = await bloc.getALocale(documentID).first;
    yield result.fold(
      (l) => Locales.initial(),
      (r) => r,
    );
  }
}
