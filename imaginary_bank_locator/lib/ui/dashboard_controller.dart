import 'package:flutter/material.dart';
import 'package:imaginary_bank_locator/ui/viewDetails/view_details_screen.dart';
import 'package:imaginary_bank_locator/ui/myLocation/myLocation.dart';
import 'package:imaginary_bank_locator/ui/viewList/view_list_screen.dart';
import 'package:imaginary_bank_locator/ui/viewMap/view_maps_screen.dart';
import 'package:state_notifier/state_notifier.dart';


class DashboardController extends StateNotifier<DashboardState> {
  DashboardController() : super(DashboardInitialState());

  final _history = <DashboardState>[];
  final tabs = [
    DashboardTab(
      
      'My location',
      
      {
        MyLocation: () => MyLocation(),
      },
      Colors.green
    ),
      DashboardTab(
      'Location',
        
      {
        ViewMapsScreen: () => ViewMapsScreen(),
        
      },
      Colors.green
    ),
    DashboardTab(
      'List',
  
      {
        ViewListScreen: () => ViewListScreen(),
      },
      Colors.green
    ),
 
    
  ];

  void navigateToPage(Type pageType) {
    var tab = tabs.firstWhere((tab) => tab.pages.containsKey(pageType));
    if (state.page != tab.pages[pageType]) {
      _history.add(state);
      state = state.copyWith(
        page: tab.pages[pageType],
        tabIndex: tabs.indexOf(tab),
      );
    }
  }

  void navigateToTab(int tabIndex) {
    if (state.tabIndex != tabIndex) {
      _history.add(state);
      state = state.copyWith(
        page: tabs[tabIndex].pages.entries.first.value,
        tabIndex: tabIndex,
      );
    }
  }

  bool hasPreviousSelectedTab() {
    return _history.isNotEmpty;
  }

  void restorePreviousSelectedTab() {
    final previousState = _history.last;
    _history.removeLast();
    state = state.copyWith(
      page: previousState.page,
      tabIndex: previousState.tabIndex,
    );
  }
}

class DashboardTab {
  final String label;
  final Color color;
  final Map<Type, Widget Function()> pages;

  DashboardTab(this.label, this.pages, this.color);
}

class DashboardState {
  final Widget Function() page;
  final int tabIndex;

  DashboardState({
    @required this.page,
    @required this.tabIndex,
  });

  DashboardState copyWith({Widget Function() page, int tabIndex}) {
    return DashboardState(
      page: page ?? this.page,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}

class DashboardInitialState extends DashboardState {
  DashboardInitialState()
      : super(
          page: () => ViewMapsScreen(),
          tabIndex: 1,
        );
}