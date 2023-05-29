// Heavily follow Tailwind CSS https://v1.tailwindcss.com/docs/breakpoints
import 'package:flutter/widgets.dart';

enum ScreenSize { xs, sm, md, lg, xl }

class BreakPoint {
  static int sm640 = 640;
  // => @media (min-width: 640px) { ... }

  static int md768 = 768;
  // => @media (min-width: 768px) { ... }

  static int lg1024 = 1024;
  // => @media (min-width: 1024px) { ... }

  static int xl1280 = 1280;
  // => @media (min-width: 1280px) { ... }
}

extension ScreenSizeHelper on BuildContext {
  ScreenSize get screenSize {
    final screenWidth = MediaQuery.of(this).size.width;
    if (screenWidth >= BreakPoint.sm640 && screenWidth < BreakPoint.md768) {
      return ScreenSize.sm;
    } else if (screenWidth > BreakPoint.md768 && screenWidth <= BreakPoint.lg1024) {
      return ScreenSize.md;
    } else if (screenWidth > BreakPoint.lg1024 && screenWidth <= BreakPoint.xl1280) {
      return ScreenSize.lg;
    } else if (screenWidth > BreakPoint.xl1280) {
      return ScreenSize.xl;
    } else {
      return ScreenSize.xs;
    }
  }

  bool isXsScreen() => screenSize == ScreenSize.xs;
  bool isLargerThanXsScreen() => MediaQuery.of(this).size.width >= BreakPoint.sm640;
  bool isLargerThanSmScreen() => MediaQuery.of(this).size.width >= BreakPoint.md768;
  bool isLargerThanMdScreen() => MediaQuery.of(this).size.width >= BreakPoint.lg1024;
  double dialogWidth() => this.isXsScreen() ? 300 : 400;

  bool responsiveVisibility(
      {required BuildContext context, bool xs = true, bool sm = true, bool md = true, lg = true, xl = true}) {
    var width = MediaQuery.of(context).size.width;
    if (width < BreakPoint.sm640) {
      return xs;
    } else if (width >= BreakPoint.sm640 && width < BreakPoint.md768) {
      return sm;
    } else if (width >= BreakPoint.md768 && width < BreakPoint.lg1024) {
      return md;
    } else if (width >= BreakPoint.lg1024 && width < BreakPoint.xl1280) {
      return lg;
    } else if (width >= BreakPoint.xl1280) {
      return xl;
    }
    return false;
  }
}
