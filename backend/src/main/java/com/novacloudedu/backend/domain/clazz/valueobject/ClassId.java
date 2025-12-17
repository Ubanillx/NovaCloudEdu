package com.novacloudedu.backend.domain.clazz.valueobject;

import lombok.Value;

@Value(staticConstructor = "of")
public class ClassId {
    Long value;
}
