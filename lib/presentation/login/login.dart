
import 'package:clean_architecture_app/app/di.dart';
import 'package:clean_architecture_app/presentation/login/login_viewmodel.dart';
import 'package:clean_architecture_app/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_app/presentation/resources/color_manager.dart';
import 'package:clean_architecture_app/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_app/presentation/resources/string_manager.dart';
import 'package:clean_architecture_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  final LoginViewModel _viewModel = instance<LoginViewModel>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _bind(){
    _viewModel.start();
    _usernameController.addListener(() => _viewModel.setUsername(_usernameController.text));
    _passwordController.addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(){
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Image(image: AssetImage(ImageAssets.splashLogo),),
                const SizedBox(height: AppSize.s28,),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsUsernameValid,
                    builder: (context, snapshot){
                      return TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: (snapshot.data ?? true) ? null : AppStrings.usernameError
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsPasswordValid,
                    builder: (context, snapshot){
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorText: (snapshot.data ?? true) ? null : AppStrings.passwordError
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSize.s28,),
                Padding(
                  padding: const EdgeInsets.only(left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                    stream: _viewModel.outputIsAllInputsValid,
                    builder: (context, snapshot){
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                          onPressed: (snapshot.data ?? false) ? (){
                            _viewModel.login();
                          } : null,
                          child: const Text(AppStrings.login),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppPadding.p8, left: AppPadding.p28, right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, Routes.forgotPasswordRoute);
                        },
                        child: Text(AppStrings.forgetPassword, style: Theme.of(context).textTheme.subtitle2,),
                      ),
                      TextButton(
                        onPressed: (){
                          Navigator.pushReplacementNamed(context, Routes.registerRoute);
                        },
                        child: Text(AppStrings.registerText, style: Theme.of(context).textTheme.subtitle2,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }
}
