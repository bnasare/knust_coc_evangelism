import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'bottom_navbar.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;
import 'shared/presentation/theme/theme.dart';
import 'src/onboarding/presentation/bloc/onboarding_mixin.dart';
import 'src/onboarding/presentation/interface/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

// runApp(
//   ProviderScope(
//     child: DevicePreview(
//       enabled: true,
//       builder: (context) => MyApp(),
//     ),
//   ),
// );

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
          return const NavBar();
        } else {
          return OnboardingPage();
        }
      }(),
    );
  }
}
