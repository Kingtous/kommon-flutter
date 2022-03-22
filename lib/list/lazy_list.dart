import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LazyList<T> extends StatefulWidget {
  final Function(T data) buildItem;
  final Future<List<T>> Function(int pageSize, int pageIndex) load;
  final int initialIndex;
  final int pageSize;

  const LazyList(
      {Key? key,
      required this.buildItem,
      required this.load,
      this.initialIndex = 1,
      this.pageSize = 10})
      : super(key: key);

  @override
  _LazyListState<T> createState() => _LazyListState<T>();
}

class _LazyListState<T> extends State<LazyList<T>>
    with AutomaticKeepAliveClientMixin {
  final data = List<T>.empty(growable: true).obs;
  final refresh = RefreshController(initialRefresh: true);
  var index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(
      () => SmartRefresher(
        controller: refresh,
        onRefresh: onRefresh,
        onLoading: onLoad,
        enablePullDown: true,
        enablePullUp: true,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return widget.buildItem(data[index]);
          },
          itemCount: data.length,
        ),
      ),
    );
  }

  void onLoad() {
    widget.load(widget.pageSize, ++index).then((value) {
      if (value.isEmpty) {
        refresh.loadNoData();
      } else {
        data.addAll(value);
        refresh.loadComplete();
      }
    }).catchError((e) {
      refresh.loadFailed();
    });
  }

  void onRefresh() {
    index == widget.initialIndex;
    widget.load(widget.pageSize, index).then((value) {
      if (value.isEmpty) {
        refresh.refreshToIdle();
      } else {
        data.value = value;
        refresh.refreshCompleted();
      }
    }).catchError((e) {
      refresh.refreshFailed();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
