import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/current_user_view_model.dart';
import '../../../view_model/login_view_model.dart';

class loginCard extends ConsumerWidget {
  loginCard({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth =
        MediaQuery.of(context).size.width; //for loginCard width
    double screenHeight =
        MediaQuery.of(context).size.height; //for loginCard height

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: 400, minWidth: 500),
        width: screenWidth * 0.35,
        height: screenHeight * 0.45,
        child: Card(
          color: Theme.of(context).colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 32.0, left: 32, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                                FlutterI18n.translate(
                                    context, "tr.login.log_in"),
                                minFontSize: 5,
                                style: Theme.of(context).textTheme.titleLarge!),
                          ),
                          Flexible(
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          border: const UnderlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          labelText:
                              FlutterI18n.translate(context, "tr.login.e-mail"),
                          ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return FlutterI18n.translate(
                              context, "tr.login.email_validation");
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        labelText:
                            FlutterI18n.translate(context, "tr.login.password"),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return FlutterI18n.translate(
                              context, "tr.login.password_validation");
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await ref
                                .read(loginViewModelProvider.notifier)
                                .login(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                            final loginState =
                                ref.watch(loginViewModelProvider);
                            if (loginState == LoginState.success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(FlutterI18n.translate(
                                        context, "tr.login.login_success"))),
                              );
                              Navigator.pushNamed(context, '/orderScreen');
                            } else if (loginState == LoginState.failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(FlutterI18n.translate(
                                        context, "tr.login.login_fail"))),
                              );
                            }
                          } catch (e) {
                            // print(e);
                          }
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                InkWell(
                  onTap: () => _dialogBuilder(context),
                  child: Text(
                    FlutterI18n.translate(context, "tr.login.forget_password"),
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await ref.read(loginViewModelProvider.notifier).login(
                              email: _emailController.text,
                              password: _passwordController.text);
                          final loginState = ref.read(loginViewModelProvider);

                          if (loginState == LoginState.success) {
                            final currentUserInfo = ref.read(getCurrentUserInfoProvider);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(FlutterI18n.translate(
                                      context, "tr.login.login_success"))),
                            );
                            final currentUserAsyncValue =
                                ref.watch(getCurrentUserInfoProvider);
                            await Navigator.pushNamed(context, '/orderScreen');
                          } else if (loginState == LoginState.failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(FlutterI18n.translate(
                                      context, "tr.login.login_fail"))),
                            );
                          }
                        } catch (e) {
                          // print(e);
                        }
                      }
                    },
                    child: Text(
                      FlutterI18n.translate(context, "tr.login.login_button"),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Şifremi unuttum'),
          content: Container(
            width: 500,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                labelText: 'E-posta',
                hintText: 'ornek@eposta.com',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen Email Adresi giriniz.';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            Center(
              child: Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Gönder',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
