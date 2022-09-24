import 'package:flutter/material.dart';
import 'package:yuix/yuix.dart';

void main() {
  final view = YuiRouterView(router);
  final app = MaterialApp(home: view);
  runApp(app);
}

// Router
final router = YuiRouter(
  pages: {
    '/a': (params) => pageA(),
    '/b': (params) => pageB(),
  },
  dialogs: {
    '/x': (call) => dialogX(call),
  },
);

// push Page
void pushPage() {
  router.push('/b');
}

// open Dialog
void openDialog() {
  final call = router.open('/x');

  // Listen Tap Event
  call.onEvent((value) {
    router.close(call);
  });
}

// Page A
Widget pageA() {
  return Scaffold(
    appBar: AppBar(title: Text('Page A')),
    body: ElevatedButton(onPressed: pushPage, child: Text('Push To B')),
  );
}

// Page B
Widget pageB() {
  return Scaffold(
    appBar: AppBar(title: Text('Page B')),
    body: ElevatedButton(onPressed: openDialog, child: Text('Open X')),
  );
}

// DialogX
Widget dialogX(YuiCall call) {
  return YuiDialog(
    title: 'YUI',
    description: 'Hello',
    buttons: [
      // Button
      YuiDialogButton(
        type: YuiButtonType.cancel,
        label: 'Cancel',
        onTap: () => call.event('CANCEL'),
      ),

      // Button
      YuiDialogButton(
        type: YuiButtonType.ok,
        label: 'OK',
        onTap: () => call.event('OK'),
      ),
    ],
  );
}
