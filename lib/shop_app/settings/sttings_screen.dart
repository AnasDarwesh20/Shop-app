import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_layout/cubit/cubit.dart';
import 'package:shop_app/shop_layout/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopAppCubit.get(context).userModel.data.name;
        emailController.text = ShopAppCubit.get(context).userModel.data.email;
        phoneController.text = ShopAppCubit.get(context).userModel.data.phone;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is ShopUpdateLoadingState) LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textInputType: TextInputType.name,
                  function: (String value) {
                    if (value.isEmpty) {
                      return 'Name must not be empty';
                    }
                  },
                  prefixIcon: Icons.person,
                  controller: nameController,
                  lable: 'name',
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textInputType: TextInputType.emailAddress,
                  function: (String value) {
                    if (value.isEmpty) {
                      return 'Email must not be empty';
                    }
                  },
                  prefixIcon: Icons.email,
                  controller: emailController,
                  lable: 'Email',
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                  textInputType: TextInputType.phone,
                  function: (String value) {
                    if (value.isEmpty) {
                      return 'Phone must not be empty';
                    }
                  },
                  prefixIcon: Icons.phone,
                  controller: phoneController,
                  lable: 'Phone ',
                ),
                Spacer(),
                butomn(
                    text: 'Logout',
                    function: () {
                      signOut(context);
                    }),
                SizedBox(
                  height: 20.0,
                ),
                butomn(
                    text: 'Update',
                    function: () {
                      if (formKey.currentState.validate()) {
                        ShopAppCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
