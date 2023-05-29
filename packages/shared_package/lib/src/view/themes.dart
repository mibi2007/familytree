import 'package:another_flushbar/flushbar.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'app_button_theme.dart';
part 'app_colors.dart';
part 'app_font_sizes.dart';
part 'app_icons.dart';
part 'app_message.dart';
part 'app_spacings.dart';
part 'app_text_theme.dart';
part 'assets.dart';

ThemeData lightTheme() {
  return FlexThemeData.light(
    scheme: FlexScheme.greenM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: false,
      tintedDisabledControls: false,
      useTextTheme: true,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedBorderIsColored: false,
      tooltipRadius: 4,
      tooltipSchemeColor: SchemeColor.inverseSurface,
      tooltipOpacity: 0.9,
      snackBarElevation: 6,
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarIndicatorOpacity: 1.00,
      navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,
      navigationRailLabelType: NavigationRailLabelType.none,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
}

ThemeData darkTheme() {
  return FlexThemeData.dark(
    scheme: FlexScheme.greenM3,
    subThemesData: const FlexSubThemesData(
      interactionEffects: false,
      tintedDisabledControls: false,
      useTextTheme: true,
      inputDecoratorBorderType: FlexInputBorderType.underline,
      inputDecoratorUnfocusedBorderIsColored: false,
      tooltipRadius: 4,
      tooltipSchemeColor: SchemeColor.inverseSurface,
      tooltipOpacity: 0.9,
      snackBarElevation: 6,
      snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
      navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedLabel: false,
      navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationBarMutedUnselectedIcon: false,
      navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationBarIndicatorOpacity: 1.00,
      navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedLabel: false,
      navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
      navigationRailMutedUnselectedIcon: false,
      navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
      navigationRailIndicatorOpacity: 1.00,
      navigationRailBackgroundSchemeColor: SchemeColor.surface,
      navigationRailLabelType: NavigationRailLabelType.none,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    fontFamily: GoogleFonts.montserrat().fontFamily,
  );
}
  // return result.copyWith(
  //   useMaterial3: true,
  //   visualDensity: VisualDensity.standard,
  //   scaffoldBackgroundColor: AppColors.blueGray100,
  //   inputDecorationTheme: InputDecorationTheme(
  //     floatingLabelBehavior: FloatingLabelBehavior.never,
  //     border: MaterialStateOutlineInputBorder.resolveWith((states) {
  //       final bool isFocused = states.contains(MaterialState.focused);
  //       final bool isDisabled = states.contains(MaterialState.disabled);
  //       final bool hasError = states.contains(MaterialState.error);

  //       final Color color = isDisabled
  //           ? AppColors.blueGray400
  //           : hasError
  //               ? AppColors.red
  //               : isFocused
  //                   ? Theme.of(context).colorScheme.primary
  //                   : AppColors.blueGray400;
  //       const double width = 1.0;
  //       const double radius = 5.0;

  //       return OutlineInputBorder(
  //           borderSide: BorderSide(color: color, width: width),
  //           borderRadius: const BorderRadius.all(Radius.circular(radius)));
  //     }),
  //     labelStyle: MaterialStateTextStyle.resolveWith((states) {
  //       final bool isDisabled = states.contains(MaterialState.disabled);
  //       final bool hasError = states.contains(MaterialState.error);

  //       final Color color = isDisabled
  //           ? AppColors.blueGray400
  //           : hasError
  //               ? Theme.of(context).colorScheme.primary
  //               : AppColors.blueGray400;

  //       return result.textTheme.bodyMedium!.copyWith(color: color);
  //     }),
  //     fillColor: MaterialStateColor.resolveWith((states) {
  //       final bool isDisabled = states.contains(MaterialState.disabled);
  //       final bool isHovered = states.contains(MaterialState.hovered);
  //       final Color color = isDisabled
  //           ? AppColors.blueGray200
  //           : isHovered
  //               ? AppColors.blueGray50
  //               : AppColors.white;

  //       return color;
  //     }),
  //     filled: true,
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9.5),
  //   ),
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) {
  //           return AppColors.blueGray200;
  //         }
  //         return AppColors.orange;
  //       }),
  //       foregroundColor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.pressed)) return AppColors.lightOrange3;
  //         if (states.contains(MaterialState.disabled)) return AppColors.blueGray400;
  //         return AppColors.white;
  //       }),
  //       overlayColor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) {
  //           return AppColors.blueGray200;
  //         }
  //         return AppColors.orange;
  //       }),
  //       textStyle: MaterialStateProperty.all(result.textTheme.button!.copyWith(
  //         fontWeight: FontWeight.w600,
  //         fontSize: AppFontSizes.button,
  //       )),
  //       shape:
  //           MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizesUnit.small5))),
  //       elevation: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.hovered)) return 1;
  //         return null;
  //       }),
  //       padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17, horizontal: 20)),
  //       mouseCursor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) return SystemMouseCursors.forbidden;
  //         return SystemMouseCursors.click;
  //       }),
  //     ),
  //   ),
  //   textButtonTheme: TextButtonThemeData(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(Colors.transparent),
  //       foregroundColor: MaterialStateProperty.all(AppColors.orange),
  //       overlayColor: MaterialStateProperty.all(Colors.transparent),
  //       textStyle: MaterialStateProperty.all(
  //         result.textTheme.bodyMedium!.copyWith(
  //             fontWeight: FontWeight.w600, fontSize: AppFontSizes.button, decoration: (TextDecoration.underline)),
  //       ),
  //       mouseCursor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) return SystemMouseCursors.forbidden;
  //         return MaterialStateMouseCursor.clickable;
  //       }),
  //     ),
  //   ),
  //   outlinedButtonTheme: OutlinedButtonThemeData(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(AppColors.white),
  //       foregroundColor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) return AppColors.blueGray400;
  //         return AppColors.orange;
  //       }),
  //       overlayColor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) return AppColors.blueGray300;
  //         return AppColors.white;
  //       }),
  //       textStyle: MaterialStateProperty.resolveWith((states) {
  //         return result.textTheme.bodyMedium!.copyWith(
  //           fontWeight: FontWeight.w600,
  //           fontSize: AppFontSizes.button,
  //           color: states.contains(MaterialState.disabled) ? AppColors.blueGray300 : AppColors.orange,
  //         );
  //       }),
  //       shape: MaterialStateProperty.resolveWith((states) {
  //         return RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(AppSizesUnit.small5),
  //         );
  //       }),
  //       side: MaterialStateProperty.resolveWith((states) {
  //         Color borderColor = AppColors.blueGray300;
  //         if (states.contains(MaterialState.hovered)) {
  //           borderColor = AppColors.orange;
  //         }
  //         return BorderSide(
  //           color: borderColor,
  //         );
  //       }),
  //       elevation: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.hovered)) return 1;
  //         return null;
  //       }),
  //       padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 17, horizontal: 20)),
  //       mouseCursor: MaterialStateProperty.resolveWith((states) {
  //         if (states.contains(MaterialState.disabled)) return SystemMouseCursors.forbidden;
  //         return SystemMouseCursors.click;
  //       }),
  //     ),
  //   ),
  //   canvasColor: AppColors.orange,
  //   drawerTheme: DrawerThemeData(
  //     backgroundColor: Theme.of(context).colorScheme.primary,
  //     elevation: 1.0,
  //     width: double.infinity,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  //     endShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  //   ),
  //   dividerTheme: const DividerThemeData(
  //     endIndent: AppSizesUnit.medium16,
  //     indent: AppSizesUnit.medium16,
  //     space: 0,
  //     color: AppColors.blueGray400,
  //   ),
  //   iconTheme: const IconThemeData(color: AppColors.blueGray400, size: 16).copyWith(size: 16),
  //   primaryIconTheme: const IconThemeData(color: AppColors.orange),
  //   appBarTheme: const AppBarTheme(
  //     color: AppColors.white,
  //     iconTheme: IconThemeData(
  //       color: AppColors.blueGray400,
  //     ),
  //     scrolledUnderElevation: 0,
  //   ),
  //   bottomSheetTheme: const BottomSheetThemeData(
  //     modalBackgroundColor: Theme.of(context).colorScheme.primary,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizesUnit.medium24)),
  //     ),
  //   ),
  //   progressIndicatorTheme: const ProgressIndicatorThemeData(
  //     color: AppColors.lightBlue1,
  //     linearTrackColor: AppColors.blueGray300,
  //   ),
  //   colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).colorScheme.primary).copyWith(error: AppColors.red),
  //   checkboxTheme: CheckboxThemeData(
  //     side: const BorderSide(color: AppColors.blueGray400),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizesUnit.small4)),
  //     splashRadius: AppSizesUnit.small4,
  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //     visualDensity: VisualDensity.compact,
  //     fillColor: MaterialStateProperty.resolveWith((states) {
  //       // if (states.contains(MaterialState.disabled)) return AppColors.blueGray300;
  //       return AppColors.lightBlue1;
  //     }),
  //     checkColor: MaterialStateProperty.resolveWith((states) {
  //       // if (states.contains(MaterialState.disabled)) return AppColors.blueGray400;
  //       return AppColors.white;
  //     }),
  //     overlayColor: MaterialStateProperty.resolveWith((states) {
  //       // if (states.contains(MaterialState.disabled)) return AppColors.blueGray300;
  //       return null;
  //     }),
  //   ),
  //   iconButtonTheme: IconButtonThemeData(
  //     style: ButtonStyle(
  //         overlayColor: MaterialStateProperty.resolveWith((states) {
  //           if (states.contains(MaterialState.disabled)) return AppColors.blueGray300;
  //           return null;
  //         }),
  //         padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
  //         mouseCursor: MaterialStateProperty.resolveWith((states) {
  //           if (states.contains(MaterialState.disabled)) return SystemMouseCursors.forbidden;
  //           return SystemMouseCursors.click;
  //         }),
  //         shape: MaterialStateProperty.resolveWith((states) {
  //           return RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(0),
  //             side: BorderSide.none,
  //           );
  //         }),
  //         iconColor: MaterialStateProperty.resolveWith((states) {
  //           if (states.contains(MaterialState.disabled)) return AppColors.blueGray300;
  //           return AppColors.orange;
  //         }),
  //         iconSize: MaterialStateProperty.all(AppSizesUnit.medium24)),
  //   ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: AppColors.orange,
  //     elevation: 0,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizesUnit.small8)),
  //     iconSize: AppSizesUnit.medium24,
  //   ),
  //   dialogTheme: DialogTheme(
  //     backgroundColor: AppColors.white,
  //     surfaceTintColor: AppColors.white,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizesUnit.small8)),
  //     // titleTextStyle: result.textTheme.bodyMedium!.copyWith(
  //     //   fontWeight: FontWeight.w600,
  //     //   fontSize: AppFontSizes.title,
  //     //   color: AppColors.blueGray800,
  //     // ),
  //     // contentTextStyle: result.textTheme.bodyMedium!.copyWith(
  //     //   fontWeight: FontWeight.w400,
  //     //   fontSize: AppFontSizes.body,
  //     //   color: AppColors.blueGray800,
  //     // ),
  //   ),
  //   dropdownMenuTheme: DropdownMenuThemeData(
  //     // textStyle: const TextStyle(
  //     // fontSize: 30,
  //     // fontWeight: FontWeight.w400,
  //     // color: AppColors.red,
  //     // ),
  //     // menuStyle: MenuStyle(
  //     //   backgroundColor: MaterialStateProperty.all(AppColors.red),
  //     //   padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 18, vertical: 8)),
  //     // ),
  //     inputDecorationTheme: InputDecorationTheme(
  //       labelStyle: TextStyle(color: AppColors.red),
  //       disabledBorder: OutlineInputBorder(
  //         borderSide: const BorderSide(color: AppColors.blueGray300, width: 1),
  //         borderRadius: BorderRadius.circular(AppSizesUnit.small5),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: const BorderSide(color: AppColors.blueGray300, width: 1),
  //         borderRadius: BorderRadius.circular(AppSizesUnit.small5),
  //       ),
  //       border: OutlineInputBorder(
  //         borderSide: const BorderSide(color: AppColors.blueGray300, width: 1),
  //         borderRadius: BorderRadius.circular(AppSizesUnit.small5),
  //       ),
  //       // filled: true,
  //       // fillColor: AppColors.white,
  //     ),
  //   ),
  // );
// }

// ThemeData darkTheme() => ThemeData.dark().copyWith(
//       useMaterial3: true,
//       visualDensity: VisualDensity.standard,
//       colorScheme: ColorScheme.fromSeed(seedColor: Theme.of(context).colorScheme.primary).copyWith(error: AppColors.red),
//       inputDecorationTheme: InputDecorationTheme(
//         border: MaterialStateOutlineInputBorder.resolveWith((states) {
//           // final isFocused = states.contains(MaterialState.focused);
//           final isDisabled = states.contains(MaterialState.disabled);
//           final hasError = states.contains(MaterialState.error);

//           final color = isDisabled
//               ? AppColors.blueGray400
//               : hasError
//                   ? Colors.red
//                   : AppColors.red;
//           const width = 1.0;

//           return OutlineInputBorder(borderSide: BorderSide(color: color, width: width));
//         }),
//       ),
//     );
