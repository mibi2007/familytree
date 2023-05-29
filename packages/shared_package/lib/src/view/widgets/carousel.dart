import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_package/shared_package.dart';

enum _ItemState { hide, blur, show }

class Carousel extends HookWidget {
  final List<Widget> items;
  final int totalDisplay;
  final double gap;
  final int? defaultPreviousIndex;
  final int? initialIndex;
  final Function(int, int)? onIndexChanged;
  final double? placeholderScale;
  final Duration? duration;
  final Curve? curve;

  int previousIndex = 1;
  Carousel({
    super.key,
    required this.items,
    this.totalDisplay = 3,
    this.gap = 30,
    this.initialIndex,
    this.onIndexChanged,
    this.defaultPreviousIndex = 1,
    this.placeholderScale = 0.9,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutCubic,
  }) {
    if (totalDisplay.isEven) {
      throw Exception("totalDisplay must be odd");
    }
    previousIndex = defaultPreviousIndex ?? (this.totalDisplay / 2).ceil() - 1;
  }

  @override
  Widget build(BuildContext context) {
    final defaultIndex = (totalDisplay / 2).ceil() - 1;
    final index = useState(initialIndex ?? defaultIndex);
    final topOffset = (1 - placeholderScale!) / 2;
    next() {
      previousIndex = index.value;
      index.value++;
      if (onIndexChanged != null) onIndexChanged!(previousIndex, index.value);
    }

    previous() {
      previousIndex = index.value;
      index.value--;
      if (onIndexChanged != null) onIndexChanged!(previousIndex, index.value);
    }

    // if (items.length < totalDisplay) {
    //   items.addAll([totalDisplay - items.length].map((e) => Container()));
    // }
    // final displayItems = useState(items.getRange(0, totalDisplay - 1));
    void _swipe(DragEndDetails details) {
      if (details.primaryVelocity == null || details.primaryVelocity == 0) {
        return;
      }
      if (details.primaryVelocity! < 0) {
        if (index.value < items.length - 2) next();
      }
      if (details.primaryVelocity! > 0) {
        if (index.value > 0) previous();
      }
      return;
    }

    return new LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      final double dimension = constraints.maxWidth - gap * (totalDisplay - 1);
      final double placeholderDimension = dimension * placeholderScale!;
      final double distance = (constraints.maxWidth - 2 * placeholderDimension - dimension > 0)
          ? ((constraints.maxWidth - placeholderDimension) / 2) + dimension
          : (constraints.maxWidth - placeholderDimension) / 2;

      // double _getLeft(int i) {
      //   if (i < index.value - 1 || i > index.value + 1) {
      //     return (dimension / 2).ceil().toDouble();
      //   } else if (i == index.value - 1) {
      //     return 0;
      //   } else if (i == index.value + 1) {
      //     return gap * 2;
      //   } else {
      //     return gap + 10;
      //   }
      // }

      // List<Effect> _getEffects(int i) {
      //   if (i < index.value - 1 || i > index.value + 1) {
      //     return [
      //       FadeEffect(begin: 1, end: 0, duration: Duration(milliseconds: duration)),
      //       // ScaleEffect(begin: 1, end: 0, duration: Duration(milliseconds: duration))
      //     ];
      //   } else if (i == index.value - 1) {
      //     return [
      //       FadeEffect(
      //           begin: previousIndex < index.value ? 1 : 0, end: 0.5, duration: Duration(milliseconds: duration)),
      //     ];
      //   } else if (i == index.value + 1) {
      //     return [
      //       FadeEffect(
      //           begin: previousIndex > index.value ? 1 : 0, end: 0.5, duration: Duration(milliseconds: duration)),
      //     ];
      //   } else {
      //     return [
      //       FadeEffect(begin: 0.5, end: 1, duration: Duration(milliseconds: duration)),
      //     ];
      //   }
      // }

      return Stack(
        children: [
          if (index.value != 0)
            Positioned(
              left: 0,
              top: dimension * topOffset,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => previous(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(AppSizesUnit.small8),
                    ),
                    width: placeholderDimension,
                    height: placeholderDimension,
                  ),
                ),
              ),
            ),
          if (index.value != items.length - 1)
            Positioned(
              left: constraints.maxWidth - placeholderDimension,
              top: dimension * topOffset,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => next(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(AppSizesUnit.small8),
                    ),
                    width: placeholderDimension,
                    height: placeholderDimension,
                  ),
                ),
              ),
            ),
          Positioned(
            width: dimension,
            height: dimension,
            left: gap,
            top: 0,
            child: previousIndex < index.value
                ? items[index.value - 1]
                    .animate(key: ValueKey(index.value - 1))
                    .visibility(end: true, duration: Duration.zero)
                    .fadeOut(
                      duration: duration,
                      curve: curve,
                    )
                    .moveX(
                      begin: 0,
                      end: -distance,
                      curve: curve,
                    )
                    .scale(
                      begin: Offset(1, 1),
                      end: Offset(placeholderScale!, placeholderScale!),
                      curve: curve,
                    )
                    .visibility(
                      end: false,
                    )
                : previousIndex > index.value
                    ? items[index.value + 1]
                        .animate(key: ValueKey(index.value - 1))
                        .visibility(end: true, duration: Duration.zero)
                        .fadeOut(
                          duration: duration,
                          curve: curve,
                        )
                        .moveX(
                          begin: 0,
                          end: distance,
                          curve: curve,
                        )
                        .scale(
                          begin: Offset(1, 1),
                          end: Offset(placeholderScale!, placeholderScale!),
                          curve: curve,
                        )
                        .visibility(
                          end: false,
                        )
                    : Container(),
          ),
          // previousIndex < index.value
          //     ? Positioned(
          //         left: gap,
          //         top: 0,
          //         child: GestureDetector(
          //           onHorizontalDragEnd: _swipe,
          //           dragStartBehavior: DragStartBehavior.down,
          //           child: items[index.value]
          //               .animate(delay: Duration(milliseconds: duration))
          //               .fadeIn()
          //               .moveX(
          //                 begin: 2 * gap,
          //                 end: 0,
          //               )
          //               .scale(
          //                 begin: Offset(placeholderScale!, placeholderScale!),
          //                 end: Offset(1, 1),
          //               ),
          //         ),
          //       )
          //     : previousIndex > index.value
          //         ? Positioned(
          //             left: gap,
          //             top: 0,
          //             child: GestureDetector(
          //               onHorizontalDragEnd: _swipe,
          //               dragStartBehavior: DragStartBehavior.down,
          //               child: items[index.value]
          //                   .animate()
          //                   .fadeIn()
          //                   .moveX(
          //                     begin: -2 * gap,
          //                     end: 0,
          //                   )
          //                   .scale(
          //                     begin: Offset(placeholderScale!, placeholderScale!),
          //                     end: Offset(1, 1),
          //                   ),
          //             ),
          //           )
          //         : Positioned(
          //             // key: ValueKey(index.value),
          //             left: gap,
          //             top: 0,
          //             child: items[index.value],
          //           ),
          Positioned(
            width: dimension,
            height: dimension,
            left: gap,
            top: 0,
            child: GestureDetector(
              onHorizontalDragEnd: _swipe,
              dragStartBehavior: DragStartBehavior.down,
              child: previousIndex < index.value
                  ? items[index.value]
                      .animate(key: ValueKey(index.value))
                      .fadeIn(
                        duration: duration,
                        curve: curve,
                      )
                      .moveX(
                        begin: distance,
                        end: 0,
                        curve: curve,
                      )
                      .scale(
                        begin: Offset(placeholderScale!, placeholderScale!),
                        end: Offset(1, 1),
                      )
                  : previousIndex > index.value
                      ? items[index.value]
                          .animate(key: ValueKey(index.value))
                          .fadeIn(
                            duration: duration,
                            curve: curve,
                          )
                          .moveX(
                            begin: -distance,
                            end: 0,
                            curve: curve,
                          )
                          .scale(
                            begin: Offset(placeholderScale!, placeholderScale!),
                            end: Offset(1, 1),
                          )
                      : items[index.value],
            ),
          ),
          // Positioned(
          //     child: Text(previousIndex < index.value
          //         ? "next"
          //         : previousIndex > index.value
          //             ? "previous"
          //             : "init"),
          //     left: 0,
          //     top: 0)
        ],
      );
    });
  }
}
