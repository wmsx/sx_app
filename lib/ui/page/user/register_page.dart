import 'package:flutter/material.dart';
import 'package:sx_app/constants.dart';
import 'package:sx_app/generated/l10n.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/ui/page/user/login_widget.dart';
import 'package:sx_app/ui/widget/button_progress_indicator.dart';
import 'package:sx_app/view_model/register_model.dart';

import 'login_field_widget.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _rePasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                LoginTopPanel(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LoginLogo(),
                      ProviderWidget<RegisterModel>(
                        model: RegisterModel(),
                        builder: (context, model, child) => Form(
                          onWillPop: () async {
                            return !model.isBusy;
                          },
                          child: LoginFormContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                LoginTextField(
                                  label: S.of(context).userName,
                                  icon: Icons.person_outline,
                                  controller: _nameController,
                                  textInputAction: TextInputAction.next,
                                ),
                                LoginTextField(
                                  label: S.of(context).password,
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  controller: _passwordController,
                                  textInputAction: TextInputAction.next,
                                ),
                                LoginTextField(
                                  label: S.of(context).rePassword,
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                  controller: _rePasswordController,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    return value != _passwordController.text
                                        ? S.of(context).twoPwdDifferent
                                        : null;
                                  },
                                ),
                                RegisterButton(
                                  _nameController,
                                  _passwordController,
                                  _rePasswordController,
                                  model,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final RegisterModel model;

  RegisterButton(this.nameController, this.passwordController,
      this.rePasswordController, this.model);

  @override
  Widget build(BuildContext context) {
    return LoginButtonWidget(
      child: model.isBusy
          ? ButtonProgressIndicator()
          : Text(
              S.of(context).signUp,
              style: TextStyle(
                color: c2,
              ),
            ),
      onPressed: model.isBusy
          ? null
          : () {
              if (Form.of(context).validate()) {
                model
                    .singUp(nameController.text, passwordController.text)
                    .then((value) {
                  if (value) {
                    Navigator.of(context).pop(nameController.text);
                  } else {
                    model.showErrorMessage(context);
                  }
                });
              }
            },
    );
  }
}
