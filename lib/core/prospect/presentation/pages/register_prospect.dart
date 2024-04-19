import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:evangelism_admin/shared/data/image_assets.dart';
import 'package:evangelism_admin/shared/data/svg_assets.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterProspectPage extends StatefulWidget {
  const RegisterProspectPage({super.key});

  @override
  State<RegisterProspectPage> createState() => _RegisterProspectPageState();
}

class _RegisterProspectPageState extends State<RegisterProspectPage> {
  int _index = 0;
  final int _stepAmount = 5;

  final titleController = TextEditingController();
  final phoneController = TextEditingController();
  final landmarkController = TextEditingController();
  final genderController = TextEditingController();
  final locationController = TextEditingController();
  final religiousAffiliationController = TextEditingController();
  final evangelismGroundsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.addListener(_updateStepState);
    phoneController.addListener(_updateStepState);
    landmarkController.addListener(_updateStepState);
    genderController.addListener(_updateStepState);
    locationController.addListener(_updateStepState);
    religiousAffiliationController.addListener(_updateStepState);
    evangelismGroundsController.addListener(_updateStepState);
  }

  @override
  void dispose() {
    titleController.removeListener(_updateStepState);
    phoneController.removeListener(_updateStepState);
    landmarkController.removeListener(_updateStepState);
    genderController.removeListener(_updateStepState);
    locationController.removeListener(_updateStepState);
    religiousAffiliationController.removeListener(_updateStepState);
    evangelismGroundsController.removeListener(_updateStepState);

    titleController.dispose();
    phoneController.dispose();
    landmarkController.dispose();
    genderController.dispose();
    locationController.dispose();
    religiousAffiliationController.dispose();
    evangelismGroundsController.dispose();
    super.dispose();
  }

  void _updateStepState() {
    setState(() {});
  }

  TextStyle _stepTitleStyle(TextEditingController controller) {
    return TextStyle(
      color: controller.text.isNotEmpty
          ? ExtraColors.link
          : ExtraColors.primaryText,
    );
  }

  TextStyle _stepSubtitleStyle(TextEditingController controller) {
    return TextStyle(
      fontSize: 13,
      color: controller.text.isNotEmpty
          ? ExtraColors.linkLight
          : ExtraColors.secondaryText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        appBar: AppBar(title: const Text('Prospect Registration')),
        body: Stepper(
          physics: const BouncingScrollPhysics(),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).scaffoldBackgroundColor,
                        )),
                    onPressed: details.onStepContinue,
                    child: const Text('CONTINUE'),
                  ),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('CANCEL',
                        style: TextStyle(color: ExtraColors.secondaryText)),
                  ),
                ],
              ),
            );
          },
          currentStep: _index,
          onStepTapped: (value) {
            setState(() {
              _index = value;
            });
          },
          onStepCancel: () {
            if (_index == 0) {
              setState(() {
                null;
              });
            } else {
              setState(() {
                _index -= 1;
              });
            }
          },
          onStepContinue: () {
            if (_index + 1 < _stepAmount) {
              setState(() {
                _index += 1;
              });
            } else {
              // Finished with form | submit everything to firebase
            }
          },
          steps: [
            Step(
              state: _index == 0
                  ? StepState.editing
                  : titleController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.indexed,
              isActive:
                  titleController.text.isNotEmpty || _index == 0 ? true : false,
              title: Text("Name the prospect",
                  style: _stepTitleStyle(titleController)),
              subtitle: Text("Required for identification.",
                  style: _stepSubtitleStyle(titleController)),
              content: TextField(
                textInputAction: TextInputAction.done,
                controller: titleController,
                decoration:
                    const InputDecoration(hintText: "Title", filled: true),
              ),
            ),
            Step(
              state: _index == 1
                  ? StepState.editing
                  : phoneController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.indexed,
              isActive:
                  phoneController.text.isNotEmpty || _index == 1 ? true : false,
              title: Text("Mobile number",
                  style: _stepTitleStyle(phoneController)),
              subtitle: Text("Required for contact purposes.",
                  style: _stepSubtitleStyle(phoneController)),
              content: TextField(
                textInputAction: TextInputAction.done,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration:
                    const InputDecoration(hintText: "Mobile", filled: true),
              ),
            ),
            Step(
              state: _index == 2
                  ? StepState.editing
                  : landmarkController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.indexed,
              isActive: landmarkController.text.isNotEmpty || _index == 2
                  ? true
                  : false,
              title:
                  Text("Landmark", style: _stepTitleStyle(landmarkController)),
              subtitle: Text("Required for contact purposes.",
                  style: _stepSubtitleStyle(landmarkController)),
              content: TextField(
                textInputAction: TextInputAction.done,
                controller: landmarkController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Popular Landmark around", filled: true),
              ),
            ),
            Step(
              state: _index == 3
                  ? StepState.editing
                  : genderController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.indexed,
              isActive: genderController.text.isNotEmpty || _index == 3,
              title: Text("Gender", style: _stepTitleStyle(genderController)),
              subtitle: Text("Required for identification.",
                  style: _stepSubtitleStyle(genderController)),
              content: TextField(
                controller: genderController,
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    barrierColor: ExtraColors.black.withOpacity(0.5),
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              splashColor: ExtraColors.background,
                              leading: CircleAvatar(
                                  child: SvgPicture.asset(SvgAssets.male)),
                              title: const Text('Male',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  genderController.text = 'Male';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 30, left: 20, right: 20),
                              leading: CircleAvatar(
                                  child: SvgPicture.asset(SvgAssets.female)),
                              splashColor: ExtraColors.background,
                              title: const Text('Female',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  genderController.text = 'Female';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                decoration: const InputDecoration(
                  hintText: "Gender type",
                  filled: true,
                ),
              ),
            ),
            Step(
              state: _index == 4
                  ? StepState.editing
                  : religiousAffiliationController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.indexed,
              isActive:
                  religiousAffiliationController.text.isNotEmpty || _index == 4,
              title: Text("Religious affiliation",
                  style: _stepTitleStyle(religiousAffiliationController)),
              subtitle: Text("Required for identification.",
                  style: _stepSubtitleStyle(religiousAffiliationController)),
              content: TextField(
                controller: religiousAffiliationController,
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    barrierColor: ExtraColors.black.withOpacity(0.5),
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.muslim)),
                              splashColor: ExtraColors.background,
                              title: const Text('Muslim',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Muslim';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.assemblies)),
                              splashColor: ExtraColors.background,
                              title: const Text('Assemblies Of God',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Assemblies Of God';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.catholic)),
                              splashColor: ExtraColors.background,
                              title: const Text('Catholic',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Catholic';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage: AssetImage(ImageAssets.cac)),
                              splashColor: ExtraColors.background,
                              title: const Text('Christ Apostolic Church',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Christ Apostolic Church';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage: AssetImage(ImageAssets.coc)),
                              splashColor: ExtraColors.background,
                              title: const Text('Church Of Christ',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Church Of Christ';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.methodist)),
                              splashColor: ExtraColors.background,
                              title: const Text('Methodist',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Methodist';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.pent)),
                              splashColor: ExtraColors.background,
                              title: const Text('Pentecost',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Pentecost';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.presby)),
                              splashColor: ExtraColors.background,
                              title: const Text('Presbyterian',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Presbyterian';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Material(
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20),
                              leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage(ImageAssets.orthodox)),
                              splashColor: ExtraColors.background,
                              title: const Text('Other Orthodox Churches',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  religiousAffiliationController.text =
                                      'Other Orthodox Churches';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                decoration: const InputDecoration(
                  hintText: "Religious background",
                  filled: true,
                ),
              ),
            ),
            Step(
              state: _index == 5
                  ? StepState.editing
                  : evangelismGroundsController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.indexed,
              isActive:
                  evangelismGroundsController.text.isNotEmpty || _index == 5,
              title: Text("Evangelism grounds",
                  style: _stepTitleStyle(evangelismGroundsController)),
              subtitle: Text("Required for registration.",
                  style: _stepSubtitleStyle(evangelismGroundsController)),
              content: TextField(
                controller: evangelismGroundsController,
                readOnly: true,
                onTap: () {
                  showCupertinoModalPopup(
                    barrierColor: ExtraColors.black.withOpacity(0.5),
                    barrierDismissible: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
                              leading: const CircleAvatar(
                                  child:
                                      Icon(CupertinoIcons.location, size: 20)),
                              splashColor: ExtraColors.background,
                              title: const Text('Asokore Mampong',
                                  style: TextStyle(color: ExtraColors.white)),
                              onTap: () {
                                setState(() {
                                  evangelismGroundsController.text =
                                      'Asokore Mampong';
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                decoration: const InputDecoration(
                  hintText: "Evangelism grounds",
                  filled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
