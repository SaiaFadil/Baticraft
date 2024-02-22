import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baticraft/menu/menu_dashboard.dart';
import 'package:baticraft/menu/menu_profil.dart';
import 'package:baticraft/menu/menu_transaksi.dart';
import 'package:baticraft/navigation/bottom_navbar.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class utama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();

        return false;
      },
      child: BlocProvider(
          create: (context) => BottomNavCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: utamaPage(),
          )),
    );
  }
}

class utamaPage extends StatefulWidget {
  @override
  _utamaPageState createState() => _utamaPageState();
}

class _utamaPageState extends State<utamaPage> {
  final _pageNavigation = [
    MenuDashboard(),
    menu_transaksi(),
    menu_profil(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CustomColors.whiteColor,
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    return _pageNavigation.elementAt(index);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      elevation: 30.0,
      currentIndex: context.read<BottomNavCubit>().state,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: CustomColors.secondaryColor),
      fixedColor: CustomColors.secondaryColor,
      unselectedItemColor: CustomColors.HintColor,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      backgroundColor: CustomColors.whiteColor,
      unselectedLabelStyle: CustomText.TextArvo(0, CustomColors.secondaryColor),
      selectedLabelStyle: CustomText.TextArvo(13, CustomColors.secondaryColor),
      onTap: _getChangeBottomNav,
      items: [
        BottomNavigationBarItem(
          tooltip: "Dashboard",
          icon: Icon(Icons.home_filled),
          label: "Home",
          activeIcon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
            tooltip: "Transaksi",
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Transaksi",
            activeIcon: Icon(Icons.shopping_bag)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profil",
            activeIcon: Icon(Icons.person_2),
            tooltip: "Profil"),
      ],
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomNavCubit>().updateIndex(index);
  }
}
