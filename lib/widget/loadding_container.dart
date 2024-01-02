import 'package:flutter/material.dart';

//加载进度条组件
class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key? key,
    required this.child,
    required this.isLoading,
    this.cover=false,
  }) : super(key: key);

  final Widget child;
  final bool isLoading;
  final bool cover;

  @override
  Widget build(BuildContext context) {
    return !cover
        ? !isLoading
        ? child
        : _loadingView
        : Stack(
      children: [
        child,
        if (isLoading) _loadingView as Widget, // 显式转换类型
      ],
    );
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
