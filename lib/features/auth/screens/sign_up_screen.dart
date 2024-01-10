import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_odisha_blood/Constant-Widgets/Auth-Screen-Widgets/button.dart';
import 'package:smart_odisha_blood/Constant-Widgets/Auth-Screen-Widgets/text_field.dart';
import 'package:smart_odisha_blood/common/customSnackbar.dart';
import 'package:smart_odisha_blood/features/auth/controller/auth_controller.dart';
import 'package:smart_odisha_blood/features/auth/screens/login_screen.dart';
import 'package:smart_odisha_blood/models/user_model.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _MobileController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();

  void uploadUserModel(UserModel userModel) {
    ref.read(authRepositoryControllerProvider).uploadUserModel(
          userModel: userModel,
          context: context,
        );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _MobileController.dispose();
    _addressController.dispose();
    _districtController.dispose();
    _cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: const Text('Time To Sign-Up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Fill the Detail',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                    controller: _nameController,
                    hintText: 'UserName',
                    onChange: (val) {},
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                    controller: _cityController,
                    hintText: 'Enter City/Village',
                    keyboardType: TextInputType.text,
                    onChange: (val) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                    controller: _districtController,
                    hintText: 'Enter District',
                    onChange: (val) {},
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                    controller: _addressController,
                    hintText: 'Enter Full Address',
                    onChange: (val) {},
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                    controller: _MobileController,
                    hintText: 'Enter Mobile Number',
                    onChange: (val) {},
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthTextField(
                    controller: _passwordController,
                    hintText: 'Enter Password',
                    keyboardType: TextInputType.visiblePassword,
                    isObcureTrue: true,
                    onChange: (val) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      String name = _nameController.text.trim();
                      String mobileNumber =
                          '+91${_MobileController.text.trim()}';
                      String passWord = _passwordController.text.trim();
                      String city = _cityController.text.trim();
                      String district = _districtController.text.trim();
                      String address = _addressController.text.trim();
                      if (name.length < 5) {
                        CustomSnackBar(
                          content: 'Enter Full Name',
                          context: context,
                        ).displaySnackBar();
                      } else if (city.length < 4) {
                        CustomSnackBar(
                          content: 'Enter Full City Name',
                          context: context,
                        ).displaySnackBar();
                      } else if (district.length < 5) {
                        CustomSnackBar(
                          content: 'Enter Full District Name',
                          context: context,
                        ).displaySnackBar();
                      } else if (address.length < 10) {
                        CustomSnackBar(
                          content: 'Enter Full Address Name',
                          context: context,
                        ).displaySnackBar();
                      } else if (mobileNumber.length != 13) {
                        CustomSnackBar(
                          content: 'Check the Mobile Number',
                          context: context,
                        ).displaySnackBar();
                      } else if (passWord.length < 6) {
                        CustomSnackBar(
                          content:
                              'Password Length Should be length of 6 or more',
                          context: context,
                        ).displaySnackBar();
                      } else {
                        UserModel userModel = UserModel(
                          name: name,
                          uid: FirebaseAuth.instance.currentUser!.uid,
                          mobileNumber: mobileNumber,
                          district: district,
                          village: city,
                          password: passWord,
                          address: '',
                        );

                        uploadUserModel(
                          userModel,
                        );
                      }
                    },
                    child: const AuthButton(
                      nameButton: 'Sign Up',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already Register ? Click Here',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}