package com.novacloudedu.backend.domain.clazz.valueobject;

public enum ClassRole {
    TEACHER,
    STUDENT;

    public static ClassRole fromString(String role) {
        for (ClassRole r : values()) {
            if (r.name().equalsIgnoreCase(role)) {
                return r;
            }
        }
        throw new IllegalArgumentException("Unknown role: " + role);
    }
}
