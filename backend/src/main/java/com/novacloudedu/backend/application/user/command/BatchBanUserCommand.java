package com.novacloudedu.backend.application.user.command;

import java.util.List;

/**
 * 批量封禁/解封用户命令
 */
public record BatchBanUserCommand(
        List<Long> userIds,
        boolean banned
) {
}
