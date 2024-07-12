import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const grandisExtendedFont = "Grandis Extended";

// On color 80, 60.... those means opacity

const Color primaryColor = Color(0xFFb88917);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFFb88917, <int, Color>{
  50: Color(0xFFF5E7CC),
  100: Color(0xFFE6C490),
  200: Color(0xFFD6A85A),
  300: Color(0xFFC78D24),
  400: Color(0xFFB37C1A),
  500: Color(0xFFb88917),
  600: Color(0xFF996C12),
  700: Color(0xFF7A540E),
  800: Color(0xFF5B3D0A),
  900: Color(0xFF3D2606),
});

const Color scaffoldColor = Color.fromARGB(255, 233, 237, 247);

const Color blackColor = Color(0xFF16161E);
const Color blackColor80 = Color(0xFF45454B);
const Color blackColor60 = Color(0xFF737378);
const Color blackColor40 = Color(0xFFA2A2A5);
const Color blackColor20 = Color(0xFFD0D0D2);
const Color blackColor10 = Color(0xFFE8E8E9);
const Color blackColor5 = Color(0xFFF3F3F4);

const Color whiteColor = Colors.white;
const Color whiteColor80 = Color(0xFFCCCCCC);
const Color whiteColor60 = Color(0xFF999999);
const Color whiteColor40 = Color(0xFF666666);
const Color whiteColor20 = Color(0xFF333333);
const Color whiteColor10 = Color(0xFF191919);
const Color whiteColor5 = Color(0xFF0D0D0D);

const Color greyColor = Color(0xFFB8B5C3);
const Color lightGreyColor = Color(0xFFF8F8F9);
const Color darkGreyColor = Color(0xFF1C1C25);
const Color greyColor80 = Color(0xFFC6C4CF);
const Color greyColor60 = Color(0xFFD4D3DB);
const Color greyColor40 = Color(0xFFE3E1E7);
const Color greyColor20 = Color(0xFFF1F0F3);
const Color greyColor10 = Color(0xFFF8F8F9);
const Color greyColor5 = Color(0xFFFBFBFC);

const Color purpleColor = Color(0xFF7B61FF);
const Color successColor = Color(0xFF2ED573);
const Color warningColor = Color(0xFFFFBE21);
const Color errorColor = Color(0xFFEA5B5B);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 12.0;
const Duration defaultDuration = Duration(milliseconds: 300);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Mot de passe requis.'),
  MinLengthValidator(8,
      errorText: 'Le mot de passe doit comporter au moins 8 caractères.'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText:
          'Les mots de passe doivent contenir au moins un caractère spécial.')
]);

final emaildValidator = MultiValidator([
  RequiredValidator(errorText: 'Email est requis.'),
  EmailValidator(errorText: "Saisissez une adresse e-mail valide."),
]);

final phoneValidator = MultiValidator([
  RequiredValidator(errorText: "Numéro de téléphone requis."),
  MinLengthValidator(9,
      errorText: "Le Numéro de téléphone doit comporter au moins 9 chiffres.")
]);

const pasNotMatchErrorText = "Les mots de passe ne correspondent pas.";
