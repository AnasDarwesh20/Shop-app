import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/shop_app/login/cubit/states.dart';
import 'package:shop_app/shop_app/register/register_screen.dart';
import 'package:shop_app/shop_layout/shop_home.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class ShopLoginScreen extends StatefulWidget {
  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  var emailController = TextEditingController() ;
  var formKey = GlobalKey<FormState>() ;
  var passwordController = TextEditingController() ;

  bool isPasswordShown = true ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit , ShopLoginStates>(
        listener: (context, state)
        {
          if(state is ShopLoginSucessState)
          {
            if(state.loginModel.status)
            {
              print(state.loginModel.data.token) ;
              print(state.loginModel.message) ;
              CacheHelper.saveData(key: 'token' , value: state.loginModel.data.token).then((value)
              {
                token = state.loginModel.data.token ;
                navigateToAndFinish(context, ShopLayout()) ;
                showToast(message: state.loginModel.message, states: ToastStates.SUCCESS) ;
              });
            } else
              {
                showToast(message: state.loginModel.message, states: ToastStates.ERROR ) ;
              }
          }
        },
        builder: (context, state)
        {
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
                          'LOGIN' ,
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.black ,
                          ) ,
                        ) ,
                        SizedBox(
                          height: 10.0,
                        ) ,
                        Text(
                          'login now to browse our hot offers ' ,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.grey[400] ,
                          ),
                        ) ,
                        SizedBox(
                          height: 30.0,
                        ) ,
                        defaultFormField(
                          textInputType: TextInputType.emailAddress,
                          function: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'email must not be empty' ;
                            }
                          },
                          prefixIcon: Icons.email_outlined,
                          controller: emailController,
                          lable: 'Email Address' ,
                        ) ,
                        SizedBox(
                          height: 20.0 ,
                        ) ,

                        defaultFormField(
                          textInputType: isPasswordShown ? TextInputType.visiblePassword : TextInputType.emailAddress,
                          function: (String value)
                          {
                            if(value.isEmpty)
                            {
                              return 'password must not be empty' ;
                            }
                          },
                          isPasswordShown: isPasswordShown ,
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixIcon: isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined ,
                          onTap: (){
                            setState(() {
                              isPasswordShown = !isPasswordShown ;
                            });
                          },
                          onSubmit: (value)
                          {
                            if (formKey.currentState.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text ,
                              );
                            }
                          },
                          controller: passwordController,
                          lable: 'Password',
                        ) ,

                        SizedBox(
                          height:  30.0 ,
                        ) ,
                        ConditionalBuilder(
                          condition: state is! ShopLoginLodingState  ,
                          builder: (context) => butomn(
                            text: 'LOGIN ' ,
                            isUpper: true ,
                            function: () {
                              if (formKey.currentState.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text ,
                                );
                              }
                            } ,
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()) ,
                        ) ,

                        SizedBox(
                          height: 15.0,
                        ) ,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Don't have an account ? "
                            ) ,
                            TextButton(
                              onPressed: ()
                              {
                                navigateTo(context,RegisterScreen()) ;
                              },
                              child: Text(
                                ' REGISTER ' ,
                              ) , ),
                          ],
                        ) ,


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
