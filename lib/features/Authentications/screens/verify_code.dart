import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:unite/utils/constants/text.dart';

class CodeVerifyScreen extends StatelessWidget {
  final String verificationId;

  const CodeVerifyScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              width: Get.width * .8,
              child: const Text(
                textAlign: TextAlign.center,
                "Got it, please confirm the number",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: Get.height * .01),
            Center(
              child: SizedBox(
                width: Get.width * .8,
                child: const Text(
                    "You will get a confirmation code via SMS to your number, please enter the code below in order to continue:",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(height: Get.height * .10),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 30,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 6) {
                      return UTexts.invalidCode;
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    inactiveColor: Colors.grey,
                    shape: PinCodeFieldShape.underline,
                    inactiveFillColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    // fieldHeight: 50,
                    borderWidth: 5,
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.black12,
                    activeColor: Colors.black,
                    inactiveBorderWidth: 2,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  // controller: SignupController.instance.codeController,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) async {
                    if (v.length == 6) {
                      // await signupCtrl.verifyCode(smsCode:v, );
                    }
                  },
                  onChanged: (value) {
                    // setState(() {
                    //   currentText = value;
                    // });
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
