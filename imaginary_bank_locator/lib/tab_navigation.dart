import 'package:flutter/material.dart';
import 'package:imaginary_bank_locator/ui/dashboard_controller.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';


class TabNavigation extends StatefulWidget {
  static const route = '/view-map-screen';
  @override
  _TabNavigationState createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  @override
  Widget build(BuildContext context) {
    final dashboardController = context.read<DashboardController>();
    return LayoutBuilder(
      builder: (context, boxConstraint) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(4, 160, 160, 1),
            title: Text('Mobile Assignment'),
            centerTitle: true,
          ),
          body: Selector<DashboardState, Widget Function()>(
            selector: (_, state) => state.page,
            builder: (_, page, __) {
              return page();
            },
          ),
          bottomNavigationBar: Selector<DashboardState, int>(
            selector: (_, state) => state.tabIndex,
            builder: (ctx, tabIndex, __) {
              return BottomNavigationBar(
                backgroundColor: Color.fromRGBO(4, 160, 160, 1),
                selectedFontSize: 16,
                unselectedFontSize: 16,
                type: BottomNavigationBarType.fixed,
                currentIndex: tabIndex,
                onTap: (index) {
                  if (index == 3) {
                    Scaffold.of(ctx).openEndDrawer();
                  } else {
                    dashboardController.navigateToTab(index);
                  }
                },
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.black,
                items: [
                  ...context
                      .read<DashboardController>()
                      .tabs
                      .map(
                        (tab) => BottomNavigationBarItem(
                          backgroundColor: Colors.green,
                          icon: Text(''),
                          label: tab.label,
                        ),
                      )
                      .toList(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
