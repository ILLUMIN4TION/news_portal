import 'package:easy_extension/easy_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:news_portal/api/auth_api.dart';
import 'package:news_portal/app/router/app_router.dart';
import 'package:news_portal/app/translations/app_trans.dart';
import 'package:news_portal/presentation/widgets/app_logo.dart';
import 'package:news_portal/presentation/widgets/app_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    //미리 선언
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  TextField _textField({
    required TextEditingController controller,
    required String hintText,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }

  //NOTE: 로그인
  void _onLogin() async {
    //TODO: 이메일, 패스워드 가져오기
    final email = _emailController.text;
    final password = _passwordController.text;
    debugPrint('이메일: $email');
    debugPrint('비밀번호: $password');

    //TODO: 토근 발행 API

    final auth = await AuthApi.login(email: email, password: password);

    //auth != null, mounted 일때만 다음 펭지로 이동함함
    if (auth == null) return;
    if (!mounted) return;

    context.goNamed(AppRoute.newsList.name);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppLogo(),

              //region Welcome타이틀틀
              Container(
                height: 250,
                alignment: Alignment.center,
                child: Text(
                  AppTrans.login.welcome.tr(),
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
              ),

              //endRegion Welcome 타이틀

              //region 이메일 입력 시작작
              _textField(
                controller: _emailController,
                hintText: AppTrans.login.email.tr(),
              ),

              //region 이메일 입력 종료
              20.heightBox,

              //region 패스워드 입력 시작작
              _textField(
                controller: _passwordController,
                hintText: AppTrans.login.password.tr(),
                obscure: true,
              ),
              20.heightBox,

              //region 시작 버튼튼
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _onLogin,
                  child: Text(AppTrans.login.login.tr()),
                ),
              ),
              //region end 버튼튼
              Container(
                height: 70,
                alignment: Alignment.center,
                child: Row(
                  spacing: 10,
                  children: [
                    Expanded(child: Divider()),
                    Text(AppTrans.login.orUse.tr()),
                    Expanded(child: Divider()),
                  ],
                ),
              ),

              //region 구글로 로그인 버튼
              _buildSsoButton('Google'),

              10.heightBox,

              _buildSsoButton('Apple'),
              //end region 구글로 로그인 버튼튼
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton _buildSsoButton(String sso) {
    final loginUri = {
      "Google":
          'https://api.apidog.com/api/v1/projects/866715/resources/354903/image-preview',
      "Apple":
          'https://api.apidog.com/api/v1/projects/866715/resources/354902/image-preview',
    };
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        children: [
          Image.network(
            loginUri[sso] ?? '',
            errorBuilder: (context, error, stackTrace) {
              return Icon(LucideIcons.x);
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                AppTrans.login.signInWith.tr(namedArgs: {'sso': sso}),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
