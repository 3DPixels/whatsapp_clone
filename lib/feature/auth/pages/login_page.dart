import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/extention/custom_theme_extension.dart';
import 'package:whatsapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_clone/common/utils/coloors.dart';
import 'package:whatsapp_clone/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_clone/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_clone/feature/auth/widgets/custom_text_field.dart';

import '../../../common/widgets/custom_icon_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  sendCodeToPhone() {
    final phoneNumber = phoneNumberController.text;
    final countryName = countryNameController.text;
    final countryCode = countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
          context: context, message: 'Please enter your phone number');
    } else if (phoneNumber.length < 9) {
      return showAlertDialog(
          context: context,
          message:
              'The number you entered is too short for the country: $countryName. \n\nInclude your area code if your haven\'t');
    } else if (phoneNumber.length > 10) {
      return showAlertDialog(
          context: context,
          message:
              'The number you entered is too long for the country: $countryName');
    }

    //request a verficiation code
    ref.read(authControllerProvider).sendSmsCode(
          context: context,
          phoneNumber: '+$countryCode$phoneNumber',
        );
  }

  showCountryCodePicker() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['EG'],
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flagSize: 22,
          borderRadius: BorderRadius.circular(20),
          textStyle: TextStyle(color: context.theme.greyColor),
          inputDecoration: InputDecoration(
            labelStyle: TextStyle(color: context.theme.greyColor),
            prefixIcon: const Icon(
              Icons.language,
              color: Coloors.greenDark,
            ),
            hintText: 'Search country code or name',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.theme.greyColor!.withOpacity(0.2),
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Coloors.greenDark,
              ),
            ),
          ),
        ),
        onSelect: (Country value) {
          countryNameController.text = value.name;
          countryCodeController.text = value.phoneCode;
        });
  }

  @override
  void initState() {
    countryNameController = TextEditingController(text: 'Egypt');
    countryCodeController = TextEditingController(text: '20');
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Enter your phone number',
          style: TextStyle(color: context.theme.authAppBarTextColor),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onTap: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: RichText(
              text: TextSpan(
                text: "WhatsApp will need to verify your phone number. ",
                style: TextStyle(
                  color: context.theme.greyColor,
                  height: 1.5,
                ),
                children: [
                  TextSpan(
                    text: "What's my number?",
                    style: TextStyle(
                      color: context.theme.blueColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomTextField(
              onTap: showCountryCodePicker,
              controller: countryNameController,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.arrow_drop_down,
                color: Coloors.greenDark,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: CustomTextField(
                    onTap: showCountryCodePicker,
                    controller: countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomTextField(
                    onTap: () {},
                    controller: phoneNumberController,
                    hintText: 'phone number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Carrier charges may apply',
            style: TextStyle(color: context.theme.greyColor),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: sendCodeToPhone,
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}
