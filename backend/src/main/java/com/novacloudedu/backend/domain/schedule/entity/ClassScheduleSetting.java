package com.novacloudedu.backend.domain.schedule.entity;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.novacloudedu.backend.domain.clazz.valueobject.ClassId;
import com.novacloudedu.backend.domain.schedule.valueobject.TimeConfigItem;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ClassScheduleSetting {

    private Long id;
    private ClassId classId;
    private String semester;
    private LocalDate startDate;
    private Integer totalWeeks;
    private Integer daysPerWeek;
    private Integer sectionsPerDay;
    private List<TimeConfigItem> timeConfig;
    private Boolean isActive;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    // Factory method for creating new setting
    public static ClassScheduleSetting create(ClassId classId, String semester, LocalDate startDate,
                                              Integer totalWeeks, Integer daysPerWeek, Integer sectionsPerDay,
                                              List<TimeConfigItem> timeConfig) {
        ClassScheduleSetting setting = new ClassScheduleSetting();
        setting.classId = classId;
        setting.semester = semester;
        setting.startDate = startDate;
        setting.totalWeeks = totalWeeks != null ? totalWeeks : 20;
        setting.daysPerWeek = daysPerWeek != null ? daysPerWeek : 7;
        setting.sectionsPerDay = sectionsPerDay != null ? sectionsPerDay : 12;
        setting.timeConfig = timeConfig != null ? timeConfig : new ArrayList<>();
        setting.isActive = false; // Default not active
        setting.createTime = LocalDateTime.now();
        setting.updateTime = LocalDateTime.now();
        return setting;
    }

    // Reconstruct from persistence
    public static ClassScheduleSetting reconstruct(Long id, ClassId classId, String semester, LocalDate startDate,
                                                   Integer totalWeeks, Integer daysPerWeek, Integer sectionsPerDay,
                                                   String timeConfigJson, Boolean isActive,
                                                   LocalDateTime createTime, LocalDateTime updateTime) {
        ClassScheduleSetting setting = new ClassScheduleSetting();
        setting.id = id;
        setting.classId = classId;
        setting.semester = semester;
        setting.startDate = startDate;
        setting.totalWeeks = totalWeeks;
        setting.daysPerWeek = daysPerWeek;
        setting.sectionsPerDay = sectionsPerDay;
        
        try {
            if (timeConfigJson != null && !timeConfigJson.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                setting.timeConfig = mapper.readValue(timeConfigJson, new TypeReference<List<TimeConfigItem>>() {});
            } else {
                setting.timeConfig = new ArrayList<>();
            }
        } catch (JsonProcessingException e) {
            setting.timeConfig = new ArrayList<>();
            // Log error or handle gracefully
        }

        setting.isActive = isActive;
        setting.createTime = createTime;
        setting.updateTime = updateTime;
        return setting;
    }
    
    public void activate() {
        this.isActive = true;
        this.updateTime = LocalDateTime.now();
    }
    
    public void deactivate() {
        this.isActive = false;
        this.updateTime = LocalDateTime.now();
    }

    public void updateConfig(String semester, LocalDate startDate, Integer totalWeeks, 
                             Integer daysPerWeek, Integer sectionsPerDay, List<TimeConfigItem> timeConfig) {
        this.semester = semester;
        this.startDate = startDate;
        this.totalWeeks = totalWeeks;
        this.daysPerWeek = daysPerWeek;
        this.sectionsPerDay = sectionsPerDay;
        this.timeConfig = timeConfig;
        this.updateTime = LocalDateTime.now();
    }
    
    public String getTimeConfigJson() {
        try {
            if (this.timeConfig == null) {
                return "[]";
            }
            ObjectMapper mapper = new ObjectMapper();
            return mapper.writeValueAsString(this.timeConfig);
        } catch (JsonProcessingException e) {
            return "[]";
        }
    }
}
