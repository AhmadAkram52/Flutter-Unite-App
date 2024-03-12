import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unite/features/Authentications/controllers/signup_controller.dart';
import 'package:unite/utils/constants/colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController signupCtrl = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width * .8,
              child: const Text(
                textAlign: TextAlign.center,
                "Let’s start from your phone number",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: Get.height * .01),
            Center(
              child: SizedBox(
                width: Get.width * .8,
                child: const Text(
                    "Your number will be used only in urgent situations and won’t be forwarded to third parties. ",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            ),
            SizedBox(height: Get.height * .10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 2)),
                  ),
                  child: CountryCodePicker(
                    onChanged: (val) {
                      signupCtrl.dailCode.value = val.toString();
                      // print("Ahmad : $val");
                    },
                    initialSelection: 'PK',
                    showFlagDialog: true,
                    padding: EdgeInsets.zero,
                    comparator: (a, b) => b.name!.compareTo(a.name.toString()),
                    onInit: (code) {
                      signupCtrl.dailCode.value = code!.dialCode!;
                    },
                    boxDecoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * .55,
                  child: Obx(() {
                    return TextField(
                      controller: signupCtrl.numController,
                      onChanged: (val) {
                        if (val.length == 10) {
                          signupCtrl.numIsValid.value = true;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Phone number",
                          errorText: signupCtrl.numIsValid.value
                              ? null
                              : "invalid number"),
                    );
                  }),
                ),

                // const
              ],
            ),
            SizedBox(height: Get.height * .10),
            SizedBox(
                width: Get.width * .8,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: UColors.primary,
                      foregroundColor: Colors.white),
                  onPressed: () {
                    signupCtrl.toSubmit(context);
                  },
                  child: const Text("Continue"),
                )),
          ],
        ),
      ),
    );
  }
}
