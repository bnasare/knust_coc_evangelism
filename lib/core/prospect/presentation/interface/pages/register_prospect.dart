import 'dart:async';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:evangelism_admin/core/prospect/presentation/bloc/prospect_mixin.dart';
import 'package:evangelism_admin/shared/data/image_assets.dart';
import 'package:evangelism_admin/shared/presentation/theme/extra_colors.dart';
import 'package:evangelism_admin/shared/presentation/widgets/loading_manager.dart';
import 'package:evangelism_admin/shared/presentation/widgets/warning_modal.dart';
import 'package:evangelism_admin/shared/utils/navigation.dart';
import 'package:evangelism_admin/src/locales/domain/entities/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

import '../../../../../shared/data/register_dialog.dart';
import '../../../domain/entities/prospect.dart';

class RegisterProspectPage extends StatefulWidget with ProspectMixin {
  RegisterProspectPage({super.key});

  @override
  State<RegisterProspectPage> createState() => _RegisterProspectPageState();
}

class _RegisterProspectPageState extends State<RegisterProspectPage> {
  int _index = 0;
  final int _stepAmount = 9;
  bool isLoading = false;
  String? localeName;
  String? localeID;
  StreamSubscription<Locales>? _subscription;

  final groupNumberController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final landmarkController = TextEditingController();
  final genderController = TextEditingController();
  final religiousAffiliationController = TextEditingController();
  final baptismalStatusController = TextEditingController();
  final lessonsController = TextEditingController();
  final localeController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _subscription = widget.getALocale().listen((locale) {
      setState(() {
        localeName = locale.name;
        localeID = locale.id;
        localeController.text = localeName ?? '';
      });
    }, onError: (error) {
      debugPrint(error.toString());
    });

    groupNumberController.addListener(_updateStepState);
    nameController.addListener(_updateStepState);
    phoneController.addListener(_updateStepState);
    landmarkController.addListener(_updateStepState);
    genderController.addListener(_updateStepState);
    religiousAffiliationController.addListener(_updateStepState);
    baptismalStatusController.addListener(_updateStepState);
    lessonsController.addListener(_updateStepState);
    localeController.addListener(_updateStepState);
  }

  @override
  void dispose() {
    groupNumberController.removeListener(_updateStepState);
    nameController.removeListener(_updateStepState);
    phoneController.removeListener(_updateStepState);
    landmarkController.removeListener(_updateStepState);
    genderController.removeListener(_updateStepState);
    religiousAffiliationController.removeListener(_updateStepState);
    baptismalStatusController.removeListener(_updateStepState);
    baptismalStatusController.removeListener(_updateStepState);
    localeController.removeListener(_updateStepState);

    groupNumberController.dispose();
    nameController.dispose();
    phoneController.dispose();
    landmarkController.dispose();
    genderController.dispose();
    religiousAffiliationController.dispose();
    baptismalStatusController.dispose();
    lessonsController.dispose();
    localeController.dispose();
    _searchController.dispose();
    _subscription?.cancel();
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
    return LoadingManager(
      isLoading: isLoading,
      child: ColorfulSafeArea(
        color: Theme.of(context).primaryColor,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                  groupNumberController.clear();
                  nameController.clear();
                  phoneController.clear();
                  landmarkController.clear();
                  genderController.clear();
                  religiousAffiliationController.clear();
                  baptismalStatusController.clear();
                  lessonsController.clear();
                });
              } else {
                setState(() {
                  _index -= 1;
                });
              }
            },
            onStepContinue: () async {
              if (_index + 1 < _stepAmount) {
                setState(() {
                  _index += 1;
                });
              } else {
                if (groupNumberController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    landmarkController.text.isEmpty ||
                    genderController.text.isEmpty ||
                    religiousAffiliationController.text.isEmpty ||
                    baptismalStatusController.text.isEmpty ||
                    lessonsController.text.isEmpty ||
                    localeController.text.isEmpty) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return WarningModal(
                        title: "Some fields are still empty",
                        content: "Please make sure to fill out every step.",
                        primaryButtonLabel: "OK",
                        primaryAction: () {
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  await widget.createAProspect(
                      context: context,
                      prospect: Prospect(
                        evangelismSetting: localeController.text,
                        initialContact: groupNumberController.text,
                        name: nameController.text,
                        mobile: phoneController.text,
                        demographics: landmarkController.text,
                        gender: genderController.text,
                        religiousAffiliation:
                            religiousAffiliationController.text,
                        baptismalStatus: baptismalStatusController.text,
                        interactionDetails: lessonsController.text,
                        id: const Uuid().v4(),
                        localeID: localeID,
                        createdAt: DateTime.fromMillisecondsSinceEpoch(
                            DateTime.now().millisecondsSinceEpoch),
                      ));
                  groupNumberController.clear();
                  nameController.clear();
                  phoneController.clear();
                  landmarkController.clear();
                  genderController.clear();
                  religiousAffiliationController.clear();
                  baptismalStatusController.clear();
                  lessonsController.clear();
                  localeController.clear();
                  setState(() {
                    isLoading = false;
                    _index = 0;
                  });
                }
              }
            },
            steps: [
              Step(
                state: _index == 0
                    ? StepState.editing
                    : localeController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: localeController.text.isNotEmpty || _index == 0,
                title: Text("Evangelism Setting",
                    style: _stepTitleStyle(localeController)),
                subtitle: Text("Required for registration.",
                    style: _stepSubtitleStyle(localeController)),
                content: TextField(
                  controller: localeController,
                  readOnly: true,
                  onTap: null,
                  decoration: const InputDecoration(
                      hintText: "Select location", filled: true),
                ),
              ),
              Step(
                state: _index == 1
                    ? StepState.editing
                    : groupNumberController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: groupNumberController.text.isNotEmpty || _index == 1,
                title: Text("Initial Contact",
                    style: _stepTitleStyle(groupNumberController)),
                subtitle: Text("Group that approached the prospect",
                    style: _stepSubtitleStyle(groupNumberController)),
                content: TextField(
                  controller: groupNumberController,
                  readOnly: true,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return ColorfulSafeArea(
                          color: ExtraColors.background,
                          child: Container(
                            color: ExtraColors.background,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: IconButton.filledTonal(
                                      onPressed: () {
                                        NavigationHelper.navigateBack(context);
                                        _searchController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.close_fullscreen,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0, bottom: 10),
                                  child: SearchBar(
                                    keyboardType: TextInputType.phone,
                                    controller: _searchController,
                                    hintText: 'Search for your group',
                                    textStyle: const MaterialStatePropertyAll(
                                        TextStyle(color: ExtraColors.grey)),
                                    onChanged: (String value) {
                                      setState(() {});
                                    },
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 15)),
                                    leading: const Icon(CupertinoIcons.search,
                                        color: ExtraColors.grey),
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: groupNames
                                              .where((groupName) {
                                                // If the search term is empty, return all groups, else return the filtered list.
                                                return _searchController
                                                        .text.isEmpty ||
                                                    groupName
                                                        .toLowerCase()
                                                        .contains(
                                                            _searchController
                                                                .text
                                                                .toLowerCase());
                                              })
                                              .toList()
                                              .isEmpty
                                          ? [
                                              // Display this when no group names match the search criteria
                                              const Center(
                                                child: Padding(
                                                  padding: EdgeInsets.all(50.0),
                                                  child: Text(
                                                      'Group not available',
                                                      style: TextStyle(
                                                        color: ExtraColors
                                                            .primaryText,
                                                        fontSize: 20.0,
                                                      )),
                                                ),
                                              ),
                                            ]
                                          : groupNames.where((groupName) {
                                              return _searchController
                                                      .text.isEmpty ||
                                                  groupName
                                                      .toLowerCase()
                                                      .contains(
                                                          _searchController.text
                                                              .toLowerCase());
                                            }).map((groupName) {
                                              return Material(
                                                child: ListTile(
                                                  splashColor:
                                                      ExtraColors.background,
                                                  title: Text(groupName,
                                                      style: const TextStyle(
                                                          color: ExtraColors
                                                              .white)),
                                                  onTap: () {
                                                    setState(() {
                                                      groupNumberController
                                                          .text = groupName;
                                                    });
                                                    Navigator.pop(context);
                                                    _searchController.clear();
                                                  },
                                                ),
                                              );
                                            }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: "Select Group",
                    filled: true,
                  ),
                ),
              ),
              Step(
                state: _index == 2
                    ? StepState.editing
                    : nameController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: nameController.text.isNotEmpty || _index == 2
                    ? true
                    : false,
                title: Text("Name the prospect",
                    style: _stepTitleStyle(nameController)),
                subtitle: Text("Capture their full name for future reference.",
                    style: _stepSubtitleStyle(nameController)),
                content: TextField(
                  textInputAction: TextInputAction.done,
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Enter prospect's full name", filled: true),
                ),
              ),
              Step(
                state: _index == 3
                    ? StepState.editing
                    : phoneController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: phoneController.text.isNotEmpty || _index == 3
                    ? true
                    : false,
                title: Text("Mobile number",
                    style: _stepTitleStyle(phoneController)),
                subtitle: Text(
                    "Enter a valid phone number for easy communication.",
                    style: _stepSubtitleStyle(phoneController)),
                content: TextField(
                  textInputAction: TextInputAction.done,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Enter prospect's mobile number(s)",
                      filled: true),
                ),
              ),
              Step(
                state: _index == 4
                    ? StepState.editing
                    : landmarkController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: landmarkController.text.isNotEmpty || _index == 4
                    ? true
                    : false,
                title: Text("Demographics",
                    style: _stepTitleStyle(landmarkController)),
                subtitle: Text(
                    "Provide general information about the prospect's location.",
                    style: _stepSubtitleStyle(landmarkController)),
                content: TextField(
                  textInputAction: TextInputAction.done,
                  controller: landmarkController,
                  decoration: const InputDecoration(
                      hintText: "Landmark (e.g., Near XYZ)", filled: true),
                ),
              ),
              Step(
                state: _index == 5
                    ? StepState.editing
                    : genderController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: genderController.text.isNotEmpty || _index == 5,
                title: Text("Gender", style: _stepTitleStyle(genderController)),
                subtitle: Text("Selecting a gender helps tailor communication.",
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
                          children: genderOptions.map((option) {
                            return Material(
                              child: ListTile(
                                splashColor: ExtraColors.background,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                leading: CircleAvatar(
                                  child: SvgPicture.asset(option["icon"]),
                                ),
                                title: Text(option["gender"],
                                    style: const TextStyle(
                                        color: ExtraColors.white)),
                                onTap: () {
                                  setState(() {
                                    genderController.text = option["gender"];
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: "Select Gender",
                    filled: true,
                  ),
                ),
              ),
              Step(
                state: _index == 6
                    ? StepState.editing
                    : religiousAffiliationController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: religiousAffiliationController.text.isNotEmpty ||
                    _index == 6,
                title: Text("Religious Affiliation",
                    style: _stepTitleStyle(religiousAffiliationController)),
                subtitle: Text("Helps understand their background.",
                    style: _stepSubtitleStyle(religiousAffiliationController)),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
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
                                    splashColor: ExtraColors.background,
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 0, left: 20, right: 20),
                                    leading: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage(ImageAssets.orthodox),
                                    ),
                                    title: TextField(
                                      style: const TextStyle(
                                          color: ExtraColors.white),
                                      onSubmitted: (value) {
                                        if (value.trim().isNotEmpty) {
                                          setState(() {
                                            religiousAffiliationController
                                                .text = value.trim();
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        hintText: 'Enter church name',
                                        hintStyle: TextStyle(
                                          fontSize: 15.5,
                                          color: ExtraColors.secondaryText,
                                        ),
                                        filled: false,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ExtraColors.secondaryText,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ExtraColors.secondaryText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                ...religiousAffiliations.map((affiliation) {
                                  return Material(
                                    child: ListTile(
                                      splashColor: ExtraColors.background,
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 0, left: 20, right: 20),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            AssetImage(affiliation["image"]),
                                      ),
                                      title: Text(affiliation["name"],
                                          style: const TextStyle(
                                              color: ExtraColors.white)),
                                      onTap: () {
                                        setState(() {
                                          religiousAffiliationController.text =
                                              affiliation["name"];
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      },
                      decoration: const InputDecoration(
                        hintText: "Select or enter religious affiliation",
                        filled: true,
                      ),
                    ),
                  ],
                ),
              ),
              Step(
                state: _index == 7
                    ? StepState.editing
                    : baptismalStatusController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive:
                    baptismalStatusController.text.isNotEmpty || _index == 7,
                title: Text("Baptismal Status",
                    style: _stepTitleStyle(baptismalStatusController)),
                subtitle: Text("Provides context for spiritual journey.",
                    style: _stepSubtitleStyle(baptismalStatusController)),
                content: TextField(
                  controller: baptismalStatusController,
                  readOnly: true,
                  onTap: () {
                    showCupertinoModalPopup(
                      barrierColor: ExtraColors.black.withOpacity(0.5),
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: baptismalStatusOptions.map((option) {
                            return Material(
                              child: ListTile(
                                splashColor: ExtraColors.background,
                                contentPadding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                leading: CircleAvatar(
                                  child: Icon(option["icon"], size: 20),
                                ),
                                title: Text(option["status"],
                                    style: const TextStyle(
                                        color: ExtraColors.white)),
                                onTap: () {
                                  setState(() {
                                    baptismalStatusController.text =
                                        option["status"];
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                  decoration: const InputDecoration(
                    hintText: "Select baptismal status",
                    filled: true,
                  ),
                ),
              ),
              Step(
                state: _index == 8
                    ? StepState.editing
                    : lessonsController.text.isNotEmpty
                        ? StepState.complete
                        : StepState.indexed,
                isActive: lessonsController.text.isNotEmpty || _index == 8
                    ? true
                    : false,
                title: Text("Interaction Details",
                    style: _stepTitleStyle(lessonsController)),
                subtitle: Text("Separate details with a comma.",
                    style: _stepSubtitleStyle(lessonsController)),
                content: TextField(
                  textInputAction: TextInputAction.done,
                  controller: lessonsController,
                  decoration: const InputDecoration(
                      hintText:
                          "Enter details of lessons taught (e.g., Baptism, Faith)",
                      filled: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
