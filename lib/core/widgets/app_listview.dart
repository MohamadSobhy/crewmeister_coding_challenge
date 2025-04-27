import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../utils/debouncer.dart';

/// A custom ListView widget that supports pagination and other features.
/// It can be used to create a scrollable list of items with optional separators.
/// The widget provides a builder for creating the list items and
/// a callback for handling pagination events.
/// It also allows for customization of the scroll behavior, padding,
/// and other properties.
///
// ignore: must_be_immutable
class AppListView extends StatelessWidget {
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final Widget? prototypeItem;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final int? Function(Key)? findChildIndexCallback;
  final int? itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final Function()? onPaginate;
  final bool allowPaginationHandling;
  final double paginationThreshold;
  final bool hasSeparator;
  final Function(bool, double)? onScrolling;

  AppListView.builder({
    super.key,
    this.controller,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    required this.itemBuilder,
    this.separatorBuilder,
    this.findChildIndexCallback,
    this.itemCount,
    this.cacheExtent,
    this.semanticChildCount,
    this.restorationId,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.onPaginate,
    this.allowPaginationHandling = false,
    this.paginationThreshold = 50,
    this.hasSeparator = false,
    this.onScrolling,
  });

  AppListView.separated({
    super.key,
    this.controller,
    this.primary,
    this.physics = const BouncingScrollPhysics(),
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    this.findChildIndexCallback,
    this.cacheExtent,
    this.semanticChildCount,
    this.restorationId,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.shrinkWrap = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.onPaginate,
    this.allowPaginationHandling = false,
    this.paginationThreshold = 50,
    this.hasSeparator = true,
    this.onScrolling,
  });

  ScrollController? _scrollController;
  final _debouncer = Debouncer(milliseconds: 300);

  void _onScrolling(BuildContext context) {
    /// Get the current scroll position and the max scroll extent
    final current = _scrollController!.position.pixels;
    final maxExtent = _scrollController!.position.maxScrollExtent;

    /// Calculate the difference between the current position and max extent
    final different = maxExtent - current;

    /// Check if the user is scrolling down
    final isScrollingDown =
        _scrollController!.positions.first.userScrollDirection ==
            ScrollDirection.reverse;

    /// Call the onScrolling callback if provided
    onScrolling?.call(isScrollingDown, current);

    /// If the user is scrolling down and the difference is less than the
    /// pagination threshold, trigger the pagination callback
    /// to load more items
    /// and prevent redundant calls within 300 milliseconds
    /// after the first request
    if (isScrollingDown && different <= paginationThreshold) {
      /// Use debouncer to skip redundant calls within 300 milliseconds
      /// after the first request because this code will be accessed while
      /// differrence between current and maxExtent is les than [paginationThreshold]
      _debouncer.run(() {
        if (onPaginate != null) onPaginate!();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _scrollController = controller ?? ScrollController();

    return hasSeparator
        ? ListView.separated(
            key: key,
            controller: allowPaginationHandling
                ? (_scrollController!..addListener(() => _onScrolling(context)))
                : _scrollController,
            scrollDirection: scrollDirection,
            reverse: reverse,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder!,
            findChildIndexCallback: findChildIndexCallback,
            itemCount: itemCount!,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
          )
        : ListView.builder(
            key: key,
            controller: allowPaginationHandling
                ? (_scrollController!..addListener(() => _onScrolling(context)))
                : _scrollController,
            scrollDirection: scrollDirection,
            reverse: reverse,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            itemExtent: itemExtent,
            prototypeItem: prototypeItem,
            itemBuilder: itemBuilder,
            findChildIndexCallback: findChildIndexCallback,
            itemCount: itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
          );
  }
}
