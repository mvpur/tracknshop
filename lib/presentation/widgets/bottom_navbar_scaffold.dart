import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  // #docregion configuration-custom-shell
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The StatefulNavigationShell from the associated StatefulShellRoute is
      // directly passed as the body of the Scaffold.
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'My Warehouse'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Collection List'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => navigationShell.goBranch(index),
      ),
    );
  }

  // #enddocregion configuration-custom-shell

  /// NOTE: For a slightly more sophisticated branch switching, change the onTap
  /// handler on the BottomNavigationBar above to the following:
  /// `onTap: (int index) => _onTap(context, index),`
  // ignore: unused_element
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
