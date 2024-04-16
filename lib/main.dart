import 'package:device_preview/device_preview.dart';
import 'package:evangelism_admin/firebase_options.dart';
import 'package:evangelism_admin/injection_container.dart';
import 'package:evangelism_admin/shared/platform/push_notification.dart';
import 'package:evangelism_admin/shared/presentation/theme/theme.dart';
import 'package:evangelism_admin/src/authentication/presentation/interface/pages/wrapper.dart';
import 'package:evangelism_admin/src/onboarding/presentation/bloc/onboarding_mixin.dart';
import 'package:evangelism_admin/src/onboarding/presentation/pages/onboarding_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  await sl<PushNotification>().initializeNotification();

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true,
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget with OnboardingMixin {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingCompleteFuture =
        useMemoized(() => checkIfOnboardingIsComplete());
    final snapshot = useFuture(onboardingCompleteFuture);
    return MaterialApp(
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: () {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SizedBox.shrink(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.data == true) {
          return const AuthWrapper();
        } else {
          return OnboardingPage();
        }
      }(),
    );
  }
}
