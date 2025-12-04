package com.novacloudedu.backend.infrastructure.persistence.po;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 用户持久化对象（PO）
 * 与数据库表结构一一对应
 */
@TableName(value = "\"user\"")
@Data
public class UserPO implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private Long id;

    private String userAccount;

    private String userPassword;

    private Integer userGender;

    private String userPhone;

    private Integer level;

    private String userName;

    private String userAvatar;

    private String userProfile;

    private String userRole;

    private String userAddress;

    private String userEmail;

    private LocalDate birthday;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

    private Integer isBan;

    @TableLogic
    private Integer isDelete;

    @Serial
    @TableField(exist = false)
    private static final long serialVersionUID = 1L;
}
