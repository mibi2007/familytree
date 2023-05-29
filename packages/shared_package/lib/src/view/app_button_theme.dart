part of 'themes.dart';

enum ButtonSize {
  small,
  medium,
  large,
}

extension XElevatedButton on ElevatedButton {
  ElevatedButton _size({required BuildContext context, ButtonSize size = ButtonSize.large}) {
    final finalStyle = style != null
        ? style!.copyWith(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: _getVerticalPadding(size), horizontal: _getHorizontalPadding(size))))
        : Theme.of(context).elevatedButtonTheme.style != null
            ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: _getVerticalPadding(size), horizontal: _getHorizontalPadding(size))),
                minimumSize: MaterialStateProperty.all(Size(32, 32)))
            : ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: _getVerticalPadding(size), horizontal: _getHorizontalPadding(size))));
    return ElevatedButton(
      onPressed: onPressed,
      style: finalStyle,
      child: child,
    );
  }

  ElevatedButton _sizeIcon({required BuildContext context, ButtonSize size = ButtonSize.large}) {
    final finalStyle = style != null
        ? style!.copyWith(
            padding: MaterialStateProperty.all(EdgeInsets.all(size == ButtonSize.large ? 12 : 8)),
            iconSize: MaterialStatePropertyAll(size == ButtonSize.small ? 16 : 24),
            minimumSize: MaterialStatePropertyAll(Size(32, 32)),
          )
        : Theme.of(context).elevatedButtonTheme.style != null
            ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  padding: MaterialStateProperty.all(EdgeInsets.all(size == ButtonSize.large ? 12 : 8)),
                  iconSize: MaterialStatePropertyAll(size == ButtonSize.small ? 16 : 24),
                  minimumSize: MaterialStatePropertyAll(Size(32, 32)),
                )
            : ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(size == ButtonSize.large ? 12 : 8)),
                iconSize: MaterialStatePropertyAll(size == ButtonSize.small ? 16 : 24),
                minimumSize: MaterialStatePropertyAll(Size(32, 32)),
              );
    return ElevatedButton(
      onPressed: onPressed,
      style: finalStyle,
      child: child,
    );
  }

  ElevatedButton large(BuildContext context) {
    return _size(context: context);
  }

  ElevatedButton medium(BuildContext context) {
    return _size(context: context, size: ButtonSize.medium);
  }

  ElevatedButton small(BuildContext context) {
    return _size(context: context, size: ButtonSize.small);
  }

  ElevatedButton largeIcon(BuildContext context) {
    return _sizeIcon(context: context);
  }

  ElevatedButton mediumIcon(BuildContext context) {
    return _sizeIcon(context: context, size: ButtonSize.medium);
  }

  ElevatedButton smallIcon(BuildContext context) {
    return _sizeIcon(context: context, size: ButtonSize.small);
  }
}

extension XOutlinedButton on OutlinedButton {
  OutlinedButton _size({required BuildContext context, ButtonSize size = ButtonSize.large}) {
    final finalStyle = style != null
        ? style!.copyWith(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: _getVerticalPadding(size), horizontal: _getHorizontalPadding(size))))
        : Theme.of(context).outlinedButtonTheme.style != null
            ? Theme.of(context).outlinedButtonTheme.style!.copyWith(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: _getVerticalPadding(size), horizontal: _getHorizontalPadding(size))))
            : ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: _getVerticalPadding(size), horizontal: _getHorizontalPadding(size))));
    return OutlinedButton(
      onPressed: onPressed,
      style: finalStyle,
      child: child ?? Container(),
    );
  }

  OutlinedButton _sizeIcon({required BuildContext context, ButtonSize size = ButtonSize.large}) {
    final finalStyle = style != null
        ? style!.copyWith(
            padding: MaterialStateProperty.all(EdgeInsets.all(size == ButtonSize.large ? 12 : 8)),
            iconSize: MaterialStatePropertyAll(size == ButtonSize.small ? 16 : 24),
            minimumSize: MaterialStatePropertyAll(Size(32, 32)),
          )
        : Theme.of(context).outlinedButtonTheme.style != null
            ? Theme.of(context).outlinedButtonTheme.style!.copyWith(
                  padding: MaterialStateProperty.all(EdgeInsets.all(size == ButtonSize.large ? 12 : 8)),
                  iconSize: MaterialStatePropertyAll(size == ButtonSize.small ? 16 : 24),
                  minimumSize: MaterialStatePropertyAll(Size(32, 32)),
                )
            : ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.all(size == ButtonSize.large ? 12 : 8)),
                iconSize: MaterialStatePropertyAll(size == ButtonSize.small ? 16 : 24),
                minimumSize: MaterialStatePropertyAll(Size(32, 32)),
              );
    return OutlinedButton(
      onPressed: onPressed,
      style: finalStyle,
      child: child ?? Container(),
    );
  }

  OutlinedButton large(BuildContext context) {
    return _size(context: context);
  }

  OutlinedButton medium(BuildContext context) {
    return _size(context: context, size: ButtonSize.medium);
  }

  OutlinedButton small(BuildContext context) {
    return _size(context: context, size: ButtonSize.small);
  }

  OutlinedButton largeIcon(BuildContext context) {
    return _sizeIcon(context: context);
  }

  OutlinedButton mediumIcon(BuildContext context) {
    return _sizeIcon(context: context, size: ButtonSize.medium);
  }

  OutlinedButton smallIcon(BuildContext context) {
    return _sizeIcon(context: context, size: ButtonSize.small);
  }
}

double _getVerticalPadding(ButtonSize size) {
  return size == ButtonSize.small ? 8 : 12;
}

double _getHorizontalPadding(ButtonSize size) {
  return size == ButtonSize.small ? 8 : 16;
}
