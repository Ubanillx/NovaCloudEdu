import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nova_api/nova_api.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_theme.dart';
import '../../../widgets/toast/nova_message.dart';
import '../../../widgets/common/loading_widget.dart';
import '../../auth/services/auth_service.dart';
import 'phone_edit_page.dart';

/// 个人资料详情页面
class ProfileDetailPage extends StatefulWidget {
  const ProfileDetailPage({super.key});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final AuthService _authService = AuthService();
  UserDetailResponse? _userDetail;
  bool _isLoading = true;
  bool _isEditing = false;
  bool _isSaving = false;
  
  // 编辑控制器
  final _nameController = TextEditingController();
  final _profileController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  
  int? _selectedGender;
  Date? _selectedBirthday;
  String? _newAvatarUrl; // 新上传的头像URL
  bool _isUploadingAvatar = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserDetail();
  }

  Future<void> _loadUserDetail() async {
    try {
      setState(() => _isLoading = true);
      final response = await _authService.getUserDetailInfo();
      if (mounted) {
        setState(() {
          _userDetail = response.data;
          _isLoading = false;
        });
        _initializeEditControllers();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        NovaMessage.error(context, '加载失败: ${e.toString()}');
      }
    }
  }

  void _initializeEditControllers() {
    if (_userDetail != null) {
      _nameController.text = _userDetail!.userName ?? '';
      _profileController.text = _userDetail!.userProfile ?? '';
      _emailController.text = _userDetail!.userEmail ?? '';
      _addressController.text = _userDetail!.userAddress ?? '';
      _selectedGender = _userDetail!.userGender;
      _selectedBirthday = _userDetail!.birthday;
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // 取消编辑时重置数据
        _initializeEditControllers();
        _newAvatarUrl = null; // 清空临时头像URL
      }
    });
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    try {
      final response = await _authService.updateProfile(
        userName: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
        userAvatar: _newAvatarUrl, // 提交新上传的头像URL
        userProfile: _profileController.text.trim().isEmpty ? null : _profileController.text.trim(),
        userEmail: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
        userAddress: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        userGender: _selectedGender,
        birthday: _selectedBirthday,
      );
      
      if (mounted) {
        if (response.data == true) {
          NovaMessage.success(context, '保存成功');
          setState(() {
            _isEditing = false;
            _newAvatarUrl = null; // 清空临时头像URL
          });
          await _loadUserDetail(); // 重新加载数据
        } else {
          NovaMessage.error(context, '保存失败');
        }
      }
    } catch (e) {
      if (mounted) {
        NovaMessage.error(context, '保存失败: ${e.toString()}');
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _profileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('个人资料'),
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (_userDetail != null && !_isLoading)
            _isEditing
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: _toggleEditMode,
                        child: Text(
                          '取消',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      ),
                      TextButton(
                        onPressed: _isSaving ? null : _saveProfile,
                        child: _isSaving
                            ? SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(colors.textPrimary),
                                ),
                              )
                            : const Text(
                                '保存',
                                style: TextStyle(
                                  color: Color(0xFF3B82F6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ],
                  )
                : IconButton(
                    onPressed: _toggleEditMode,
                    icon: Icon(Icons.edit_outlined, color: colors.iconPrimary),
                  ),
        ],
      ),
      body: _isLoading
          ? const LoadingWidget(message: '加载中...')
          : _userDetail == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: colors.textTertiary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '加载失败',
                        style: TextStyle(color: colors.textSecondary),
                      ),
                      TextButton(
                        onPressed: _loadUserDetail,
                        child: const Text('重试'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadUserDetail,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildInfoCard(
                        title: '基本信息',
                        children: [
                          _ProfileItem(
                            label: '账号',
                            value: _userDetail?.userAccount ?? '未设置',
                            isReadOnly: true,
                          ),
                          _ProfileItem(
                            label: '昵称',
                            value: _userDetail?.userName ?? '未设置',
                            controller: _nameController,
                            isEditing: _isEditing,
                            hintText: '请输入昵称',
                          ),
                          _ProfileItem(
                            label: '性别',
                            value: _getGenderText(_userDetail?.userGender),
                            isEditing: _isEditing,
                            customEditor: _buildGenderSelector(),
                          ),
                          _ProfileItem(
                            label: '等级',
                            value: 'Lv.${_userDetail?.level ?? 0}',
                            isReadOnly: true,
                            trailing: _buildLevelBadge(),
                          ),
                          _ProfileItem(
                            label: '角色',
                            value: _getRoleText(_userDetail?.role),
                            isReadOnly: true,
                          ),
                          _ProfileItem(
                            label: '生日',
                            value: _userDetail?.birthday != null 
                                ? _formatDate(_userDetail!.birthday!) 
                                : '未设置',
                            isEditing: _isEditing,
                            onTap: _isEditing ? _showBirthdayPicker : null,
                            showChevron: _isEditing,
                          ),
                          _ProfileItem(
                            label: '简介',
                            value: _userDetail?.userProfile ?? '这个用户很懒，什么都没留下',
                            controller: _profileController,
                            isEditing: _isEditing,
                            hintText: '请输入个人简介',
                            maxLines: 3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: '联系信息',
                        children: [
                          _ProfileItem(
                            label: '手机号',
                            value: _userDetail?.userPhone ?? '未设置',
                            isReadOnly: true,
                            trailing: !_isEditing ? _buildPhoneEditButton() : null,
                          ),
                          _ProfileItem(
                            label: '邮箱',
                            value: _userDetail?.userEmail ?? '未设置',
                            controller: _emailController,
                            isEditing: _isEditing,
                            hintText: '请输入邮箱',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          _ProfileItem(
                            label: '地址',
                            value: _userDetail?.userAddress ?? '未设置',
                            isEditing: _isEditing,
                            onTap: _isEditing ? _showCityPicker : null,
                            showChevron: _isEditing,
                            hintText: '请选择地区',
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        title: '账号状态',
                        children: [
                          _ProfileItem(
                            label: '用户ID',
                            value: _userDetail?.id?.toString() ?? '未知',
                            isReadOnly: true,
                          ),
                          _ProfileItem(
                            label: '状态',
                            value: _userDetail?.banned == true ? '已封禁' : '正常',
                            isReadOnly: true,
                            valueColor: _userDetail?.banned == true ? colors.error : colors.success,
                          ),
                          if (_userDetail?.createTime != null)
                            _ProfileItem(
                              label: '注册时间',
                              value: _formatDateTime(_userDetail!.createTime!),
                              isReadOnly: true,
                            ),
                          if (_userDetail?.updateTime != null)
                            _ProfileItem(
                              label: '最后更新',
                              value: _formatDateTime(_userDetail!.updateTime!),
                              isReadOnly: true,
                            ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeader() {
    final colors = context.colors;
    final avatarUrl = _newAvatarUrl ?? _userDetail?.userAvatar;
    
    return Column(
      children: [
        GestureDetector(
          onTap: _isEditing ? _showAvatarPicker : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isEditing ? const Color(0xFF3B82F6) : colors.border.withOpacity(0.2),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (_isEditing ? const Color(0xFF3B82F6) : Colors.black).withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: _isEditing ? 4 : 0,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Hero(
                  tag: 'user_avatar',
                  child: ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (avatarUrl != null && avatarUrl.isNotEmpty)
                            Image.network(
                              avatarUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildDefaultAvatar(),
                            )
                          else
                            _buildDefaultAvatar(),
                          if (_isEditing || _isUploadingAvatar)
                            Container(
                              color: Colors.black.withOpacity(_isUploadingAvatar ? 0.6 : 0.3),
                              child: Center(
                                child: _isUploadingAvatar
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 3,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      )
                                    : const Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (_isEditing && !_isUploadingAvatar)
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6),
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.surface, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.edit_rounded, color: Colors.white, size: 14),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _userDetail?.userName ?? '未设置',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    final colors = context.colors;
    return Container(
      width: 100,
      height: 100,
      color: colors.border.withOpacity(0.1),
      child: Icon(Icons.person, size: 50, color: colors.iconSecondary),
    );
  }

  Widget _buildLevelBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Lv.${_userDetail?.level ?? 0}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPhoneEditButton() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.of(context).push<bool>(
          MaterialPageRoute(
            builder: (_) => PhoneEditPage(
              currentPhone: _userDetail?.userPhone ?? '',
            ),
          ),
        );
        if (result == true) await _loadUserDetail();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          '修改',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF3B82F6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  // 显示头像选择器
  Future<void> _showAvatarPicker() async {
    final colors = context.colors;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colors.border.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '修改头像',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            _buildPickerOption(
              icon: Icons.camera_alt_rounded,
              title: '拍照',
              subtitle: '使用摄像头拍摄一张照片',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(color: colors.divider.withOpacity(0.5), height: 1),
            ),
            _buildPickerOption(
              icon: Icons.photo_library_rounded,
              title: '从相册选择',
              subtitle: '从手机相册中选取已有照片',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF3B82F6), size: 26),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: colors.iconSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  // 选择并上传图片
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      if (pickedFile == null) return;
      
      setState(() => _isUploadingAvatar = true);
      
      final file = File(pickedFile.path);
      final avatarUrl = await _authService.uploadAvatar(file);
      
      if (mounted) {
        if (avatarUrl != null) {
          setState(() {
            _newAvatarUrl = avatarUrl;
            _isUploadingAvatar = false;
          });
          NovaMessage.success(context, '头像上传成功');
        } else {
          setState(() => _isUploadingAvatar = false);
          NovaMessage.error(context, '头像上传失败');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploadingAvatar = false);
        NovaMessage.error(context, '上传失败: ${e.toString()}');
      }
    }
  }

  Future<void> _showCityPicker() async {
    final result = await CityPickers.showCityPicker(
      context: context,
      showType: ShowType.pca, // 省市区三级联动
      cancelWidget: Text('取消', style: TextStyle(color: context.colors.textSecondary)),
      confirmWidget: const Text('确定', style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
    );
    if (result != null) {
      final address = [
        result.provinceName ?? '',
        result.cityName ?? '',
        result.areaName ?? '',
      ].where((s) => s.isNotEmpty).join(' ');
      setState(() {
        _addressController.text = address;
      });
    }
  }

  Future<void> _showBirthdayPicker() async {
    final initialDate = _selectedBirthday != null 
        ? [_selectedBirthday!.year, _selectedBirthday!.month, _selectedBirthday!.day]
        : [DateTime.now().year - 20, 1, 1];
    
    TDPicker.showDatePicker(
      context,
      title: '选择生日',
      onConfirm: (selected) {
        setState(() {
          _selectedBirthday = Date(
            selected['year']!,
            selected['month']!,
            selected['day']!,
          );
        });
        Navigator.of(context).pop();
      },
      onCancel: (selected) {
        Navigator.of(context).pop();
      },
      dateStart: [1900, 1, 1],
      dateEnd: [DateTime.now().year, DateTime.now().month, DateTime.now().day],
      initialDate: initialDate,
    );
  }

  String _getRoleText(String? role) {
    if (role == 'admin') return '管理员';
    if (role == 'user') return '普通用户';
    return role ?? '未知';
  }

  String _getGenderText(int? gender) {
    if (gender == 0) return '男';
    if (gender == 1) return '女';
    if (gender == 2) return '保密';
    return '未设置';
  }

  String _formatDate(Date date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateTime(DateTime dateTime) {
    final local = dateTime.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')} '
           '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        _buildGenderOption(0, '男'),
        const SizedBox(width: 12),
        _buildGenderOption(1, '女'),
        const SizedBox(width: 12),
        _buildGenderOption(2, '保密'),
      ],
    );
  }

  Widget _buildGenderOption(int value, String label) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : context.colors.border.withOpacity(0.5),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.white : context.colors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

/// 自定义个人资料项组件
class _ProfileItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final bool isReadOnly;
  final TextEditingController? controller;
  final Widget? customEditor;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? valueColor;
  final String? hintText;
  final bool showChevron;
  final int maxLines;
  final TextInputType? keyboardType;

  const _ProfileItem({
    required this.label,
    required this.value,
    this.isEditing = false,
    this.isReadOnly = false,
    this.controller,
    this.customEditor,
    this.onTap,
    this.trailing,
    this.valueColor,
    this.hintText,
    this.showChevron = false,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    
    return InkWell(
      onTap: isEditing ? onTap : null,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: isEditing && !isReadOnly
                      ? (customEditor ?? _buildDefaultEditor(context))
                      : _buildValueText(context),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: 8),
                  trailing!,
                ],
                if (showChevron) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 20, color: colors.iconSecondary),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueText(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 15,
        color: valueColor ?? context.colors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDefaultEditor(BuildContext context) {
    if (onTap != null) {
      return Text(
        value,
        style: TextStyle(
          fontSize: 15,
          color: context.colors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 15,
        color: context.colors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(color: context.colors.textTertiary, fontSize: 14),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
