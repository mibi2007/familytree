import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;

import '../../../shared_package.dart';

class CupertinoPickerOptions<T> extends StatefulWidget {
  final List<T> options;
  final Option<Function> onPicked;
  final Option<T> selectedOption;
  final String placeholder;
  const CupertinoPickerOptions({
    Key? key,
    required this.onPicked,
    required this.options,
    required this.selectedOption,
    this.placeholder = '',
  }) : super(key: key);

  @override
  State<CupertinoPickerOptions> createState() => _CupertinoPickerOptionsState();
}

class _CupertinoPickerOptionsState extends State<CupertinoPickerOptions> {
  int selectedIndex = 0;
  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    setState(() {
      selectedIndex = widget.options.indexOf(widget.selectedOption);
    });
    showCupertinoModalPopup<void>(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    const double kItemExtent = 32.0;
    return GestureDetector(
      // Display a CupertinoPicker with list of fruits.
      onTap: () => widget.onPicked.isSome()
          ? _showDialog(
              CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: selectedIndex),
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: kItemExtent,
                // This is called when selected item is changed.
                onSelectedItemChanged: (index) {
                  setState(() {
                    if (widget.options.isEmpty) {
                      selectedIndex = 0;
                    } else {
                      selectedIndex = index;
                      widget.onPicked.getOrElse(() => () {}).call(widget.options[selectedIndex]);
                    }
                  });
                },
                children: List<Widget>.generate(widget.options.length, (int index) {
                  return Center(
                    child: Text(
                      widget.options[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.normal),
                    ),
                  );
                }),
              ),
            )
          : null,
      child: FocusableActionDetector(
        mouseCursor: widget.onPicked.isSome() ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9.5),
          decoration: BoxDecoration(
              color: widget.onPicked.isSome()
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(AppSizesUnit.small5),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.selectedOption.fold(() => widget.placeholder, (t) => t.name),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Icon(
                AppIcons.arrowDown,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
