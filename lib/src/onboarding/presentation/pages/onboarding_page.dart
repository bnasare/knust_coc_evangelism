import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:evangelism_admin/shared/data/image_assets.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/utils/navigation.dart';
import 'package:evangelism_admin/src/authentication/presentation/interface/pages/login.dart';
import 'package:flutter/material.dart';

import '../bloc/onboarding_mixin.dart';

class OnboardingPage extends StatefulWidget with OnboardingMixin {
  OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColorfulSafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  ImageAssets.jesusR,
                ),
                const SizedBox(height: 50),
                const Text(
                  "Elevate Evangelism: Capture Leads, Build Relationships",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Seamlessly collect and manage prospect information during your vacation evangelism activities.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ExtraColors.secondaryText,
                    fontSize: 17,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.completeOnboardingChecks();
                        NavigationHelper.navigateToReplacement(
                            context, LoginPage());
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        fixedSize: const Size(double.maxFinite, 55),
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        "Get Started",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: ExtraColors.primaryText, letterSpacing: 2),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
