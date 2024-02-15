import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baticraft/menu/menu_home.dart';
import 'package:baticraft/menu/menu_profile.dart';
import 'package:baticraft/menu/menu_pesanan.dart';
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
    menu_home(),
    menu_pesanan(),
    menu_profile(),
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
      selectedIconTheme:
          IconThemeData( color: CustomColors.primaryColor),
      fixedColor: CustomColors.primaryColor,
      unselectedItemColor: CustomColors.primaryColor,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      backgroundColor: CustomColors.whiteColor,
      unselectedLabelStyle: CustomText.TextArvo(1, CustomColors.primaryColor),
      selectedLabelStyle: CustomText.TextArvo(13, CustomColors.primaryColor),
      onTap: _getChangeBottomNav,
      items: [
        BottomNavigationBarItem(
            tooltip: "home",
            icon:Icon(Icons.home_outlined),
            label: "Home",
            activeIcon:Icon(Icons.home),),
        BottomNavigationBarItem(
            tooltip: "Pesanan",
            icon: Icon(Icons.shopping_bag_outlined),
            label: "Pesanan",
            activeIcon:Icon(Icons.shopping_bag)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
            activeIcon:Icon(Icons.person_2),
            tooltip: "Profil"),
      ],
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomNavCubit>().updateIndex(index);
  }
}
