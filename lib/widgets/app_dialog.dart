import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:smart_agri/utils/config.dart';
import 'package:smart_agri/widgets/app_buttons.dart';

class GeneralDialogs {
  static Future showSuccessDialog(context, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return SuccessDialog(
          message: message,
        );
      },
    );
  }

  static Future showOopsDialog(context, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return OopsDialog(
          message: message,
        );
      },
    );
  }

  static Future showYesNoDialog(
    context, {
    required String message,
    required Function onYes,
    required Function onNo,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return YesNoDialog(
          message: message,
          onYes: onYes,
          onNo: onNo,
        );
      },
    );
  }

  static Future showTermsAndConditionsDialog(context) {
    return showDialog(
      context: context,
      builder: (context) {
        return TermsAndConditionsDialog();
      },
    );
  }

  static Future showDialogWithCloseButton({
    required BuildContext context,
    required Widget content,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return GenericDialog(content: content);
      },
    );
  }

  static Future showSomethingWentWrongDialog(context, {String? message}) {
    return GeneralDialogs.showOopsDialog(
      context,
      "Sorry, something went wrong\n\nPlease try again later." +
          (message == null ? "" : "\n\nDetails: $message"),
    );
  }

  static Future showYesOrCancelDialog(
    context, {
    required Future Function() onConfirm,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (context) => YesOrCancelDialog(
        onConfirm: onConfirm,
        message: message,
      ),
    );
  }

  static showImageDialog(BuildContext context, {required String imageURL}) {
    return showDialog(
      context: context,
      builder: (context) {
        return ImageDialog(imageURL: imageURL);
      },
    );
  }

  // static showVideoDialog({
  //   required BuildContext context,
  //   // required VideoPlayerController controller,
  // }) {
  //   return showDialog(
  //     context: context,
  //     // builder: (context) {
  //     //   // return VideoDialog(controller: );
  //     // },
  //   );
  // }
}

class VideoDialog extends StatelessWidget {
  // final VideoPlayerController controller;

  // VideoDialog({
  //   // required this.controller,
  // });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(child: Text("")
                // VideoPlayer(controller),
                ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LoadingButton.secondary(
                buttonText: "Close",
                onTap: () async => Navigator.of(context).pop(),
              ).inExpandedRow(),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String imageURL;

  const ImageDialog({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Text(""),
                // CachedNetworkImage(
                //   fit: BoxFit.cover,
                //   placeholder: (context, url) {
                //     return Center(
                //       child: CircularProgressIndicator.adaptive(),
                //     );
                //   },
                //   imageBuilder: (context, imageProvider) {
                //     return InteractiveViewer(
                //       child: Image(
                //         image: imageProvider,
                //       ),
                //     );
                //   },
                //   errorWidget: (context, url, error) {
                //     print(error);
                //     return Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           "Sorry, there was a problem with displaying this image.",
                //           textAlign: TextAlign.center,
                //         ),
                //         Icon(Icons.error),
                //       ],
                //     );
                //   },
                //   imageUrl: this.imageURL,
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: LoadingButton.secondary(
                buttonText: "Close",
                onTap: () async => Navigator.of(context).pop(),
              ).inExpandedRow(),
            ),
          ],
        ),
      ),
    );
  }
}

class YesNoDialog extends StatelessWidget {
  final String message;
  final Function onYes;
  final Function onNo;

  const YesNoDialog({
    Key? key,
    required this.message,
    required this.onYes,
    required this.onNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: LoadingButton(
                    buttonText: "Yes",
                    buttonColor: myRed,
                    onTap: () => this.onYes(),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: LoadingButton(
                    buttonText: "No",
                    onTap: () async => Navigator.pop(context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OopsDialog extends StatelessWidget {
  final String message;

  const OopsDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ignore: prefer_const_constructors
            Text(
              'OOPS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: myRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              message,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            NormalButton(
              buttonText: "OK",
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String message;

  const SuccessDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'SUCCESS!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: myGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              message,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            NormalButton(
              buttonText: "OK",
              onTap: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}

class TermsAndConditionsDialog extends StatelessWidget {
  TermsAndConditionsDialog({
    Key? key,
    this.onClose,
  }) : super(key: key);
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ExpansionTile(
                  title: Text(
                    "Terms and Conditions",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  children: [
                    Container(
                      height: 600,
                      child: SingleChildScrollView(
                        child: termsAndConditionsHtmlWidget(),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Privacy Policy",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  children: [
                    Container(
                      height: 600,
                      child: SingleChildScrollView(
                        child: privacyPolicyHtmlWidget(),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    "Disclaimer",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  children: [
                    Container(
                      height: 600,
                      child:
                          SingleChildScrollView(child: disclaimerHtmlWidget()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          closeButton(context),
        ],
      ),
    );
  }

  Positioned closeButton(BuildContext context) {
    return Positioned(
      top: -20,
      right: -20,
      child: InkWell(
        onTap: this.onClose ?? () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  Widget privacyPolicyHtmlWidget() {
    return FutureBuilder<String>(
      future: _getPrivacyPolicy(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // return Html(data: snapshot.data!);
        }

        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  Widget disclaimerHtmlWidget() {
    return FutureBuilder<String>(
      future: _getDisclaimer(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // return Html(data: snapshot.data!);
        }

        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  Widget termsAndConditionsHtmlWidget() {
    return FutureBuilder<String>(
      future: _getTermsAndConditions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // return Html(data: snapshot.data!);
        }

        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  Future<String> _getTermsAndConditions() {
    return rootBundle.loadString(
      'assets/legal/Giraffe_Terms_and_Conditions.html',
    );
  }

  Future<String> _getPrivacyPolicy() {
    return rootBundle.loadString(
      'assets/legal/Giraffe_Privacy.html',
    );
  }

  Future<String> _getDisclaimer() {
    return rootBundle.loadString(
      'assets/legal/Giraffe_Disclaimer.html',
    );
  }
}

class GenericDialog extends StatelessWidget {
  final Widget content;

  const GenericDialog({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: this.content),
              ],
            ),
          ),
          closeButton(context),
        ],
      ),
    );
  }

  Positioned closeButton(BuildContext context) {
    return Positioned(
      top: -20,
      right: -20,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }
}

class YesOrCancelDialog extends StatelessWidget {
  const YesOrCancelDialog({
    Key? key,
    required this.onConfirm,
    required this.message,
  }) : super(key: key);

  final Future Function() onConfirm;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.80,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 6,
              fit: FlexFit.tight,
              child: Container(
                child: Center(
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: ElevatedButtonTheme(
                data: ElevatedButtonThemeData(
                  style: Theme.of(context)
                      .elevatedButtonTheme
                      .style!
                      .copyWith(elevation: MaterialStateProperty.all(0)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                        ),
                        child: Container(
                          color: myWhite,
                          child: LoadingButton(
                            onTap: () async => Navigator.pop(context),
                            buttonColor: myWhite,
                            buttonText: 'Cancel',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(32.0),
                        ),
                        child: Container(
                          color: myGreen,
                          child: LoadingButton(
                            onTap: this.onConfirm,
                            buttonColor: myGreen,
                            buttonText: 'Yes',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
