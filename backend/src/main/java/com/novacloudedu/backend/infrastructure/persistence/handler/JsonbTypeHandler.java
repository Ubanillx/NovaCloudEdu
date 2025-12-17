package com.novacloudedu.backend.infrastructure.persistence.handler;

import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import java.sql.PreparedStatement;
import java.sql.SQLException;

@MappedTypes({Object.class})
@MappedJdbcTypes(JdbcType.OTHER)
public class JsonbTypeHandler extends JacksonTypeHandler {

    public JsonbTypeHandler(Class<?> type) {
        super(type);
    }

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, Object parameter, JdbcType jdbcType) throws SQLException {
        ps.setObject(i, toJson(parameter), java.sql.Types.OTHER);
    }
}
