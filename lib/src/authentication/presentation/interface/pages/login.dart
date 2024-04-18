import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/extra_colors.dart';
import '../../../../../shared/presentation/widgets/loading_manager.dart';
import '../../../../../shared/utils/validator.dart';
import '../../bloc/auth_mixin.dart';

class LoginPage extends StatefulWidget with AuthMixin {
  static const routeName = '/LoginPage';
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  bool _isAgreedToTerms = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      _formKey.currentState!.save();
      await widget.loginUser(
        context: context,
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ExtraColors.link,
      resizeToAvoidBottomInset: false,
      body: LoadingManager(
        isLoading: isLoading,
        child: Stack(children: [
          // Container(
          //   color: Colors.black.withOpacity(0.7),
          // ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2027),
                  ExtraColors.link,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 120.0,
                ),
                const Text(
                  'Hello, Ministry Member !',
                  style: TextStyle(
                      color: ExtraColors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "Sign in to manage outreach efforts.",
                  style: TextStyle(
                    color: ExtraColors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validator.email,
                          style: const TextStyle(color: ExtraColors.link),
                          decoration: InputDecoration(
                              filled: false,
                              hintText: 'Church mail',
                              hintStyle: TextStyle(
                                  color: ExtraColors.white.withOpacity(0.7)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ExtraColors.white)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ExtraColors.white)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error))),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //Password
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormOnLogin();
                          },
                          controller: passwordTextController,
                          focusNode: _passFocusNode,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: Validator.password,
                          style: const TextStyle(color: ExtraColors.linkLight),
                          decoration: InputDecoration(
                              filled: false,
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: ExtraColors.white.withOpacity(0.7),
                                  )),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: ExtraColors.white.withOpacity(0.7)),
                              contentPadding:
                                  const EdgeInsets.only(top: 10, left: 10),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ExtraColors.white)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: ExtraColors.white)),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error)),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .error))),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Transform.translate(
                              offset: const Offset(-15.0, 0.0),
                              child: Checkbox(
                                value: _isAgreedToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _isAgreedToTerms = value!;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: Transform.translate(
                                offset: const Offset(-10.0, 0.0),
                                child: const Text(
                                    'I affirm Ministry membership or permission to access this app.',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: ExtraColors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _isAgreedToTerms ? _submitFormOnLogin : null,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(double.maxFinite, 50),
                    ),
                    elevation: MaterialStateProperty.all(4),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Theme.of(context).colorScheme.primaryContainer;
                        }
                        return Theme.of(context).colorScheme.primary;
                      },
                    ),
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                  ),
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: _isAgreedToTerms
                            ? ExtraColors.white
                            : ExtraColors.darkGrey),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
