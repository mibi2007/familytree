import 'package:familytree/src/core/helper/translate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../settings/app/settings_controller.dart';

class LanguageSwitcher extends HookConsumerWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsController = ref.read(settingsNotifierProvider.notifier);
    final state = ref.watch(settingsNotifierProvider);
    final buttonFocusNode = useFocusNode();
    return MenuAnchor(
        childFocusNode: buttonFocusNode,
        menuChildren: <Widget>[
          MenuItemButton(
            onPressed: () => settingsController.updateLocale(const Locale('en')),
            child: const Text('English'),
          ),
          MenuItemButton(
            onPressed: () => settingsController.updateLocale(const Locale('vi')),
            child: const Text('Tiếng Việt'),
          ),
        ],
        builder: (BuildContext context, MenuController controller, Widget? child) {
          return OutlinedButton(
            child: Text(t(context).languageName),
            onPressed: () => controller.open(),
          );
        });
    // return SizedBox(
    //   width: 120,
    //   child: DropdownButtonFormField<Locale>(
    //       icon: const Icon(
    //         Icons.language,
    //         size: AppSizesUnit.medium16,
    //       ),
    //       value: state.locale,
    //       onChanged: controller.updateLocale,
    //       items: const [
    //         DropdownMenuItem(
    //           value: Locale('en'),
    //           child: Text('English'),
    //         ),
    //         DropdownMenuItem(
    //           value: Locale('vi'),
    //           child: Text('Tiếng Việt'),
    //         ),
    //       ]),
    // );
    // return SizedBox(
    //   width: 120,
    //   child: DropdownMenu<Locale>(
    //     leadingIcon: const Icon(Icons.language),
    //     requestFocusOnTap: true,
    //     dropdownMenuEntries: const [
    //       DropdownMenuEntry(
    //         value: Locale('en'),
    //         label: 'English',
    //       ),
    //       DropdownMenuEntry(
    //         value: Locale('vi'),
    //         label: 'Tiếng Việt',
    //       ),
    //     ],
    //     onSelected: (v) => ref.read(settingsNotifierProvider.notifier).updateLocale(v),
    //     initialSelection: ref.read(settingsNotifierProvider).locale,
    //   ),
    // );
  }
}
