part of 'themes.dart';

extension XFlushbar on Flushbar {
  Flushbar normal(BuildContext context, String message) {
    return _defaultFlushbar(context: context, message: message);
  }

  Flushbar success(BuildContext context, String message) {
    return _defaultFlushbar(context: context, message: message, style: FlushbarStyle.success);
  }

  Flushbar error(BuildContext context, String message) {
    return _defaultFlushbar(context: context, message: message, style: FlushbarStyle.error);
  }
}

enum FlushbarStyle {
  normal,
  success,
  error,
}

Flushbar _defaultFlushbar({required BuildContext context, required String message, style = FlushbarStyle.normal}) {
  final backgroundColor = style == FlushbarStyle.normal
      ? Theme.of(context).colorScheme.primary
      : style == FlushbarStyle.error
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.secondary;
  final color = style == FlushbarStyle.normal
      ? Theme.of(context).colorScheme.onPrimary
      : style == FlushbarStyle.error
          ? Theme.of(context).colorScheme.onError
          : Theme.of(context).colorScheme.onSecondary;
  return Flushbar(
    message: message,
    backgroundColor: backgroundColor,
    messageColor: color,
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 3),
    mainButton: Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(right: 17.5),
          child: Icon(
            AppIcons.close,
            color: color,
          ),
        ),
      );
    }),
    padding: const EdgeInsets.all(17.5),
  );
}
