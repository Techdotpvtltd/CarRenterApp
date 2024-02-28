import 'package:beasy/blocs/auth/auth_bloc.dart';
import 'package:beasy/models/user_model.dart';
import 'package:beasy/repositories/repos/user_repo.dart';
import 'package:beasy/utilities/constants/asstes.dart';
import 'package:beasy/utilities/constants/constants.dart';
import 'package:beasy/utilities/constants/style_guide.dart';
import 'package:beasy/utilities/extensions/my_image_picker.dart';
import 'package:beasy/utilities/extensions/navigation_service.dart';
import 'package:beasy/utilities/widgets/custom_title_textfiled.dart';
import 'package:beasy/utilities/widgets/dialogs/dialogs.dart';
import 'package:beasy/utilities/widgets/dialogs/loaders.dart';
import 'package:beasy/utilities/widgets/map_with_text_filed.dart';
import 'package:beasy/utilities/widgets/network_image_widget.dart';
import 'package:beasy/utilities/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../utilities/widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.isShowBack = false,
    this.isEditingEnabled = false,
    this.isCommingFromLogin = false,
  });

  final bool isShowBack;
  final bool isEditingEnabled;
  final bool isCommingFromLogin;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditingEnabled = false;
  String? _errorMessage;
  int? _errorCode;

  final TextEditingController _fnController = TextEditingController();
  final TextEditingController _lnController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  UserLocation? _userLocation;
  String? _imagePath;

  void _updateUserProfile(AuthBloc bloc) async {
    bloc.add(AuthEventUpdateUserProfile(
      firstName: _fnController.text,
      lastName: _lnController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      location: _userLocation,
      imagePath: _imagePath,
    ));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _isEditingEnabled = widget.isEditingEnabled;
      if (!UserRepo().isUserNull) {
        final user = UserRepo().user;
        _fnController.text = user.firstName;
        _emailController.text = user.email;
        _lnController.text = user.lastName;
        _phoneController.text = user.phoneNumber ?? "";
        _imagePath = user.imageUrl;
        _userLocation = user.location;
        _locationController.text = user.location.address ?? "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.isLoading
            ? Loader().show(withText: state.loadingText)
            : Loader().hide();
        if (state is AuthStateUpdatingUserProfile) {
          if (state.exception != null) {
            setState(() {
              if (state.exception?.errorCode != null) {
                _errorCode = state.exception?.errorCode;
                _errorMessage = state.exception?.message;
              } else {
                CustomDilaogs().errorBox(message: state.exception?.message);
              }
            });
          }
        }

        if (state is AuthStateUpdatedUserProfile) {
          if (widget.isCommingFromLogin) {
            NavigationService.back(context);
            return;
          }
          setState(() {
            _isEditingEnabled = false;
          });
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: CustomAppBar(
              isBackButtonVisible: widget.isShowBack,
              title: "Profile",
              actions: [
                Visibility(
                  visible: !_isEditingEnabled,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isEditingEnabled = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8FAFF),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(Assets.penIcon),
                          gapW6,
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontFamily: Assets.plusJakartaFont,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: StyleGuide.primaryColor2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
        body: SafeArea(
          child: CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 33, vertical: 40),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: Center(
                              child: SizedBox(
                                width: 99,
                                height: 99,
                                child:
                                    CircleNetworkImage(url: _imagePath ?? ""),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isEditingEnabled,
                            child: Positioned(
                              right: 0,
                              bottom: 15,
                              child: InkWell(
                                onTap: () async {
                                  final imagePicker =
                                      MyImagePicker(imageQuality: 50);
                                  imagePicker.pick();
                                  imagePicker.onSelection(
                                    (exception, image) {
                                      setState(() {
                                        if (exception != null) {
                                          debugPrint(exception.message);
                                          return;
                                        }
                                        _imagePath = image?.path;
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: StyleGuide.primaryColor2,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.cameraIcon,
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      gapH18,
                      CustomTitleTextField(
                        controller: _isEditingEnabled ? _fnController : null,
                        fieldText: "First Name",
                        hintText: _isEditingEnabled || _fnController.text == ""
                            ? "Enter your first name"
                            : _fnController.text,
                        isShowEdiatbleButton: _isEditingEnabled,
                        isReadyOnly: true,
                        fieldId: 3,
                        errorCode: _errorCode,
                        errorText: _errorMessage,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: _isEditingEnabled ? _lnController : null,
                        fieldText: "Last Name",
                        hintText: _isEditingEnabled || _lnController.text == ""
                            ? "Enter your last name"
                            : _lnController.text,
                        isShowEdiatbleButton: _isEditingEnabled,
                        isReadyOnly: true,
                        fieldId: 4,
                        errorCode: _errorCode,
                        errorText: _errorMessage,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: _isEditingEnabled ? _phoneController : null,
                        fieldText: "Phone Number",
                        hintText:
                            _isEditingEnabled || _phoneController.text == ""
                                ? "+1 xx xxx xxxx"
                                : _phoneController.text,
                        keyboardType: TextInputType.phone,
                        isReadyOnly: true,
                        prefixWidget: IconButton(
                          icon: Image.asset(
                            Assets.flagIcon,
                            fit: BoxFit.fill,
                          ),
                          onPressed: () {},
                        ),
                        isShowEdiatbleButton: _isEditingEnabled,
                      ),
                      gapH24,
                      CustomTitleTextField(
                        controller: _isEditingEnabled ? _emailController : null,
                        fieldText: "Email",
                        hintText:
                            _isEditingEnabled || _emailController.text == ""
                                ? "Enter email"
                                : _emailController.text,
                        keyboardType: TextInputType.emailAddress,
                        isShowEdiatbleButton: _isEditingEnabled,
                        isReadyOnly: true,
                        fieldId: 1,
                        errorCode: _errorCode,
                        errorText: _errorMessage,
                      ),
                      gapH20,
                      MapWithTextField(
                        controller:
                            _isEditingEnabled ? _locationController : null,
                        fieldText: "Change Location",
                        hintText:
                            _isEditingEnabled || _locationController.text == ""
                                ? "Select or Add Location"
                                : _locationController.text,
                        onLocationFetched: (location) {
                          if (_isEditingEnabled) {
                            _userLocation = location;
                          }
                        },
                        isLocationEnabled:
                            _locationController.text != "" && _isEditingEnabled,
                        latLng: !UserRepo().isUserNull
                            ? LatLng(UserRepo().user.location.latitude,
                                UserRepo().user.location.longitude)
                            : null,
                        filedId: 6,
                        errorCode: _errorCode,
                        errorText: _errorMessage,
                        mapHeight: 175,
                      ),
                      const Spacer(),
                      gapH30,
                      Visibility(
                        visible: _isEditingEnabled,
                        child: RoundedButton(
                          title: widget.isCommingFromLogin ? "Save" : "Update",
                          onPressed: () {
                            _updateUserProfile(
                              context.read<AuthBloc>(),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
