import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/buyer_invoices_view_model.dart';
import '../../../view_model/current_user_view_model.dart';
import '../../../view_model/login_view_model.dart';
import '../../../view_model/order_list_view_model.dart';
import '../../../view_model/proposal_view_model.dart';
import '../../../view_model/shipment_view_model.dart';

class loginCard extends ConsumerWidget {
  loginCard({Key? key}) : super(key: key);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double screenWidth =
    //     MediaQuery.of(context).size.width; //for loginCard width
    // double screenHeight =
    //     MediaQuery.of(context).size.height; //for loginCard height

    return SingleChildScrollView(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        elevation: 4,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 300,
            minWidth: 400,
          ),
          width: 500,
          height: 380,
          child: Form(
            key: _formKey,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    // height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 25.0),
                          child: Text(
                            FlutterI18n.translate(context, "tr.login.log_in"),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.shadow,
                                ),
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.only(right: 25.0),
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.close,
                            size: 35,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.8),
                        labelText: FlutterI18n.translate(context, "tr.login.e-mail"),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        floatingLabelStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        errorStyle:
                            Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
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
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: TextFormField(
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.8),
                        labelText: FlutterI18n.translate(context, "tr.login.password"),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
                        ),
                        floatingLabelStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
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
                              ref.refresh(getCurrentUserInfoProvider);
                              ref.refresh(getInvoicesProvider);
                              ref.refresh(proposalListview);
                              ref.refresh(getOrderListProvider);
                              ref.refresh(shipmentProvider);
                              await ref.read(getCurrentUserInfoProvider);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(FlutterI18n.translate(
                                      context, "tr.login.login_success")),
                                ),
                              );
                              Navigator.pushNamed(context, '/proposalScreen');
                            } else if (loginState == LoginState.failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(FlutterI18n.translate(
                                      context, "tr.login.login_fail")),
                                ),
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
                InkWell(
                  onTap: () => _dialogBuilder(context),
                  child: Text(
                    FlutterI18n.translate(context, "tr.login.forget_password"),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await ref.read(loginViewModelProvider.notifier).login(
                              email: _emailController.text,
                              password: _passwordController.text);
                          final loginState = ref.read(loginViewModelProvider);

                          if (loginState == LoginState.success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(FlutterI18n.translate(
                                      context, "tr.login.login_success"))),
                            );
                            ref.refresh(getCurrentUserInfoProvider);
                            ref.refresh(getInvoicesProvider);
                            ref.refresh(proposalListview);
                            ref.refresh(getOrderListProvider);
                            ref.refresh(shipmentProvider);
                            await ref.read(getCurrentUserInfoProvider);
                            await Navigator.pushNamed(
                                context, '/proposalScreen');
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
                const SizedBox(
                  height: 20,
                )
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
          title: Text(FlutterI18n.translate(context, "tr.login.new_password")),
          content: SizedBox(
            width: 500,
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: FlutterI18n.translate(context, "tr.login.e-mail"),
                hintText:
                    FlutterI18n.translate(context, "tr.login.hint_text_email"),
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
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {},
                  child: Text(
                    FlutterI18n.translate(context, "tr.login.send"),
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
