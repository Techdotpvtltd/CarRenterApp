import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
import 'package:beasy/utilities/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, this.isEnableBackButton = false});
  final bool isEnableBackButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          prefixWidet: !isEnableBackButton
              ? Image.asset(
                  Assets.drawerIcon,
                  color: Colors.black,
                  width: 12,
                  height: 12,
                )
              : null,
          title: AppStrings.notifications,
          onPressedPrefix: !isEnableBackButton
              ? () {
                  context.read<DrawerCubit>().openDrawer();
                }
              : null,
        ),
      ),
      body: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.fromLTRB(30, 4, 22, 4),
          child: NotificationCard(),
        ),
      ),
    );
  }
}
