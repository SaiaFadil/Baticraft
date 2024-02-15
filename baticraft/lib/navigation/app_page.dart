import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baticraft/navigation/bottom_navbar.dart';


class AppsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      width: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Apps Page',
          style: Theme.of(context).textTheme.headline3,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<BottomNavCubit>().getHome();
          },
          child: Text('GO TO NOTIFICATION'),
        )
      ]),
    );
  }
}