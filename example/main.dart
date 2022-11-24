import 'package:flutter/material.dart';
import 'package:yuix/yuix.dart';

void main() {
  final route = YuiRoute(router);
  final app = MaterialApp(home: route);
  runApp(app);
}

// Main Router
final router = YuiRouter(
  pages: {
    '/a': (state) => MyPageA(),
    '/b': (state) => MyPageB(),
    '/c': (state) => YuiRoute.tabs(tabRouter), // nested
  },
  dialogs: {
    '/x': (state) => MyDialogX(state),
  },
);

// Tab Router
final tabRouter = YuiTabRouter(
  pages: {
    // body pages
    '/p': (state) => MyPageP(),
    '/q': (state) => MyPageQ(),
  },
  items: {
    // bar items
    '/p': (state) => YuiTabItem(state, icon: Icon(Icons.star)),
    '/q': (state) => YuiTabItem(state),
  },
  edge: YuiTabEdge.bottom, // top or bottom
);

//

//

//

// --- Example Widgets ---

//

//

//

// A
class MyPageA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttons = [
      //
      // Button
      //
      ElevatedButton(
        onPressed: () {
          router.push('/b');
        },
        child: const Text('Push To B'),
      ),
      //
      // Button
      //
      ElevatedButton(
        onPressed: () {
          router.push('/c');
        },
        child: const Text('Push To C'),
      ),
      //
      // Button
      //
      ElevatedButton(
        onPressed: () async {
          final dialog = router.open('/x');
          final result = await dialog.receiveTapEvent();
          router.close(dialog);

          /* receive OK */
          if (result == YuiButtonType.ok) {
            debugPrint('received OK');
          }

          /* receive Cancel */
          if (result == YuiButtonType.cancel) {
            debugPrint('received Cancel');
          }

          /* receive custom event */

          // final dialog = router.open('/x');
          // dialog.receive((xxx) {
          //   router.close(dialog);
          // });
        },
        child: const Text('Open X'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Page A')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttons,
        ),
      ),
    );
  }
}

// B
class MyPageB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page B')),
    );
  }
}

// P
class MyPageP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttons = [
      //
      // Button
      //
      ElevatedButton(
        onPressed: () {
          router.pop();
        },
        child: const Text('Pop'),
      ),
    ];
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttons,
        ),
      ),
    );
  }
}

// Q
class MyPageQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page Q'),
      ),
    );
  }
}

// X
class MyDialogX extends StatelessWidget {
  const MyDialogX(this.state);
  final YuiDialogState state;

  @override
  Widget build(BuildContext context) {
    return YuiDialog.test(state);

    /* send OK */
    // state.sendTapEvent(YuiButtonType.ok);

    /* send Cancel */
    // state.sendTapEvent(YuiButtonType.cancel);

    /* send custom event */
    // state.send('XXX');
  }
}
