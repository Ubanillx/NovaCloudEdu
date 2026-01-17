#!/bin/bash

echo "======================================"
echo "电子阅览系统测试套件"
echo "======================================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 测试计数
TOTAL=0
PASSED=0
FAILED=0

# 运行单个测试
run_test() {
    TEST_NAME=$1
    DISPLAY_NAME=$2
    
    echo -e "${YELLOW}运行测试: ${DISPLAY_NAME}${NC}"
    TOTAL=$((TOTAL + 1))
    
    ./mvnw test -Dtest=${TEST_NAME} -q
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ ${DISPLAY_NAME} 通过${NC}"
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}✗ ${DISPLAY_NAME} 失败${NC}"
        FAILED=$((FAILED + 1))
    fi
    echo ""
}

# 运行所有测试
echo "开始运行测试..."
echo ""

run_test "BookEntityTest" "书籍实体测试"
run_test "UserBookShelfEntityTest" "用户书架实体测试"
run_test "TxtBookParserTest" "TXT文档解析器测试"
run_test "EpubBookParserTest" "EPUB文档解析器测试"
run_test "WordBookParserTest" "Word文档解析器测试"
run_test "PdfBookParserTest" "PDF文档解析器测试"
run_test "BookApplicationServiceTest" "书籍应用服务测试"
run_test "ReadingProgressApplicationServiceTest" "阅读进度应用服务测试"
run_test "BookParserPerformanceTest" "文档解析性能测试"
run_test "ConcurrentReadingTest" "并发阅读测试"
run_test "ReadingNoteTest" "阅读笔记测试"
run_test "ReadingBookmarkTest" "阅读书签测试"
run_test "ChapterVectorTest" "章节向量测试"
run_test "BookSearchServiceTest" "书籍搜索服务测试"
run_test "VectorEmbeddingServiceTest" "向量嵌入服务测试"

# 输出测试总结
echo "======================================"
echo "测试总结"
echo "======================================"
echo -e "总计: ${TOTAL}"
echo -e "${GREEN}通过: ${PASSED}${NC}"
echo -e "${RED}失败: ${FAILED}${NC}"
echo ""

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}所有测试通过! 🎉${NC}"
    exit 0
else
    echo -e "${RED}部分测试失败，请检查错误信息${NC}"
    exit 1
fi
