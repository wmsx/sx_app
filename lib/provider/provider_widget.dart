import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builer;
  final T model;
  final Widget child;
  final Function(T model) onModelReady;

  const ProviderWidget({
    Key key,
    this.builer,
    this.model,
    this.onModelReady,
    this.child,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() {
    return _ProviderWidgetState<T>();
  }
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    widget.onModelReady?.call(model);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer(
        builder: widget.builer,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidget2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A model1, B model2, Widget child)
      builder;
  final A model1;
  final B model2;
  final Widget child;
  final Function(A model1, B model2) onModelReady;

  const ProviderWidget2(
      {Key key,
      @required this.builder,
      @required this.model1,
      @required this.model2,
      this.onModelReady,
      this.child})
      : super(key: key);

  @override
  _ProviderWidgetState2 createState() {
    return _ProviderWidgetState2<A, B>();
  }
}

class _ProviderWidgetState2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget2<A, B>> {
  A model1;
  B model2;

  @override
  void initState() {
    super.initState();
    model1 = widget.model1;
    model2 = widget.model2;
    widget.onModelReady?.call(model1, model2);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      child: Consumer2(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
