import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaCloudEdu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const ComponentShowcase(),
    );
  }
}

class ComponentShowcase extends StatefulWidget {
  const ComponentShowcase({super.key});

  @override
  State<ComponentShowcase> createState() => _ComponentShowcaseState();
}

class _ComponentShowcaseState extends State<ComponentShowcase> {
  bool _isLoading = false;
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TDNavBar(title: '组件展示', screenAdaptation: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('按钮组件', [
            PrimaryButton(
              text: '主要按钮',
              onTap: () => AppToast.success(context, '点击了主要按钮'),
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              text: '次要按钮',
              onTap: () => AppToast.show(context, '点击了次要按钮'),
            ),
            const SizedBox(height: 12),
            DangerButton(
              text: '危险按钮',
              onTap: () => AppToast.warning(context, '这是危险操作'),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              text: _isLoading ? '加载中...' : '加载状态按钮',
              isLoading: _isLoading,
              onTap: () async {
                setState(() => _isLoading = true);
                await Future.delayed(const Duration(seconds: 2));
                setState(() => _isLoading = false);
              },
            ),
          ]),
          _buildSection('输入组件', [
            AppInput(
              label: '用户名',
              placeholder: '请输入用户名',
              controller: _inputController,
            ),
            const SizedBox(height: 12),
            const SearchInput(placeholder: '搜索课程'),
          ]),
          _buildSection('对话框', [
            PrimaryButton(
              text: '确认对话框',
              onTap: () async {
                final result = await showConfirmDialog(
                  context,
                  title: '确认操作',
                  content: '您确定要执行此操作吗？',
                );
                if (result == true && context.mounted) {
                  AppToast.success(context, '已确认');
                }
              },
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              text: '提示对话框',
              onTap: () =>
                  showAppAlertDialog(context, title: '提示', content: '这是一条提示信息'),
            ),
          ]),
          _buildSection('卡片组件', [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TDText('课程卡片', font: TDTheme.of(context).fontTitleLarge),
                  const SizedBox(height: 8),
                  TDText(
                    '这是一个使用 TDesign 风格的卡片组件',
                    textColor: TDTheme.of(context).fontGyColor2,
                  ),
                ],
              ),
              onTap: () => AppToast.show(context, '点击了卡片'),
            ),
            ListItemCard(
              title: '列表项',
              subtitle: '带箭头的列表项',
              leftIcon: TDIcons.user,
              onTap: () => AppToast.show(context, '点击了列表项'),
            ),
          ]),
          _buildSection('加载组件', [
            const SizedBox(height: 80, child: LoadingWidget(message: '加载中...')),
          ]),
          _buildSection('空状态', [
            const SizedBox(height: 200, child: EmptyWidget(message: '暂无课程数据')),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TDText(
            title,
            font: TDTheme.of(context).fontTitleLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...children,
        const SizedBox(height: 8),
        const TDDivider(),
      ],
    );
  }
}
