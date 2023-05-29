import 'package:flutter/material.dart';

import '../../../shared_package.dart';

class AppProgressIndicator extends StatelessWidget {
  final double value;
  const AppProgressIndicator({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizesUnit.small8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(AppSizesUnit.small8 / 2)),
        color: Theme.of(context).colorScheme.outline,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              height: AppSizesUnit.small8,
              width: value * constraints.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(AppSizesUnit.small8 / 2)),
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        );
      }),
    );
  }
}
