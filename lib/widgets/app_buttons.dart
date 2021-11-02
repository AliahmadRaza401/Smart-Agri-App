import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_agri/utils/config.dart';

class LoadingButton extends StatefulWidget {
  final String buttonText;
  final Future Function()? onTap;

  @protected
  final Color? buttonColor;

  @protected
  final Color? textColor;

  const LoadingButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  factory LoadingButton.primary({
    Key? key,
    required String buttonText,
    required Future<void> Function()? onTap,
  }) =>
      LoadingButton(
        key: key,
        buttonText: buttonText,
        onTap: onTap,
        buttonColor: myYellow,
        textColor: myWhite,
      );

  factory LoadingButton.secondary({
    Key? key,
    required String buttonText,
    required Future<void> Function()? onTap,
  }) =>
      LoadingButton(
        key: key,
        buttonText: buttonText,
        onTap: onTap,
        buttonColor: myYellow,
        textColor:myWhite,
      );

  factory LoadingButton.green({
    Key? key,
    required String buttonText,
    required Future<void> Function()? onTap,
  }) =>
      LoadingButton(
        key: key,
        buttonText: buttonText,
        onTap: onTap,
        buttonColor: myGreen,
        textColor: myWhite,
      );

  factory LoadingButton.danger({
    Key? key,
    required String buttonText,
    required Future<void> Function()? onTap,
  }) =>
      LoadingButton(
        key: key,
        buttonText: buttonText,
        onTap: onTap,
        buttonColor: myGreen,
        textColor: myWhite,
      );

  @override
  _LoadingButtonState createState() => _LoadingButtonState();

  /// Makes the button full-width by putting it in an [Expanded] widget, inside a [Row].
  Widget inExpandedRow() {
    return Row(
      children: [Expanded(child: this)],
    );
  }
}

class _LoadingButtonState extends State<LoadingButton>
    with AutomaticKeepAliveClientMixin {
  bool isCallbackExecuting = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var buttonStyle = Theme.of(context).elevatedButtonTheme.style?.copyWith(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
        return widget.buttonColor;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        }
        return widget.textColor;
      }),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: widget.onTap == null ? null : progressIndicatorCallback,
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          child: isCallbackExecuting
              ? const CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Text(
                  widget.buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  progressIndicatorCallback() async {
    if (isCallbackExecuting) return;
    setState(() => isCallbackExecuting = true);
    try {
      if (widget.onTap != null) {
        await widget.onTap!();
      }
    } finally {
      setState(() => isCallbackExecuting = false);
    }
  }

  @override
  bool get wantKeepAlive => true;
}

class NormalButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;

  const NormalButton({
    Key? key,
    required this.buttonText,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(buttonText),
    );
  }
}
