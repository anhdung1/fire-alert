import 'package:alert_app/blocs/profile_bloc/profile_bloc.dart';
import 'package:alert_app/constant/widget.dart';
import 'package:alert_app/models/user_model.dart';
import 'package:alert_app/repositories/profile_repository.dart';
import 'package:alert_app/services/api_service.dart';
import 'package:alert_app/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Infomation extends StatefulWidget {
  const Infomation({super.key});

  @override
  State<Infomation> createState() => _InfomationState();
}

class _InfomationState extends State<Infomation> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late double screenWidth;
  updateUser(BuildContext profileContext) {
    profileContext.read<ProfileBloc>().add(ProfileUpdateEvent(
        updateUser: UserModel(
            id: -1,
            address: _addressController.text.trim(),
            phoneNumber: _phoneNumberController.text.trim(),
            email: _emailController.text.trim(),
            name: _nameController.text.trim())));
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) =>
                ProfileService(apiService: context.read<ApiService>()),
          ),
          RepositoryProvider(
            create: (context) => ProfileRepository(
                profileService: context.read<ProfileService>()),
          )
        ],
        child: BlocProvider(
          create: (context) => ProfileBloc(context.read<ProfileRepository>())
            ..add(ProfileStartedEvent()),
          child: Builder(
              builder: (context) => BlocConsumer<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileSuccessState) {
                        _nameController.text = state.user!.name;

                        _emailController.text = state.user!.email;
                        _addressController.text = state.user!.name;
                        _phoneNumberController.text = state.user!.name;
                      }
                      return infomationDefaultState(state, context);
                    },
                    listener: (context, state) {
                      if (state is ProfileUpdateSuccessState) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home", ModalRoute.withName('/'));
                      }
                    },
                  )),
        ));
  }

  infomationDefaultState(ProfileState state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Infomation",
          style: TextStyle(fontSize: screenWidth / 13.5),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleTextField("Name"),
                inputText("name", false, _nameController),
                titleTextField("Email"),
                inputText("email", false, _emailController),
                titleTextField("Phone"),
                inputText("phone", false, _phoneNumberController),
                titleTextField("Address"),
                inputText("address", false, _addressController),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: submitButton(() {
                    updateUser(context);
                  }, screenWidth, "Update"),
                ))
              ],
            ),
          ),
          if (state.isLoading) loading()
        ],
      ),
    );
  }

  titleTextField(String title) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 20,
              fontWeight: FontWeight.w600,
            )),
      );
    });
  }
}
