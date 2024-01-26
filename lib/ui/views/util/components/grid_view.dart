import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

class SliverGridRegularTileCenteredLayout extends SliverGridLayout {
  const SliverGridRegularTileCenteredLayout({
    required this.crossAxisMaxExtent,
    required this.crossAxisCount,
    required this.mainAxisStride,
    required this.crossAxisStride,
    required this.childMainAxisExtent,
    required this.childCrossAxisExtent,
    required this.reverseCrossAxis,
  })  : assert(crossAxisCount > 0),
        assert(mainAxisStride >= 0),
        assert(crossAxisStride >= 0),
        assert(childMainAxisExtent >= 0),
        assert(childCrossAxisExtent >= 0);

  final double crossAxisMaxExtent;

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of pixels from the leading edge of one tile to the leading edge
  /// of the next tile in the main axis.
  final double mainAxisStride;

  /// The number of pixels from the leading edge of one tile to the leading edge
  /// of the next tile in the cross axis.
  final double crossAxisStride;

  /// The number of pixels from the leading edge of one tile to the trailing
  /// edge of the same tile in the main axis.
  final double childMainAxisExtent;

  /// The number of pixels from the leading edge of one tile to the trailing
  /// edge of the same tile in the cross axis.
  final double childCrossAxisExtent;

  /// Whether the children should be placed in the opposite order of increasing
  /// coordinates in the cross axis.
  ///
  /// For example, if the cross axis is horizontal, the children are placed from
  /// left to right when [reverseCrossAxis] is false and from right to left when
  /// [reverseCrossAxis] is true.
  ///
  /// Typically set to the return value of [axisDirectionIsReversed] applied to
  /// the [SliverConstraints.crossAxisDirection].
  final bool reverseCrossAxis;

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    return mainAxisStride > precisionErrorTolerance
        ? crossAxisCount * (scrollOffset ~/ mainAxisStride)
        : 0;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    if (mainAxisStride > 0.0) {
      final mainAxisCount = (scrollOffset / mainAxisStride).ceil();
      return math.max(0, crossAxisCount * mainAxisCount - 1);
    }
    return 0;
  }

  double _getOffsetFromStartInCrossAxis(double crossAxisStart) {
    if (reverseCrossAxis) {
      return crossAxisCount * crossAxisStride -
          crossAxisStart -
          childCrossAxisExtent -
          (crossAxisStride - childCrossAxisExtent);
    }
    return crossAxisStart;
  }

  double _getCrossAxisCenteredOffset(double offset) {
    final crossAxisActualExtent = crossAxisCount * crossAxisStride;
    final crossAxisOffset = (crossAxisMaxExtent - crossAxisActualExtent) / 2;
    return offset + crossAxisOffset;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    final crossAxisStart =
        _getCrossAxisCenteredOffset((index % crossAxisCount) * crossAxisStride);
    return SliverGridGeometry(
      scrollOffset: (index ~/ crossAxisCount) * mainAxisStride,
      crossAxisOffset: _getOffsetFromStartInCrossAxis(crossAxisStart),
      mainAxisExtent: childMainAxisExtent,
      crossAxisExtent: childCrossAxisExtent,
    );
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    if (childCount == 0) {
      // There are no children in the grid. The max scroll offset should be
      // zero.
      return 0;
    }
    final mainAxisCount = ((childCount - 1) ~/ crossAxisCount) + 1;
    final mainAxisSpacing = mainAxisStride - childMainAxisExtent;
    return mainAxisStride * mainAxisCount - mainAxisSpacing;
  }
}

/// GridView delegate which uses a fixed size for each item.
/// Items are cross-axis centered.
class SliverGridDelegateWithFixedSize extends SliverGridDelegate {
  const SliverGridDelegateWithFixedSize({
    required this.crossAxisExtent,
    required this.mainAxisExtent,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
  });

  final double crossAxisExtent,
      mainAxisExtent,
      mainAxisSpacing,
      crossAxisSpacing;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final crossAxisCount = math.max(
      1,
      (constraints.crossAxisExtent / (crossAxisExtent + crossAxisSpacing))
          .floor(),
    );

    return SliverGridRegularTileCenteredLayout(
      crossAxisMaxExtent: constraints.crossAxisExtent,
      childCrossAxisExtent: crossAxisExtent,
      childMainAxisExtent: mainAxisExtent,
      crossAxisCount: crossAxisCount,
      crossAxisStride: crossAxisExtent + crossAxisSpacing,
      mainAxisStride: mainAxisExtent + mainAxisSpacing,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(SliverGridDelegateWithFixedSize oldDelegate) =>
      oldDelegate.crossAxisExtent != crossAxisExtent ||
      oldDelegate.mainAxisExtent != mainAxisExtent ||
      oldDelegate.mainAxisSpacing != mainAxisSpacing ||
      oldDelegate.crossAxisSpacing != crossAxisSpacing;
}
