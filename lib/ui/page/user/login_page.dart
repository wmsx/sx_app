import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sx_app/generated/l10n.dart';
import 'package:sx_app/provider/provider_widget.dart';
import 'package:sx_app/ui/widget/button_progress_indicator.dart';
import 'package:sx_app/view_model/login_model.dart';

import 'login_field_widget.dart';
import 'login_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pwdFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
          ),
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
                      Container(
                        child: ProviderWidget<LoginModel>(
                          model: LoginModel(Provider.of(context)),
                          builer: (context, model, child) {
                            return Form(
                              onWillPop: () async {
                                return !model.isBusy;
                              },
                              child: child,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              LoginTextField(
                                label: S.of(context).userName,
                                icon: Icons.perm_identity,
                                controller: _nameController,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (text) {
                                  FocusScope.of(context)
                                      .requestFocus(_pwdFocus);
                                },
                              ),
                              LoginTextField(
                                controller: _passwordController,
                                label: S.of(context).password,
                                icon: Icons.lock_outline,
                                obscureText: true,
                                focusNode: _pwdFocus,
                                textInputAction: TextInputAction.done,
                              ),
                              LoginButton(_nameController, _passwordController),
                              SignUpWidget(_nameController),
                            ],
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

class LoginButton extends StatelessWidget {
  final nameController;
  final passwordController;

  LoginButton(this.nameController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<LoginModel>(context);
    return LoginButtonWidget(
      child: model.isBusy
          ? ButtonProgressIndicator()
          : Text(
              S.of(context).signIn,
              style: Theme.of(context)
                  .accentTextTheme
                  .title
                  .copyWith(wordSpacing: 0),
            ),
      onPressed: model.isBusy
          ? null
          : () {
              var formState = Form.of(context);
              if (formState.validate()) {}
            },
    );
  }
}

/// LoginPage 按钮样式封装
class LoginButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  LoginButtonWidget({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor.withAlpha(180);
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 40, 15, 20),
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          color: color,
          disabledColor: color,
          borderRadius: BorderRadius.circular(110),
          pressedOpacity: 0.5,
          child: child,
          onPressed: onPressed,
        ));
  }
}

class SignUpWidget extends StatefulWidget {
  final nameController;

  SignUpWidget(this.nameController);

  @override
  _SingUpWidgetState createState() {
    return _SingUpWidgetState();
  }
}

class _SingUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(TextSpan(
        text: S.of(context).noAccount,
        children: [
          TextSpan(
              text: S.of(context).toSignUp,
              style: TextStyle(color: Theme.of(context).accentColor)),
        ],
      )),
    );
  }
}
