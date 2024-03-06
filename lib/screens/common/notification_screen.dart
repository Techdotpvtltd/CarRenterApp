import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/screens/service_provider/components/quick_notification_widget.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/strings.dart';
import 'package:beasy/utilities/widgets/custom_app_bar.dart';
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
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        child: QuickNotificationWidget(),
      ),
    );
  }
}
