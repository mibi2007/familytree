import 'package:flutter/material.dart';
import 'package:shared_package/shared_package.dart';

/// Use CheckboxListTile as part of Form
class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Key? key,
    Widget? title,
    BuildContext? context,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    ValueChanged<bool>? onChanged,
    AutovalidateMode? autovalidateMode,
    bool enabled = true,
    bool dense = false,
    Color? errorColor,
    Color? activeColor,
    Color? checkColor,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.leading,
    EdgeInsetsGeometry? contentPadding,
    bool autofocus = false,
    Widget? secondary,
    Widget? label,
    BoxDecoration? decoration,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          enabled: enabled,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (FormFieldState<bool> state) {
            errorColor ??= (context == null ? Colors.red : Theme.of(context).colorScheme.error);

            return FocusableActionDetector(
              actions: <Type, Action<Intent>>{
                ActivateIntent: CallbackAction<ActivateIntent>(
                  onInvoke: (ActivateIntent intent) {
                    state.didChange(!state.value!);
                    if (onChanged != null) onChanged(state.value!);
                    return true;
                  },
                ),
              },
              mouseCursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  state.didChange(!state.value!);
                  if (onChanged != null) onChanged(state.value!);
                },
                child: Container(
                  padding: contentPadding ?? EdgeInsets.zero,
                  decoration: decoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: contentPadding == null ? EdgeInsets.only(top: AppSizesUnit.small8) : EdgeInsets.zero,
                        child: CustomPaint(
                          size: Size(AppSizesUnit.medium16, AppSizesUnit.medium16),
                          painter: CheckedCustomPainter(context: context!, isChecked: state.value ?? false),
                        ),
                      ),
                      if (label != null) AppSizesUnit.sizedBox8,
                      if (label != null) Expanded(child: label),
                    ],
                  ),
                ),
              ),
            );
            // return CheckboxListTile(
            //   title: title,
            //   dense: dense,
            //   activeColor: activeColor,
            //   checkColor: checkColor,
            //   value: state.value,
            //   onChanged: enabled
            //       ? (value) {
            //           state.didChange(value);
            //           if (onChanged != null) onChanged(value!);
            //         }
            //       : null,
            //   subtitle: state.hasError
            //       ? Text(
            //           state.errorText!,
            //           style: TextStyle(color: errorColor),
            //         )
            //       : null,
            //   controlAffinity: controlAffinity,
            //   secondary: secondary,
            //   contentPadding: contentPadding,
            //   autofocus: autofocus,
            // );
          },
        );
}
