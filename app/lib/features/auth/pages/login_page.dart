import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/auth_service.dart';
import 'register_page.dart';
import '../../../main.dart'; // 导入 MainPage
import '../../../widgets/toast/nova_message.dart';
import '../../../config/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyAccount = GlobalKey<FormState>();
  final _formKeyPhone = GlobalKey<FormState>();

  // 账号登录控制器
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  // 手机登录控制器
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  final _accountFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _codeFocusNode = FocusNode();

  bool _passwordVisible = false;
  int _loginModeIndex = 0;

  Timer? _codeTimer;
  int _codeCountdown = 0;

  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

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

  void _handleLogin() async {
    if (_loginModeIndex == 0) {
      if (!(_formKeyAccount.currentState?.validate() ?? false)) return;
      _loginWithAccount();
    } else {
      if (!(_formKeyPhone.currentState?.validate() ?? false)) return;
      _loginWithPhone();
    }
  }

  Future<void> _loginWithAccount() async {
    setState(() => _isLoading = true);
    try {
      await _authService.loginWithPassword(
        _accountController.text,
        _passwordController.text,
      );
      if (mounted) {
        NovaMessage.success(context, '登录成功');
        // 登录成功跳转到主页
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainPage()));
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '登录失败: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithPhone() async {
    setState(() => _isLoading = true);
    try {
      await _authService.loginWithPhone(
        _phoneController.text,
        _codeController.text,
      );
      if (mounted) {
        NovaMessage.success(context, '登录成功');
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainPage()));
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '登录失败: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  bool _isSendingCode = false;

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
        // 自动聚焦到验证码输入框
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
    const brand = Color(0xFF2563EB);
    const brand2 = Color(0xFF3B82F6);

    return Scaffold(
      backgroundColor: colors.background,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 1. 背景底层
          Positioned.fill(
            child: Container(color: colors.background),
          ),
          // 2. 极淡的氛围装饰 (不干扰视线)
          Positioned.fill(
            child: CustomPaint(
              painter: _NovaLoginBgPainter(
                primary: brand.withOpacity(isDark ? 0.03 : 0.012),
                secondary: brand2.withOpacity(isDark ? 0.025 : 0.01),
              ),
            ),
          ),
          // 3. 稳固的工业级布局方案
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            // Logo & 品牌
                            Hero(
                              tag: 'app_logo',
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'lib/assests/logo/logo.svg',
                                    width: 84,
                                    height: 84,
                                  ),
                                  const SizedBox(height: 18),
                                  Text(
                                    '智云星课',
                                    style: TextStyle(
                                      color: colors.textPrimary,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '让教育在云端触手可及',
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            // 登录主体
                            _LoginCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _NovaSegmentedControl(
                                    items: const ['账号登录', '手机登录'],
                                    index: _loginModeIndex,
                                    onChanged: (i) {
                                      FocusScope.of(context).unfocus();
                                      setState(() => _loginModeIndex = i);
                                    },
                                    activeGradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [brand, brand2],
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    switchInCurve: Curves.easeOutCubic,
                                    switchOutCurve: Curves.easeInCubic,
                                    transitionBuilder: (child, anim) {
                                      return FadeTransition(
                                        opacity: anim,
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0, 0.02),
                                            end: Offset.zero,
                                          ).animate(anim),
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: _loginModeIndex == 0
                                        ? _buildAccountLogin()
                                        : _buildPhoneLogin(),
                                  ),
                                  const SizedBox(height: 12),
                                  if (_loginModeIndex == 0)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          NovaMessage.show(context, '请联系管理员重置密码');
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: colors.textSecondary,
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          minimumSize: const Size(0, 32),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text('忘记密码？', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                                      ),
                                    ),
                                  const SizedBox(height: 20),
                                  _NovaPrimaryButton(
                                    text: '登 录',
                                    isLoading: _isLoading,
                                    onTap: _handleLogin,
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [brand, brand2],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                    // 底部注册 - 固定在底部
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '还没有账号？',
                            style: TextStyle(
                              color: colors.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 400),
                                  pageBuilder: (context, anim, _) => const RegisterPage(),
                                  transitionsBuilder: (context, anim, _, child) {
                                    return FadeTransition(opacity: anim, child: child);
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              ' 立即注册',
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

  Widget _buildAccountLogin() {
    return Form(
      key: _formKeyAccount,
      child: Column(
        key: const ValueKey('account_login'),
        children: [
          _NovaTextField(
            controller: _accountController,
            focusNode: _accountFocusNode,
            hintText: '账号',
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
          _NovaTextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            hintText: '密码',
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: !_passwordVisible,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _handleLogin(),
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
        ],
      ),
    );
  }

  Widget _buildPhoneLogin() {
    return Form(
      key: _formKeyPhone,
      child: Column(
        key: const ValueKey('phone_login'),
        children: [
          _NovaTextField(
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
                child: _NovaTextField(
                  controller: _codeController,
                  focusNode: _codeFocusNode,
                  hintText: '验证码',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.verified_user_outlined,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleLogin(),
                  validator: (v) {
                    final value = (v ?? '').trim();
                    if (value.isEmpty) return '请输入验证码';
                    if (value.length < 4) return '验证码格式不正确';
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 12),
              _NovaSecondaryButton(
                text: _codeCountdown > 0 ? '${_codeCountdown}s' : (_isSendingCode ? '发送中...' : '发送验证码'),
                onTap: (_codeCountdown > 0 || _isLoading || _isSendingCode) ? null : _sendVerifyCode,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  final Widget child;

  const _LoginCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 44),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(40),
      ),
      child: child,
    );
  }
}

class _NovaPrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final Gradient gradient;

  const _NovaPrimaryButton({
    required this.text,
    required this.onTap,
    required this.isLoading,
    required this.gradient,
  });

  @override
  State<_NovaPrimaryButton> createState() => _NovaPrimaryButtonState();
}

class _NovaPrimaryButtonState extends State<_NovaPrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null || widget.isLoading;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: disabled ? null : widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: disabled
                ? LinearGradient(
                    colors: [
                      const Color(0xFFE2E8F0),
                      const Color(0xFFF1F5F9),
                    ],
                  )
                : widget.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: disabled
                ? []
                : [
                    BoxShadow(
                      color: (widget.gradient.colors.first).withOpacity(0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    letterSpacing: 4,
                  ),
                ),
        ),
      ),
    );
  }
}

class _NovaSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _NovaSecondaryButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: disabled ? colors.surfaceVariant : colors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: disabled ? colors.textTertiary : colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _NovaSegmentedControl extends StatelessWidget {
  final List<String> items;
  final int index;
  final ValueChanged<int> onChanged;
  final Gradient activeGradient;

  const _NovaSegmentedControl({
    required this.items,
    required this.index,
    required this.onChanged,
    required this.activeGradient,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final itemW = w / items.length;
        return Container(
          height: 48,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                left: itemW * index + 2,
                top: 2,
                bottom: 2,
                width: itemW - 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: activeGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (activeGradient.colors.first).withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: List.generate(items.length, (i) {
                  final active = i == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(i),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 160),
                          style: TextStyle(
                            color: active ? Colors.white : colors.textSecondary,
                            fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                          ),
                          child: Text(items[i]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NovaTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;

  const _NovaTextField({
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.keyboardType,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffix,
    this.validator,
    required this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      cursorColor: const Color(0xFF3B5BFF),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(1),
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surfaceVariant.withOpacity(0.5),
        hintText: hintText,
        hintStyle: TextStyle(
          color: colors.textTertiary, 
          fontSize: 15, 
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(prefixIcon, color: colors.iconPrimary, size: 20),
        ),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF3B5BFF), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colors.error.withOpacity(0.3), width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        errorStyle: TextStyle(color: colors.error, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}


class _NovaLoginBgPainter extends CustomPainter {
  final Color primary;
  final Color secondary;

  _NovaLoginBgPainter({required this.primary, required this.secondary});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..color = primary.withOpacity(0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    final p2 = Paint()
      ..color = secondary.withOpacity(0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70);

    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.18), size.width * 0.42, p1);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.28), size.width * 0.46, p2);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.92), size.width * 0.55, p1..color = primary.withOpacity(0.10));
  }

  @override
  bool shouldRepaint(covariant _NovaLoginBgPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary;
  }
}
