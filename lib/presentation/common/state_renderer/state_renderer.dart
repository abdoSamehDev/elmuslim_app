import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/app/utils/constants.dart';

import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //FULL SCREEN STATES
  fullScreenLoadingState,
  fullScreenSuccessState,
  fullScreenErrorState,
  fullScreenEmptyState,

  //GENERAL
  contentState
}

// ignore: must_be_immutable
class StateRender extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  // String title;
  Function retryActionFunction;

  StateRender({
    required this.stateRendererType,
    this.message = Constants.empty,
    // this.title = Constants.empty,
    required this.retryActionFunction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn([
          _getAnimatedImage("animationName"),
          // TODO: put animation loading image
          // _getTitle(title, context),
          _getMessage(message, context)
        ]);
      case StateRendererType.fullScreenSuccessState:
        return _getItemsColumn([
          _getAnimatedImage("animationName"),
          // TODO: put animation success image
          // _getTitle(title, context),
          _getMessage(message, context),
          _getRetryButton(AppStrings.ok.tr(), context)
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage("animationName"), // TODO: put animation error image
          // _getTitle(title, context),
          _getMessage(message, context),
          _getRetryButton(AppStrings.retryAgain.tr(), context)
        ]);

      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn([
          _getAnimatedImage("animationName"), // TODO: put animation empty image
          // _getTitle(title, context),
          _getMessage(message, context),
          _getRetryButton(AppStrings.retryAgain.tr(), context)
        ]);

      case StateRendererType.contentState:
        return Container();

      default:
        return Container();

    }
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  // Widget _getTitle(String title, BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(AppPadding.p8),
  //     child: Text(
  //       title,
  //       style: Theme.of(context).textTheme.headlineLarge,
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }

  Widget _getMessage(String message, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _getRetryButton(String buttonLabel, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          retryActionFunction.call();
        },
        child: Text(buttonLabel));
  }
}
