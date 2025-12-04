package com.novacloudedu.backend.infrastructure.persistence.converter;

import com.novacloudedu.backend.domain.user.entity.User;
import com.novacloudedu.backend.domain.user.valueobject.*;
import com.novacloudedu.backend.infrastructure.persistence.po.UserPO;
import org.springframework.stereotype.Component;

/**
 * 用户领域对象与持久化对象转换器
 */
@Component
public class UserConverter {

    /**
     * PO -> Domain Entity
     */
    public User toDomain(UserPO po) {
        if (po == null) {
            return null;
        }
        return User.reconstruct(
                UserId.of(po.getId()),
                UserAccount.of(po.getUserAccount()),
                Password.fromEncoded(po.getUserPassword()),
                po.getUserName(),
                po.getUserAvatar(),
                po.getUserProfile(),
                UserRole.fromValue(po.getUserRole()),
                po.getUserGender(),
                po.getUserPhone(),
                po.getUserEmail(),
                po.getUserAddress(),
                po.getBirthday(),
                po.getLevel(),
                po.getIsBan() != null && po.getIsBan() == 1,
                po.getCreateTime(),
                po.getUpdateTime()
        );
    }

    /**
     * Domain Entity -> PO
     */
    public UserPO toPO(User user) {
        if (user == null) {
            return null;
        }
        UserPO po = new UserPO();
        if (user.getId() != null) {
            po.setId(user.getId().value());
        }
        po.setUserAccount(user.getAccount().value());
        po.setUserPassword(user.getPassword().encodedValue());
        po.setUserName(user.getUserName());
        po.setUserAvatar(user.getUserAvatar());
        po.setUserProfile(user.getUserProfile());
        po.setUserRole(user.getRole().getValue());
        po.setUserGender(user.getUserGender());
        po.setUserPhone(user.getUserPhone());
        po.setUserEmail(user.getUserEmail());
        po.setUserAddress(user.getUserAddress());
        po.setBirthday(user.getBirthday());
        po.setLevel(user.getLevel());
        po.setIsBan(user.isBanned() ? 1 : 0);
        po.setCreateTime(user.getCreateTime());
        po.setUpdateTime(user.getUpdateTime());
        return po;
    }
}
