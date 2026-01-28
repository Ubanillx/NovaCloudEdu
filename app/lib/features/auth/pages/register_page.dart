import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../../../widgets/buttons/primary_button.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await _authService.register(
        account: _accountController.text,
        password: _passwordController.text,
        phone: _phoneController.text,
        code: _codeController.text,
      );
      if (mounted) {
        TDToast.showSuccess('注册成功，请登录', context: context);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        TDToast.showFail('注册失败: ${e.toString()}', context: context);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendVerifyCode() async {
    if (_phoneController.text.isEmpty) {
      TDToast.showWarning('请输入手机号', context: context);
      return;
    }
    try {
      await _authService.sendVerifyCode(_phoneController.text);
      if (mounted) {
        TDToast.showSuccess('验证码已发送', context: context);
      }
    } catch (e) {
      if (mounted) {
        TDToast.showFail('发送失败: ${e.toString()}', context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  '注册账号',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                
                TDInput(
                  controller: _accountController,
                  leftIcon: const Icon(Icons.person_outline),
                  hintText: '设置账号',
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 16),
                
                TDInput(
                  controller: _passwordController,
                  leftIcon: const Icon(Icons.lock_outline),
                  hintText: '设置密码',
                  obscureText: true,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 16),
                
                TDInput(
                  controller: _phoneController,
                  leftIcon: const Icon(Icons.phone_android),
                  hintText: '手机号',
                  inputType: TextInputType.phone,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: TDInput(
                        controller: _codeController,
                        leftIcon: const Icon(Icons.verified_user_outlined),
                        hintText: '验证码',
                        inputType: TextInputType.number,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    TDButton(
                      text: '发送验证码',
                      size: TDButtonSize.medium,
                      type: TDButtonType.outline,
                      onTap: _sendVerifyCode,
                    ),
                  ],
                ),
                
                const SizedBox(height: 48),
                
                PrimaryButton(
                  text: '立即注册',
                  isLoading: _isLoading,
                  onTap: _handleRegister,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
