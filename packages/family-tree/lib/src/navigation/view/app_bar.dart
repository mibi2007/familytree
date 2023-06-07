import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_package/shared_package.dart';

import '../../auth/app/current_user_provider.dart';
import '../../core/helper/translate.dart';
import '../../navigation/domain/app_paths.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppPath? backPath;
  const MainAppBar({Key? key, this.backPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(context).location;
    return AppBar(
      leading: currentPath != AppPaths.home.path
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => backPath != null ? context.go(backPath!.path) : context.canPop(),
            )
          : null,
      title: context.isLargerThanSmScreen() ? const TopMenu() : null,
      actions: context.isLargerThanSmScreen()
          ? [const DropdownMenu(), const Icon(Icons.notifications)]
          : [
              // GestureDetector(
              //   onTap: () {},
              //   child: const Icon(AppIcons.notification),
              // ),
              AppSizesUnit.sizedBox24,
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  );
                },
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSizesUnit.menuHeight);
}

class TopMenu extends StatelessWidget {
  const TopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          TopMenuItem(
            appPath: AppPaths.home,
            pageName: t(context).home,
            icon: Icons.home,
          ),
          AppSizesUnit.sizedBox24,
          TopMenuItem(
            appPath: AppPaths.settings,
            pageName: t(context).settings,
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}

class TopMenuItem extends HookWidget {
  final String pageName;
  final AppPath appPath;
  final IconData icon;
  const TopMenuItem({
    required this.pageName,
    required this.appPath,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onHovered = useState<bool>(false);
    final currentPath = GoRouter.of(context).location;
    void goTo(String path) {
      if (path != currentPath) context.go(path);
    }

    final color = currentPath == appPath.path
        ? Theme.of(context).colorScheme.onSecondaryContainer
        : onHovered.value
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.tertiary;

    return GestureDetector(
      onTap: () => goTo(appPath.path),
      child: FocusableActionDetector(
        mouseCursor: currentPath == appPath.path ? MouseCursor.defer : SystemMouseCursors.click,
        onShowHoverHighlight: (value) {
          onHovered.value = value;
        },
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            icon,
            color: color,
          ),
          AppSizesUnit.sizedBox8,
          Heading(
            8,
            pageName,
            color: color,
          ),
        ]),
      ),
    );
  }
}

class DropdownMenu extends ConsumerWidget {
  const DropdownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserState = ref.watch(currentUserProvider);
    return currentUserState.userOption.fold(() => Container(), (user) {
      return Text(user.name);
    });
  }
}
