import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:islamic_app/app/constants.dart';
import 'package:islamic_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  String? message;

  LoadingState({
    this.message,
  });

  @override
  String getMessage() => message ?? AppStrings.loading.tr();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenLoadingState;
}

class ErrorState extends FlowState {
  String? message;

  ErrorState({
    this.message,
  });

  @override
  String getMessage() => message ?? AppStrings.error.tr();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenErrorState;
}

class SuccessState extends FlowState {
  String? message;

  SuccessState({
    this.message,
  });

  @override
  String getMessage() => message ?? AppStrings.success.tr();

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenSuccessState;
}

class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget screenContentWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        return StateRender(
          stateRendererType: getStateRendererType(),
          retryActionFunction: retryActionFunction,
          message: AppStrings.loading.tr(),
        );
      case ErrorState:
        return StateRender(
          stateRendererType: getStateRendererType(),
          retryActionFunction: retryActionFunction,
          message: AppStrings.error.tr(),
        );
      case SuccessState:
        return StateRender(
          stateRendererType: getStateRendererType(),
          retryActionFunction: retryActionFunction,
          message: AppStrings.success.tr(),
        );
      case EmptyState:
        return StateRender(
          stateRendererType: getStateRendererType(),
          retryActionFunction: retryActionFunction,
          message: getMessage(),
        );
      case ContentState:
        return screenContentWidget;

      default:
        return screenContentWidget;
    }
  }
}
