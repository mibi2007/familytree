import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff7d2c1b),
      surfaceTint: Color(0xff9c4330),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9c4330),
      onPrimaryContainer: Color(0xffffcec3),
      secondary: Color(0xff474a36),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f624c),
      onSecondaryContainer: Color(0xffdbddc2),
      tertiary: Color(0xff4f378a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6750a4),
      onTertiaryContainer: Color(0xffe0d2ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff231917),
      onSurfaceVariant: Color(0xff55423e),
      outline: Color(0xff89726d),
      outlineVariant: Color(0xffdcc1bb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a4),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff3e0500),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff7d2c1b),
      secondaryFixed: Color(0xffe2e5c9),
      onSecondaryFixed: Color(0xff1a1d0c),
      secondaryFixedDim: Color(0xffc6c9ae),
      onSecondaryFixedVariant: Color(0xff454934),
      tertiaryFixed: Color(0xffe9ddff),
      onTertiaryFixed: Color(0xff22005d),
      tertiaryFixedDim: Color(0xffcfbcff),
      onTertiaryFixedVariant: Color(0xff4f378a),
      surfaceDim: Color(0xffe8d6d2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfffceae6),
      surfaceContainerHigh: Color(0xfff7e4e0),
      surfaceContainerHighest: Color(0xfff1dfdb),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff661c0c),
      surfaceTint: Color(0xff9c4330),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9c4330),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff353825),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f624c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3e2578),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6750a4),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff180f0d),
      onSurfaceVariant: Color(0xff44322e),
      outline: Color(0xff624e4a),
      outlineVariant: Color(0xff7e6863),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a4),
      primaryFixed: Color(0xffae513d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8f3a27),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6c6f58),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff545741),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff765fb4),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5d4699),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd4c3bf),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ee),
      surfaceContainer: Color(0xfff7e4e0),
      surfaceContainerHigh: Color(0xffebd9d5),
      surfaceContainerHighest: Color(0xffdfceca),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff581204),
      surfaceTint: Color(0xff9c4330),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff802e1d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b2e1b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff484b36),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff33196e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff513a8d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff392824),
      outlineVariant: Color(0xff584541),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e2c),
      inversePrimary: Color(0xffffb4a4),
      primaryFixed: Color(0xff802e1d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff621809),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff484b36),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff313421),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff513a8d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3a2174),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6b5b2),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffede9),
      surfaceContainer: Color(0xfff1dfdb),
      surfaceContainerHigh: Color(0xffe2d1cd),
      surfaceContainerHighest: Color(0xffd4c3bf),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4a4),
      surfaceTint: Color(0xffffb4a4),
      onPrimary: Color(0xff5e1607),
      primaryContainer: Color(0xff9c4330),
      onPrimaryContainer: Color(0xffffcec3),
      secondary: Color(0xffc6c9ae),
      onSecondary: Color(0xff2f321f),
      secondaryContainer: Color(0xff5f624c),
      onSecondaryContainer: Color(0xffdbddc2),
      tertiary: Color(0xffcfbcff),
      onTertiary: Color(0xff381e72),
      tertiaryContainer: Color(0xff6750a4),
      onTertiaryContainer: Color(0xffe0d2ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1a110f),
      onSurface: Color(0xfff1dfdb),
      onSurfaceVariant: Color(0xffdcc1bb),
      outline: Color(0xffa48b86),
      outlineVariant: Color(0xff55423e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff9c4330),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff3e0500),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff7d2c1b),
      secondaryFixed: Color(0xffe2e5c9),
      onSecondaryFixed: Color(0xff1a1d0c),
      secondaryFixedDim: Color(0xffc6c9ae),
      onSecondaryFixedVariant: Color(0xff454934),
      tertiaryFixed: Color(0xffe9ddff),
      onTertiaryFixed: Color(0xff22005d),
      tertiaryFixedDim: Color(0xffcfbcff),
      onTertiaryFixedVariant: Color(0xff4f378a),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff423734),
      surfaceContainerLowest: Color(0xff140c0a),
      surfaceContainerLow: Color(0xff231917),
      surfaceContainer: Color(0xff271d1b),
      surfaceContainerHigh: Color(0xff322825),
      surfaceContainerHighest: Color(0xff3d3230),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2c9),
      surfaceTint: Color(0xffffb4a4),
      onPrimary: Color(0xff4f0a01),
      primaryContainer: Color(0xffdb735d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdcdec3),
      onSecondary: Color(0xff242715),
      secondaryContainer: Color(0xff90937a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe3d6ff),
      onTertiary: Color(0xff2c1067),
      tertiaryContainer: Color(0xff9a83db),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1a110f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff2d6d0),
      outline: Color(0xffc6aca7),
      outlineVariant: Color(0xffa38b86),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff7e2d1c),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff2b0300),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff661c0c),
      secondaryFixed: Color(0xffe2e5c9),
      onSecondaryFixed: Color(0xff101204),
      secondaryFixedDim: Color(0xffc6c9ae),
      onSecondaryFixedVariant: Color(0xff353825),
      tertiaryFixed: Color(0xffe9ddff),
      onTertiaryFixed: Color(0xff160042),
      tertiaryFixedDim: Color(0xffcfbcff),
      onTertiaryFixedVariant: Color(0xff3e2578),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff4e423f),
      surfaceContainerLowest: Color(0xff0d0605),
      surfaceContainerLow: Color(0xff251b19),
      surfaceContainer: Color(0xff302623),
      surfaceContainerHigh: Color(0xff3b302e),
      surfaceContainerHighest: Color(0xff463b39),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece8),
      surfaceTint: Color(0xffffb4a4),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffaf9d),
      onPrimaryContainer: Color(0xff200200),
      secondary: Color(0xfff0f2d6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc2c5aa),
      onSecondaryContainer: Color(0xff0a0c01),
      tertiary: Color(0xfff5edff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffccb8ff),
      onTertiaryContainer: Color(0xff0f0033),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1a110f),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece8),
      outlineVariant: Color(0xffd8bdb7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff1dfdb),
      inversePrimary: Color(0xff7e2d1c),
      primaryFixed: Color(0xffffdad3),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb4a4),
      onPrimaryFixedVariant: Color(0xff2b0300),
      secondaryFixed: Color(0xffe2e5c9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc6c9ae),
      onSecondaryFixedVariant: Color(0xff101204),
      tertiaryFixed: Color(0xffe9ddff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcfbcff),
      onTertiaryFixedVariant: Color(0xff160042),
      surfaceDim: Color(0xff1a110f),
      surfaceBright: Color(0xff5a4d4b),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff271d1b),
      surfaceContainer: Color(0xff392e2c),
      surfaceContainerHigh: Color(0xff443936),
      surfaceContainerHighest: Color(0xff504442),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
