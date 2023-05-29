import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_package/shared_package.dart';

class AppDialog extends StatelessWidget {
  final Widget? title;
  final Widget body;
  final List<Widget> actions;
  AppDialog({super.key, this.title, required this.body, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: context.dialogWidth(),
          padding: const EdgeInsets.all(AppSizesUnit.medium24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[title!, AppSizesUnit.sizedBox8],
                body,
                AppSizesUnit.sizedBox16,
                Flex(
                  direction: context.isXsScreen() ? Axis.vertical : Axis.horizontal,
                  mainAxisAlignment:
                      context.isXsScreen() ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: context.isXsScreen() ? CrossAxisAlignment.stretch : CrossAxisAlignment.start,
                  children: context.isXsScreen()
                      ? actions.foldRightWithIndex(
                          [], (element, accumulator, index) => [element, AppSizesUnit.sizedBox8, ...accumulator])
                      : actions.foldRightWithIndex(
                          [],
                          (element, accumulator, index) =>
                              [...accumulator, AppSizesUnit.sizedBox8, Expanded(child: element)]),
                )
              ],
            ),
          )),
    );
  }
}

class AppFullPageDialog extends StatelessWidget {
  final Widget body;
  const AppFullPageDialog({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
        // backgroundColor: AppColors.blueGray100,
        child: Padding(
      padding: const EdgeInsets.all(AppSizesUnit.medium24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(AppIcons.close, size: AppSizesUnit.medium24),
              ),
            ],
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
    ));
  }
}
