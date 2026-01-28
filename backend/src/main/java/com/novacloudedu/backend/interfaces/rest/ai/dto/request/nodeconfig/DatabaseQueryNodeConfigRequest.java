package com.novacloudedu.backend.interfaces.rest.ai.dto.request.nodeconfig;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * 数据库查询节点配置请求
 */
@Data
@Schema(description = "数据库查询节点配置")
public class DatabaseQueryNodeConfigRequest {

    @Schema(description = "数据源ID", example = "1")
    private Long dataSourceId;

    @Schema(description = "数据源名称（预定义数据源）", example = "primary")
    private String dataSourceName;

    @Schema(description = "查询类型", example = "SELECT", 
            allowableValues = {"SELECT", "INSERT", "UPDATE", "DELETE", "CALL"})
    private String queryType;

    @Schema(description = "SQL语句，支持变量替换", 
            example = "SELECT * FROM users WHERE id = #{userId}")
    private String sql;

    @Schema(description = "SQL参数映射，变量名到参数名的映射")
    private Map<String, String> parameterMapping;

    @Schema(description = "是否使用预编译语句", example = "true")
    private Boolean usePreparedStatement;

    @Schema(description = "查询超时时间（秒）", example = "30")
    private Integer queryTimeout;

    @Schema(description = "最大返回行数", example = "1000")
    private Integer maxRows;

    @Schema(description = "是否返回单条记录", example = "false")
    private Boolean singleResult;

    @Schema(description = "输出变量名", example = "queryResult")
    private String outputVariable;

    @Schema(description = "结果字段映射")
    private List<FieldMappingDTO> fieldMappings;

    @Schema(description = "是否开启事务", example = "false")
    private Boolean transactional;

    @Data
    @Schema(description = "字段映射")
    public static class FieldMappingDTO {
        @Schema(description = "数据库字段名", example = "user_name")
        private String columnName;

        @Schema(description = "映射到的变量名", example = "userName")
        private String variableName;

        @Schema(description = "数据类型转换", example = "STRING", 
                allowableValues = {"STRING", "INTEGER", "LONG", "DOUBLE", "BOOLEAN", "DATE", "JSON"})
        private String dataType;
    }
}
