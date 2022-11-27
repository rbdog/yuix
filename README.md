# Simple GoRouter Alternative & more

- Pages, Dialogs, Tabs, Loading
- powerful widgets

https://pub.dev/packages/yuix

## init

(global ok)

```
final router = YuiRouter(
  pages: {
    '/a': (state) => PageA(),
    '/b': (state) => PageB(),
    '/c': (state) => PageC(),
  },
  dialogs: {
    '/x': (state) => DialogX(state),
    '/y': (state) => DialogY(state),
  },
);
```

main

```
main() {
  final route = YuiRoute(router);
  final app = MaterialApp(home: route);
  runApp(app);
}
```

# Page push & pop

```
// push
router.push('/b');

// pop
router.pop();

// pop until
router.pop(until: '/a');
```

# Dialog open & close

```
// open
final dialog = router.open('/x');

// wait event
await dialog.receiveButtonEvent();

// close
router.close(dialog);
```

# Tab Page


```
final tabRouter = YuiTabRouter(
  pages: {
    '/p': (state) => PageP(),
    '/q': (state) => PageQ(),
  },
);
```

main

```
main() {
  final route = YuiTabRoute(tabRouter),
  ...
}
```

# Nested Route

```
final mainRouter = YuiRouter(
  pages: {
    '/sub': (state) => YuiRoute(subRouter),
  },
);

final subRouter = ...
```

# Path Params

```
pages: {
  '/users/:id': (state) => UserPage(),
},

// router.push('/users/777');

// state.params['id'] => 777
```

# Loading

show loading with a task

```
router.loading(
  label: 'Now Loading...',
  task: () async {
    await Future.delayed(Duration(seconds: 5));
  },
);
```

# Drawer

```
// init
final router = YuiRouter(
  ...
  drawer: () => MyDrawer(),
);


// slide in drawer
router.slideIn();

// slide out drawer 
router.slideOut();
```

😄 Using Navigator 2.0\
🎉 Contributions, issues are welcomed!
