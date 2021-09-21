import 'package:flutter/material.dart';
import 'package:product_hunt_app/providers/base/provider_base.dart';
import 'package:product_hunt_app/providers/base/provider_helpers.dart';
import 'package:provider/provider.dart';

///  LIMITATIONS OF USING [ProviderConsumer]
/// 1.
/// In case of nested consumers, if parent consumer is listening to same change notifier, then child consumer won't receive callbacks
/// To overcome this, use callbacks on parent consumer, and place conditions for the events

class ProviderConsumer<T extends ProviderBase> extends StatelessWidget {
  // views to display on different states
  final Widget Function(BuildContext, T, Widget) defaultView;
  final Widget Function(BuildContext, T, Widget) loadingView;
  final Widget Function(BuildContext, T, Widget) noInternetView;
  final Widget Function(BuildContext, T, Widget) successView;
  final Widget Function(BuildContext, T, Widget) failedView;
  final Widget child;

  // callback functions for different states
  final Function(BuildContext, T) onLoading;
  final Function(BuildContext, T) onNoInternet;
  final Function(BuildContext, T) onSuccess;
  final Function(BuildContext, T) onFailed;

  ProviderConsumer({
    @required this.defaultView,
    this.child,
    this.loadingView,
    this.noInternetView,
    this.successView,
    this.failedView,
    this.onLoading,
    this.onNoInternet,
    this.onSuccess,
    this.onFailed,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (BuildContext context, T t, Widget _) {
        _onCallbacks(context, t);
        switch (t.state) {
          case ProviderState.loading:
            return (loadingView == null)
                ? defaultView(context, t, child)
                : loadingView(context, t, child);
          case ProviderState.noInternet:
            return (noInternetView == null)
                ? defaultView(context, t, child)
                : noInternetView(context, t, child);
          case ProviderState.success:
            return (successView == null)
                ? defaultView(context, t, child)
                : successView(context, t, child);
          case ProviderState.failed:
            return (failedView == null)
                ? defaultView(context, t, child)
                : failedView(context, t, child);
          default:
            return defaultView(context, t, child);
        }
      },
      child: child,
    );
  }

  /// apply callback functions according to the current state
  /// never change state with notification in callbacks, it will result infinite consumer builds
  /// must change the state to none without notification, otherwise in case ancestor widget is stateful then it might result in infinite callbacks
  void _onCallbacks(BuildContext context, T t) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (t.previousState == t.state && t.previousEvent == t.previousEvent)
        return;
      switch (t.state) {
        case ProviderState.loading:
          if (onLoading != null) onLoading(context, t); //widget callback
          t.onLoad(); //provider class callback
          break;
        case ProviderState.noInternet:
          if (onNoInternet != null) onNoInternet(context, t); //widget callback
          t.onNoInternet(); //provider class callback
          break;
        case ProviderState.success:
          if (onSuccess != null) onSuccess(context, t); //widget callback
          t.onSuccess(); //provider class callback
          break;
        case ProviderState.failed:
          if (onFailed != null) onFailed(context, t); //widget callback
          t.onFailed(); //provider class callback
          break;
        default:
      }
      t.onCallbackComplete();
    });
  }
}
