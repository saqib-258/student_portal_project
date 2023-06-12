import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_portal/auth/login_shred_pref.dart';
import 'package:student_portal/main.dart';
import 'package:student_portal/shared/common_widgets/app_text_field.dart';
import 'package:student_portal/shared/common_widgets/background_decoration.dart';
import 'package:student_portal/shared/common_widgets/constant.dart';
import 'package:student_portal/shared/common_widgets/toast.dart';
import 'package:student_portal/shared/configs/theme/app_colors.dart';
import 'package:student_portal/shared/configs/theme/custom_text_styles.dart';
import 'package:student_portal/shared/get_it.dart';
import 'package:student_portal/auth/provider/auth_provider.dart';
import 'package:student_portal/shared/utils/common.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void onLoginPressed(BuildContext context) async {
    final loginProvider = getIt<AuthProvider>();
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showToast("Please fill all the fieds");
      return;
    }
    await loginProvider.loginUser(
        usernameController.text, passwordController.text);
    loginProvider.user?.fold((l) {
      showToast("No internet connection");
    }, (r) async {
      if (r == null) {
        showToast("Invalid credentials");
      } else {
        getIt<LoginSharedPreferences>().setLastLoginValue(r);
        navigate(context, Home(user: r));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider loginProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return BackgroundDecoration(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: Card(
              elevation: 12,
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 160,
                    ),
                    height30(),
                    AppTextField(
                      "Username",
                      controller: usernameController,
                      icon: FontAwesomeIcons.idCard,
                    ),
                    height20(),
                    AppTextField(
                      "Password",
                      controller: passwordController,
                      icon: FontAwesomeIcons.lock,
                      isObscure: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "FORGOT PASSWORD?",
                          style: header3TextStyle.copyWith(color: primaryColor),
                        ),
                      ),
                    ),
                    height30(),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Consumer<AuthProvider>(
                            builder: (context, provider, _) {
                          return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(200, 50),
                                  backgroundColor: primaryColor,
                                  shape: const StadiumBorder()),
                              onPressed: loginProvider.isLoading
                                  ? () {}
                                  : () {
                                      onLoginPressed(context);
                                    },
                              child: loginProvider.isLoading
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: buttonTextStyle,
                                    ));
                        })),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
