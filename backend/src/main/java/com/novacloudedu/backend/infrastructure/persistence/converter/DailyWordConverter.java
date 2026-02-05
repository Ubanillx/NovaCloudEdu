package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.dailylearning.entity.DailyWord;
import com.novacloudedu.backend.domain.dailylearning.valueobject.DailyWordId;
import com.novacloudedu.backend.domain.dailylearning.valueobject.Difficulty;
import com.novacloudedu.backend.domain.user.valueobject.UserId;
import com.novacloudedu.backend.infrastructure.persistence.po.DailyWordPO;
import org.springframework.stereotype.Component;

@Component
public class DailyWordConverter {

    public DailyWordPO toPO(DailyWord dailyWord) {
        DailyWordPO po = new DailyWordPO();
        if (dailyWord.getId() != null) {
            po.setId(dailyWord.getId().value());
        }
        po.setWord(dailyWord.getWord());
        po.setPronunciationUs(dailyWord.getPronunciationUs());
        po.setPronunciationUk(dailyWord.getPronunciationUk());
        po.setAudioUrlUs(dailyWord.getAudioUrlUs());
        po.setAudioUrlUk(dailyWord.getAudioUrlUk());
        po.setTranslation(dailyWord.getTranslation());
        po.setExample(dailyWord.getExample());
        po.setExampleTranslation(dailyWord.getExampleTranslation());
        po.setDifficulty(dailyWord.getDifficulty().getCode());
        po.setCategory(dailyWord.getCategory());
        po.setNotes(dailyWord.getNotes());
        po.setPublishDate(dailyWord.getPublishDate());
        po.setAdminId(dailyWord.getAdminId().value());
        po.setCreateTime(dailyWord.getCreateTime());
        po.setUpdateTime(dailyWord.getUpdateTime());
        return po;
    }

    public DailyWord toDomain(DailyWordPO po) {
        return DailyWord.reconstruct(
                DailyWordId.of(po.getId()),
                po.getWord(),
                po.getPronunciationUs(),
                po.getPronunciationUk(),
                po.getAudioUrlUs(),
                po.getAudioUrlUk(),
                po.getTranslation(),
                po.getExample(),
                po.getExampleTranslation(),
                Difficulty.fromCode(po.getDifficulty()),
                po.getCategory(),
                po.getNotes(),
                po.getPublishDate(),
                UserId.of(po.getAdminId()),
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }
}
