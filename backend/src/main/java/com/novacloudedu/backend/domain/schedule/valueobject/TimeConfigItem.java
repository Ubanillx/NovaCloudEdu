package com.novacloudedu.backend.domain.schedule.valueobject;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
public class TimeConfigItem implements Serializable {
    private Integer section;
    private String start;
    private String end;
}
