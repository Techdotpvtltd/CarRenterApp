import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/blocs/drawer/drawer_cubit.dart';
import 'package:beasy/blocs/rental/rental_product_bloc.dart';

import '../blocs/service_provider/sp_bloc.dart';

class AppBlocManager {
  static final AppBlocManager _instance = AppBlocManager._internal();
  late AuthBloc authBloc;
  late RentalProductBloc rentalBloc;
  late SPBloc spBloc;
  late DrawerCubit drawerCubit;
  AppBlocManager._internal() {
    authBloc = AuthBloc();
    rentalBloc = RentalProductBloc();
    spBloc = SPBloc();
    drawerCubit = DrawerCubit();
  }

  factory AppBlocManager() => _instance;
}
