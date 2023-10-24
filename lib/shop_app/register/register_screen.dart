
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_app/register/cubit/cubit.dart';
import 'package:shop_app/shop_app/register/cubit/state.dart';
import 'package:shop_app/shop_layout/shop_home.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  bool isPasswordShown = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSucessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateToAndFinish(context, ShopLayout());
                showToast(
                    message: state.loginModel.message,
                    states: ToastStates.SUCCESS);
              });
            } else {
              showToast(
                  message: state.loginModel.message, states: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'register now to browse our hot offers ',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey[400],
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          textInputType: TextInputType.name,
                          function: (String value) {
                            if (value.isEmpty) {
                              return 'name must not be empty';
                            }
                          },
                          prefixIcon: Icons.person,
                          controller: nameController,
                          lable: 'Name',
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          textInputType: isPasswordShown
                              ? TextInputType.visiblePassword
                              : TextInputType.emailAddress,
                          function: (String value) {
                            if (value.isEmpty) {
                              return 'password must not be empty';
                            }
                          },
                          isPasswordShown: isPasswordShown,
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: isPasswordShown
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          onTap: () {
                            setState(() {
                              isPasswordShown = !isPasswordShown;
                            });
                          },
                          onSubmit: (value) {},
                          controller: passwordController,
                          lable: 'Password',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          textInputType: TextInputType.emailAddress,
                          function: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          prefixIcon: Icons.email_outlined,
                          controller: emailController,
                          lable: 'Email Address',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          textInputType: TextInputType.phone,
                          function: (String value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                          },
                          prefixIcon: Icons.phone,
                          controller: phoneController,
                          lable: 'Phone number',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLodingState,
                          builder: (context) => butomn(
                            text: 'Register ',
                            isUpper: true,
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
