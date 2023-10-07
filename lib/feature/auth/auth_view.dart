import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:riverpod_project/feature/auth/auth_provider.dart';
import 'package:riverpod_project/feature/home/home_view.dart';
import 'package:riverpod_project/product/constant/string_constant.dart';
import 'package:riverpod_project/product/widget/text/sub_title_text.dart';
import 'package:riverpod_project/product/widget/text/title_text.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final authProvider =
      StateNotifierProvider<AuthenticationProvider, AuthenticationState>((ref) {
    return AuthenticationProvider();
  });

  @override
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUserDetail(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebase.FirebaseUIActions(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (state.user != null) checkUser(state.user);
          }),
        ],
        child: SafeArea(
          child: Padding(
            padding: context.padding.low,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _Header(),
                  Padding(
                    padding: context.padding.onlyTopNormal,
                    child: firebase.LoginView(
                      showTitle: false,
                      action: firebase.AuthAction.signIn,
                      providers: firebase.FirebaseUIAuth.providersFor(
                        FirebaseAuth.instance.app,
                      ),
                    ),
                  ),
                  if (ref.watch(authProvider).isRedirect)
                    TextButton(
                      onPressed: () {
                        context.route.navigateToPage(const HomeView());
                      },
                      child: Text(
                        StringConstant.continueToApp,
                        textAlign: TextAlign.center,
                        style: context.general.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText(title: StringConstant.loginWelcomeBack),
        Padding(
          padding: context.padding.onlyTopLow,
          child:
              const SubTitleText(subTitle: StringConstant.loginWelcomeDetail),
        ),
      ],
    );
  }
}
