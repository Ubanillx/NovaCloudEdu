package com.novacloudedu.backend.application.service;

import com.novacloudedu.backend.domain.ai.valueobject.ChunkStrategy;
import com.novacloudedu.backend.domain.book.service.VectorEmbeddingService;
import com.novacloudedu.backend.domain.book.valueobject.ChapterVector;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 文档切分服务
 *
 * 支持5种切分策略 + 父子chunk模式
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class DocumentChunkingService {

    private final VectorEmbeddingService embeddingService;

    private static final Pattern TITLE_PATTERN = Pattern.compile(
            "^(#{1,6}\\s+.+|[A-Z\\u4e00-\\u9fa5].{0,80}\\n[=\\-]{2,})$",
            Pattern.MULTILINE);

    private static final Pattern SENTENCE_END_PATTERN = Pattern.compile(
            "[。！？.!?;；]\\s*");

    @Data
    @Builder
    public static class ChunkConfig {
        private ChunkStrategy strategy;
        @Builder.Default private int chunkSize = 500;
        @Builder.Default private int chunkOverlap = 50;
        @Builder.Default private boolean parentChildMode = false;
        @Builder.Default private int parentChunkSize = 1500;
        @Builder.Default private boolean preserveMetadata = true;
        @Builder.Default private double semanticThreshold = 0.5;
    }

    @Data
    @AllArgsConstructor
    public static class ChunkResult {
        private List<ChunkItem> chunks;
        private int totalChunks;
        private ChunkStrategy strategyUsed;
    }

    @Data
    @Builder
    public static class ChunkItem {
        private String content;
        private int index;
        private Integer parentIndex;
        private boolean isParent;
        private String sectionTitle;
        private int charStart;
        private int charEnd;
    }

    /**
     * 执行文档切分
     */
    public ChunkResult split(String content, ChunkConfig config) {
        if (content == null || content.isEmpty()) {
            return new ChunkResult(new ArrayList<>(), 0, config.getStrategy());
        }

        ChunkStrategy strategy = config.getStrategy() != null ? config.getStrategy() : ChunkStrategy.PARAGRAPH;
        log.info("文档切分: strategy={}, chunkSize={}, overlap={}, parentChild={}",
                strategy, config.getChunkSize(), config.getChunkOverlap(), config.isParentChildMode());

        List<ChunkItem> childChunks;
        switch (strategy) {
            case FIXED:
                childChunks = splitFixed(content, config.getChunkSize(), config.getChunkOverlap());
                break;
            case TITLE:
                childChunks = splitByTitle(content, config.getChunkSize(), config.getChunkOverlap());
                break;
            case SENTENCE:
                childChunks = splitBySentence(content, config.getChunkSize(), config.getChunkOverlap());
                break;
            case SEMANTIC:
                childChunks = splitSemantic(content, config);
                break;
            case PARAGRAPH:
            default:
                childChunks = splitParagraph(content, config.getChunkSize(), config.getChunkOverlap());
                break;
        }

        if (config.isParentChildMode()) {
            childChunks = buildParentChildChunks(content, childChunks, config);
        }

        for (int i = 0; i < childChunks.size(); i++) {
            childChunks.get(i).setIndex(i);
        }

        log.info("文档切分完成: totalChunks={}", childChunks.size());
        return new ChunkResult(childChunks, childChunks.size(), strategy);
    }

    // ==================== FIXED 固定大小切分 ====================

    private List<ChunkItem> splitFixed(String content, int chunkSize, int overlap) {
        List<ChunkItem> chunks = new ArrayList<>();
        int len = content.length();
        int start = 0;
        while (start < len) {
            int end = Math.min(start + chunkSize, len);
            String chunk = content.substring(start, end).trim();
            if (!chunk.isEmpty()) {
                chunks.add(ChunkItem.builder().content(chunk).charStart(start).charEnd(end).isParent(false).build());
            }
            int nextStart = end - overlap;
            if (nextStart <= start) nextStart = end;
            if (nextStart >= len) break;
            start = nextStart;
        }
        return chunks;
    }

    // ==================== PARAGRAPH 段落感知切分 ====================

    private List<ChunkItem> splitParagraph(String content, int chunkSize, int overlap) {
        List<ChunkItem> chunks = new ArrayList<>();
        int maxExtend = Math.max(chunkSize / 5, 100);
        int len = content.length();
        int start = 0;

        while (start < len) {
            int baseEnd = Math.min(start + chunkSize, len);
            if (baseEnd >= len) {
                String chunk = content.substring(start).trim();
                if (!chunk.isEmpty()) {
                    chunks.add(ChunkItem.builder().content(chunk).charStart(start).charEnd(len).isParent(false).build());
                }
                break;
            }

            int end = baseEnd;
            int forwardNewline = content.indexOf('\n', baseEnd);
            if (forwardNewline != -1 && forwardNewline <= baseEnd + maxExtend) {
                end = forwardNewline + 1;
            } else {
                int backwardNewline = content.lastIndexOf('\n', baseEnd);
                if (backwardNewline > start) {
                    end = backwardNewline + 1;
                }
            }

            String chunk = content.substring(start, end).trim();
            if (!chunk.isEmpty()) {
                chunks.add(ChunkItem.builder().content(chunk).charStart(start).charEnd(end).isParent(false).build());
            }

            int nextStart = end - overlap;
            if (nextStart <= start) nextStart = end;
            int alignNewline = content.lastIndexOf('\n', nextStart);
            if (alignNewline > start && alignNewline >= nextStart - overlap) {
                nextStart = alignNewline + 1;
            }
            if (nextStart >= len) break;
            start = nextStart;
        }
        return chunks;
    }

    // ==================== TITLE 标题层级切分 ====================

    private List<ChunkItem> splitByTitle(String content, int chunkSize, int overlap) {
        List<ChunkItem> chunks = new ArrayList<>();
        List<int[]> titlePositions = new ArrayList<>();
        Matcher matcher = TITLE_PATTERN.matcher(content);
        while (matcher.find()) {
            titlePositions.add(new int[]{matcher.start(), matcher.end()});
        }

        if (titlePositions.isEmpty()) {
            return splitParagraph(content, chunkSize, overlap);
        }

        String currentTitle = null;
        for (int i = 0; i < titlePositions.size(); i++) {
            int sectionStart = titlePositions.get(i)[0];
            int sectionEnd = (i + 1 < titlePositions.size()) ? titlePositions.get(i + 1)[0] : content.length();
            String titleText = content.substring(titlePositions.get(i)[0], titlePositions.get(i)[1]).trim();
            currentTitle = titleText.replaceAll("^#+\\s*", "");

            String sectionContent = content.substring(sectionStart, sectionEnd).trim();
            if (sectionContent.length() <= chunkSize) {
                if (!sectionContent.isEmpty()) {
                    chunks.add(ChunkItem.builder()
                            .content(sectionContent)
                            .charStart(sectionStart).charEnd(sectionEnd)
                            .sectionTitle(currentTitle)
                            .isParent(false).build());
                }
            } else {
                List<ChunkItem> subChunks = splitParagraph(sectionContent, chunkSize, overlap);
                for (ChunkItem sub : subChunks) {
                    sub.setSectionTitle(currentTitle);
                    sub.setCharStart(sectionStart + sub.getCharStart());
                    sub.setCharEnd(sectionStart + sub.getCharEnd());
                }
                chunks.addAll(subChunks);
            }
        }

        // 处理第一个标题之前的内容
        if (!titlePositions.isEmpty() && titlePositions.get(0)[0] > 0) {
            String preamble = content.substring(0, titlePositions.get(0)[0]).trim();
            if (!preamble.isEmpty()) {
                List<ChunkItem> preChunks = splitParagraph(preamble, chunkSize, overlap);
                chunks.addAll(0, preChunks);
            }
        }

        return chunks;
    }

    // ==================== SENTENCE 句法边界切分 ====================

    private List<ChunkItem> splitBySentence(String content, int chunkSize, int overlap) {
        List<ChunkItem> chunks = new ArrayList<>();
        List<String> sentences = new ArrayList<>();
        List<Integer> sentenceStarts = new ArrayList<>();

        Matcher matcher = SENTENCE_END_PATTERN.matcher(content);
        int lastEnd = 0;
        while (matcher.find()) {
            String sentence = content.substring(lastEnd, matcher.end()).trim();
            if (!sentence.isEmpty()) {
                sentences.add(sentence);
                sentenceStarts.add(lastEnd);
            }
            lastEnd = matcher.end();
        }
        if (lastEnd < content.length()) {
            String remaining = content.substring(lastEnd).trim();
            if (!remaining.isEmpty()) {
                sentences.add(remaining);
                sentenceStarts.add(lastEnd);
            }
        }

        if (sentences.isEmpty()) {
            return splitFixed(content, chunkSize, overlap);
        }

        StringBuilder buffer = new StringBuilder();
        int bufferStart = 0;
        int sentIdx = 0;

        for (int i = 0; i < sentences.size(); i++) {
            String sentence = sentences.get(i);
            if (buffer.isEmpty()) {
                bufferStart = sentenceStarts.get(i);
            }

            if (buffer.length() + sentence.length() + 1 > chunkSize && !buffer.isEmpty()) {
                chunks.add(ChunkItem.builder()
                        .content(buffer.toString().trim())
                        .charStart(bufferStart)
                        .charEnd(sentenceStarts.get(i))
                        .isParent(false).build());

                // 回退 overlap 个字符对应的句子
                buffer = new StringBuilder();
                int overlapChars = 0;
                int backIdx = i - 1;
                while (backIdx >= sentIdx && overlapChars < overlap) {
                    overlapChars += sentences.get(backIdx).length();
                    backIdx--;
                }
                backIdx = Math.max(backIdx + 1, sentIdx);
                sentIdx = i;
                for (int j = backIdx; j < i; j++) {
                    buffer.append(sentences.get(j)).append(" ");
                }
                bufferStart = sentenceStarts.get(backIdx < sentences.size() ? backIdx : i);
            }
            buffer.append(sentence).append(" ");
        }

        if (!buffer.isEmpty()) {
            chunks.add(ChunkItem.builder()
                    .content(buffer.toString().trim())
                    .charStart(bufferStart)
                    .charEnd(content.length())
                    .isParent(false).build());
        }

        return chunks;
    }

    // ==================== SEMANTIC 语义切分（推荐） ====================

    /**
     * 语义切分：先按标题+段落做初步切分，再用 embedding 相似度合并/拆分
     */
    private List<ChunkItem> splitSemantic(String content, ChunkConfig config) {
        // 第一步：按段落切成细粒度段落
        List<String> paragraphs = new ArrayList<>();
        List<Integer> paraStarts = new ArrayList<>();
        String[] lines = content.split("\n");
        StringBuilder paraBuffer = new StringBuilder();
        int charPos = 0;
        int paraStart = 0;

        for (String line : lines) {
            if (line.trim().isEmpty()) {
                if (!paraBuffer.isEmpty()) {
                    paragraphs.add(paraBuffer.toString().trim());
                    paraStarts.add(paraStart);
                    paraBuffer = new StringBuilder();
                }
                charPos += line.length() + 1;
                paraStart = charPos;
                continue;
            }
            if (paraBuffer.isEmpty()) {
                paraStart = charPos;
            }
            paraBuffer.append(line).append("\n");
            charPos += line.length() + 1;
        }
        if (!paraBuffer.isEmpty()) {
            paragraphs.add(paraBuffer.toString().trim());
            paraStarts.add(paraStart);
        }

        if (paragraphs.size() <= 1) {
            return splitParagraph(content, config.getChunkSize(), config.getChunkOverlap());
        }

        // 第二步：计算相邻段落的 embedding 相似度
        float[][] embeddings;
        try {
            String[] paraArray = paragraphs.toArray(new String[0]);
            ChapterVector[] vectors = embeddingService.embedTexts(paraArray);
            embeddings = new float[vectors.length][];
            for (int i = 0; i < vectors.length; i++) {
                embeddings[i] = vectors[i].getEmbedding();
            }
        } catch (Exception e) {
            log.warn("语义切分embedding失败，降级为段落切分: {}", e.getMessage());
            return splitParagraph(content, config.getChunkSize(), config.getChunkOverlap());
        }

        // 第三步：基于相似度和大小约束合并段落
        double threshold = config.getSemanticThreshold();
        List<ChunkItem> chunks = new ArrayList<>();
        StringBuilder currentChunk = new StringBuilder();
        int currentStart = paraStarts.get(0);

        for (int i = 0; i < paragraphs.size(); i++) {
            String para = paragraphs.get(i);

            if (currentChunk.isEmpty()) {
                currentChunk.append(para);
                currentStart = paraStarts.get(i);
                continue;
            }

            boolean shouldSplit = false;

            // 大小超限 → 必须切
            if (currentChunk.length() + para.length() + 1 > config.getChunkSize()) {
                shouldSplit = true;
            }

            // 相似度低于阈值 → 语义断点
            if (!shouldSplit && i < embeddings.length && i - 1 >= 0) {
                double sim = cosineSimilarity(embeddings[i - 1], embeddings[i]);
                if (sim < threshold) {
                    shouldSplit = true;
                }
            }

            // 检测到标题行 → 强制切
            if (!shouldSplit && TITLE_PATTERN.matcher(para.split("\n")[0]).matches()) {
                shouldSplit = true;
            }

            if (shouldSplit) {
                String chunkText = currentChunk.toString().trim();
                if (!chunkText.isEmpty()) {
                    int chunkEnd = paraStarts.get(i);
                    chunks.add(ChunkItem.builder()
                            .content(chunkText)
                            .charStart(currentStart).charEnd(chunkEnd)
                            .isParent(false).build());
                }
                currentChunk = new StringBuilder(para);
                currentStart = paraStarts.get(i);
            } else {
                currentChunk.append("\n\n").append(para);
            }
        }

        if (!currentChunk.isEmpty()) {
            String chunkText = currentChunk.toString().trim();
            if (!chunkText.isEmpty()) {
                chunks.add(ChunkItem.builder()
                        .content(chunkText)
                        .charStart(currentStart).charEnd(content.length())
                        .isParent(false).build());
            }
        }

        // 对超大chunk二次拆分
        List<ChunkItem> finalChunks = new ArrayList<>();
        for (ChunkItem chunk : chunks) {
            if (chunk.getContent().length() > config.getChunkSize() * 1.5) {
                List<ChunkItem> subChunks = splitParagraph(
                        chunk.getContent(), config.getChunkSize(), config.getChunkOverlap());
                for (ChunkItem sub : subChunks) {
                    sub.setCharStart(chunk.getCharStart() + sub.getCharStart());
                    sub.setCharEnd(chunk.getCharStart() + sub.getCharEnd());
                    sub.setSectionTitle(chunk.getSectionTitle());
                }
                finalChunks.addAll(subChunks);
            } else {
                finalChunks.add(chunk);
            }
        }

        return finalChunks;
    }

    // ==================== 父子 Chunk 模式 ====================

    /**
     * 为子chunk生成对应的父chunk（更大的上下文窗口）
     */
    private List<ChunkItem> buildParentChildChunks(String content, List<ChunkItem> childChunks, ChunkConfig config) {
        int parentSize = config.getParentChunkSize();
        List<ChunkItem> result = new ArrayList<>();

        // 先生成父chunk
        List<ChunkItem> parentChunks = splitParagraph(content, parentSize, parentSize / 5);
        for (int i = 0; i < parentChunks.size(); i++) {
            ChunkItem parent = parentChunks.get(i);
            parent.setParent(true);
            parent.setIndex(i);
            result.add(parent);
        }

        int parentOffset = parentChunks.size();

        // 为每个子chunk找到对应的父chunk
        for (ChunkItem child : childChunks) {
            child.setParent(false);
            int bestParent = -1;
            int bestOverlap = 0;
            for (int p = 0; p < parentChunks.size(); p++) {
                ChunkItem parent = parentChunks.get(p);
                int overlapStart = Math.max(child.getCharStart(), parent.getCharStart());
                int overlapEnd = Math.min(child.getCharEnd(), parent.getCharEnd());
                int overlap = Math.max(0, overlapEnd - overlapStart);
                if (overlap > bestOverlap) {
                    bestOverlap = overlap;
                    bestParent = p;
                }
            }
            child.setParentIndex(bestParent >= 0 ? bestParent : null);
            child.setIndex(parentOffset++);
            result.add(child);
        }

        return result;
    }

    // ==================== 工具方法 ====================

    private double cosineSimilarity(float[] a, float[] b) {
        if (a == null || b == null || a.length != b.length) return 0.0;
        double dotProduct = 0.0, normA = 0.0, normB = 0.0;
        for (int i = 0; i < a.length; i++) {
            dotProduct += a[i] * b[i];
            normA += a[i] * a[i];
            normB += b[i] * b[i];
        }
        double denominator = Math.sqrt(normA) * Math.sqrt(normB);
        return denominator == 0 ? 0.0 : dotProduct / denominator;
    }
}
