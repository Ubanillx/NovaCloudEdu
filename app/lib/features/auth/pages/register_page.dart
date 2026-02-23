import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/auth_service.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../config/app_theme.dart';
import '../widgets/auth_ui_components.dart';

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

  final _accountFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _codeFocusNode = FocusNode();

  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _isSendingCode = false;

  Timer? _codeTimer;
  int _codeCountdown = 0;

  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();

    _accountFocusNode.dispose();
    _passwordFocusNode.dispose();
    _phoneFocusNode.dispose();
    _codeFocusNode.dispose();

    _codeTimer?.cancel();
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
        NovaMessage.success(context, '注册成功，请登录');
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '注册失败: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendVerifyCode() async {
    if (_codeCountdown > 0) return;
    if (_isSendingCode) return;
    
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      NovaMessage.warning(context, '请输入手机号');
      return;
    }
    if (phone.length < 7) {
      NovaMessage.warning(context, '手机号格式不正确');
      return;
    }

    setState(() => _isSendingCode = true);
    try {
      await _authService.sendVerifyCode(phone);
      if (mounted) {
        NovaMessage.success(context, '验证码已发送');
        _startCodeCountdown();
        _codeFocusNode.requestFocus();
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '发送失败: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isSendingCode = false);
    }
  }

  void _startCodeCountdown() {
    _codeTimer?.cancel();
    setState(() => _codeCountdown = 60);
    _codeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_codeCountdown <= 1) {
        timer.cancel();
        setState(() => _codeCountdown = 0);
      } else {
        setState(() => _codeCountdown -= 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDarkMode;
    const brand = AppTheme.brand;
    const brand2 = AppTheme.brand2;

    return Scaffold(
      backgroundColor: colors.background,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: colors.background),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: AuthBgPainter(
                primary: brand.withOpacity(isDark ? 0.03 : 0.012),
                secondary: brand2.withOpacity(isDark ? 0.025 : 0.01),
              ),
            ),
          ),
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Back button overlay
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 24),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                SvgPicture.asset(
                                  'lib/assests/logo/logo.svg',
                                  width: 84,
                                  height: 84,
                                ),
                                const SizedBox(height: 18),
                                Text(
                                  '注册账号',
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            AuthCard(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    AuthTextField(
                                      controller: _accountController,
                                      focusNode: _accountFocusNode,
                                      hintText: '设置账号',
                                      keyboardType: TextInputType.text,
                                      prefixIcon: Icons.person_outline_rounded,
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) => _passwordFocusNode.requestFocus(),
                                      validator: (v) {
                                        final value = (v ?? '').trim();
                                        if (value.isEmpty) return '请输入账号';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    AuthTextField(
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      hintText: '设置密码',
                                      keyboardType: TextInputType.visiblePassword,
                                      prefixIcon: Icons.lock_outline_rounded,
                                      obscureText: !_passwordVisible,
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) => _phoneFocusNode.requestFocus(),
                                      suffix: GestureDetector(
                                        onTap: () => setState(() => _passwordVisible = !_passwordVisible),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                                          child: Icon(
                                            _passwordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                            size: 20,
                                            color: Colors.white.withOpacity(0.75),
                                          ),
                                        ),
                                      ),
                                      validator: (v) {
                                        final value = (v ?? '');
                                        if (value.isEmpty) return '请输入密码';
                                        if (value.length < 6) return '密码至少 6 位';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    AuthTextField(
                                      controller: _phoneController,
                                      focusNode: _phoneFocusNode,
                                      hintText: '手机号',
                                      keyboardType: TextInputType.phone,
                                      prefixIcon: Icons.phone_iphone_rounded,
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) => _codeFocusNode.requestFocus(),
                                      validator: (v) {
                                        final value = (v ?? '').trim();
                                        if (value.isEmpty) return '请输入手机号';
                                        if (value.length < 7) return '手机号格式不正确';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AuthTextField(
                                            controller: _codeController,
                                            focusNode: _codeFocusNode,
                                            hintText: '验证码',
                                            keyboardType: TextInputType.number,
                                            prefixIcon: Icons.verified_user_outlined,
                                            textInputAction: TextInputAction.done,
                                            onSubmitted: (_) => _handleRegister(),
                                            validator: (v) {
                                              final value = (v ?? '').trim();
                                              if (value.isEmpty) return '请输入验证码';
                                              if (value.length < 4) return '验证码格式不正确';
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        AuthSecondaryButton(
                                          text: _codeCountdown > 0 ? '${_codeCountdown}s' : (_isSendingCode ? '发送中...' : '发送验证码'),
                                          onTap: (_codeCountdown > 0 || _isLoading || _isSendingCode) ? null : _sendVerifyCode,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    AuthPrimaryButton(
                                      text: '注 册',
                                      isLoading: _isLoading,
                                      onTap: _handleRegister,
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [brand, brand2],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '已有账号？',
                            style: TextStyle(
                              color: colors.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              ' 立即登录',
                              style: TextStyle(
                                color: brand,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
