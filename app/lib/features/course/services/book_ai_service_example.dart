import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'book_ai_service.dart';

/// BookAiService 使用示例
class BookAiServiceExample extends StatefulWidget {
  const BookAiServiceExample({super.key});

  @override
  State<BookAiServiceExample> createState() => _BookAiServiceExampleState();
}

class _BookAiServiceExampleState extends State<BookAiServiceExample> {
  final BookAiService _bookAiService = BookAiService();
  bool _isLoading = false;
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI 书籍服务示例'),
        actions: [
          IconButton(
            onPressed: _clearCache,
            icon: Icon(PhosphorIcons.broom()),
            tooltip: '清除缓存',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 示例按钮
            ElevatedButton(
              onPressed: _getSummaryExample,
              child: const Text('获取章节总结'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _generateSummaryExample,
              child: const Text('生成章节总结'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _getKnowledgePointsExample,
              child: const Text('获取知识点'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _generateQuizExample,
              child: const Text('生成测试题'),
            ),
            const SizedBox(height: 16),
            // 加载指示器
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else
              // 结果显示
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(_result.isEmpty ? '点击上方按钮测试功能' : _result),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 获取章节总结示例
  Future<void> _getSummaryExample() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      // 使用缓存获取总结
      final summary = await _bookAiService.getSummary(
        1, // bookId
        1, // chapterId
        type: 'DETAILED',
        forceRefresh: false, // 使用缓存
      );

      setState(() {
        _result = summary?.content ?? '暂无总结内容';
      });
    } catch (e) {
      setState(() {
        _result = '获取总结失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 生成章节总结示例
  Future<void> _generateSummaryExample() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      // 强制生成新总结
      final summary = await _bookAiService.generateSummary(
        1, // bookId
        1, // chapterId
        type: 'BRIEF',
      );

      setState(() {
        _result = summary.content ?? '生成成功但内容为空';
      });
    } catch (e) {
      setState(() {
        _result = '生成总结失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 获取知识点示例
  Future<void> _getKnowledgePointsExample() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      // 获取知识点（优先使用缓存）
      final knowledgePoints = await _bookAiService.getOrExtractKnowledgePoints(
        1, // bookId
        1, // chapterId
      );

      if (knowledgePoints.isNotEmpty) {
        final pointsText = knowledgePoints
            .map((kp) => '• ${kp.name}: ${kp.description ?? ''}')
            .join('\n');
        setState(() {
          _result = '知识点列表:\n$pointsText';
        });
      } else {
        setState(() {
          _result = '暂无知识点';
        });
      }
    } catch (e) {
      setState(() {
        _result = '获取知识点失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 生成测试题示例
  Future<void> _generateQuizExample() async {
    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      // 生成测试题
      final quiz = await _bookAiService.generateQuiz(
        1, // bookId
        1, // chapterId
        questionCount: 3,
      );

      if (quiz.questions != null && quiz.questions!.isNotEmpty) {
        final questionsText = quiz.questions!
            .asMap()
            .entries
            .map((entry) => 
                '题目 ${entry.key + 1}: ${entry.value.question}\n'
                '选项: ${entry.value.options?.join(', ') ?? '无选项'}\n')
            .join('\n');
        
        setState(() {
          _result = '测试题目:\n$questionsText';
        });
      } else {
        setState(() {
          _result = '生成测试失败，题目为空';
        });
      }
    } catch (e) {
      setState(() {
        _result = '生成测试失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 清除缓存
  Future<void> _clearCache() async {
    try {
      await _bookAiService.clearBookCache(1); // 清除书籍ID为1的缓存
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('缓存已清除')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('清除缓存失败: $e')),
      );
    }
  }

  @override
  void dispose() {
    // 取消所有进行中的请求
    _bookAiService.cancelAllRequests();
    super.dispose();
  }
}
