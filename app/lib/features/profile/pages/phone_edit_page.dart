import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../auth/services/auth_service.dart';

/// 手机号修改页面
class PhoneEditPage extends StatefulWidget {
  final String currentPhone;
  
  const PhoneEditPage({
    super.key,
    required this.currentPhone,
  });

  @override
  State<PhoneEditPage> createState() => _PhoneEditPageState();
}

class _PhoneEditPageState extends State<PhoneEditPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _codeFocusNode = FocusNode();
  
  bool _isLoading = false;
  bool _isSendingCode = false;
  int _codeCountdown = 0;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.currentPhone;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _phoneFocusNode.dispose();
    _codeFocusNode.dispose();
    super.dispose();
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
    setState(() => _codeCountdown = 60);
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _codeCountdown--);
        return _codeCountdown > 0;
      }
      return false;
    });
  }

  Future<void> _updatePhone() async {
    if (!_formKey.currentState!.validate()) return;
    
    final phone = _phoneController.text.trim();
    final code = _codeController.text.trim();
    
    if (code.isEmpty) {
      NovaMessage.warning(context, '请输入验证码');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await _authService.updatePhone(
        userPhone: phone,
        phoneSmsCode: code,
      );
      
      if (mounted) {
        if (response.data == true) {
          NovaMessage.success(context, '手机号修改成功');
          Navigator.of(context).pop(true); // 返回成功标识
        } else {
          NovaMessage.error(context, '修改失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '修改失败: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('修改手机号'),
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // 当前手机号提示
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: colors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '当前手机号：${widget.currentPhone}',
                      style: TextStyle(
                        fontSize: 14,
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // 新手机号输入
            Text(
              '新手机号',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '请输入新手机号',
                prefixIcon: Icon(Icons.phone_outlined, color: colors.iconSecondary),
                filled: true,
                fillColor: colors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.border.withOpacity(0.2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.border.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colors.info, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '请输入手机号';
                }
                if (value.trim().length < 7) {
                  return '手机号格式不正确';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            
            // 验证码输入
            Text(
              '验证码',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _codeController,
                    focusNode: _codeFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '请输入验证码',
                      prefixIcon: Icon(Icons.sms_outlined, color: colors.iconSecondary),
                      filled: true,
                      fillColor: colors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colors.border.withOpacity(0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colors.border.withOpacity(0.2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colors.info, width: 2),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '请输入验证码';
                      }
                      if (value.trim().length < 4) {
                        return '验证码格式不正确';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_codeCountdown > 0 || _isSendingCode) ? null : _sendVerifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.info,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _codeCountdown > 0 
                          ? '${_codeCountdown}s' 
                          : (_isSendingCode ? '发送中...' : '发送验证码'),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            
            // 确认按钮
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updatePhone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.info,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        '确认修改',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            
            // 提示信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.border.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '温馨提示',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• 验证码将发送到新手机号\n• 请确保新手机号能正常接收短信\n• 修改成功后将使用新手机号登录',
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
