-- 默认数据种子
-- 此文件应在所有表创建后执行

-- 默认管理员账号
-- 账号: admin
-- 密码: 123456
-- BCrypt hash for "admin123": $2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVKIUi
INSERT INTO "user" (user_account, user_password, user_name, user_role, level)
VALUES ('admin', '$2a$10$FVszfHXWI0REOV5cB9tvguaQ55ROaklP/OUbb61m0BrWCxuN4Am8a', '系统管理员', 'admin', 99)
ON CONFLICT (user_account) DO NOTHING;

-- 默认测试老师账号
-- 账号: teacher
-- 密码: 123456
INSERT INTO "user" (user_account, user_password, user_name, user_role, level)
VALUES ('teacher', '$2a$10$FVszfHXWI0REOV5cB9tvguaQ55ROaklP/OUbb61m0BrWCxuN4Am8a', '测试讲师', 'teacher', 10)
ON CONFLICT (user_account) DO NOTHING;

-- 默认测试学生账号
-- 账号: student
-- 密码: 123456
INSERT INTO "user" (user_account, user_password, user_name, user_role, level)
VALUES ('student', '$2a$10$FVszfHXWI0REOV5cB9tvguaQ55ROaklP/OUbb61m0BrWCxuN4Am8a', '测试学生', 'student', 1)
ON CONFLICT (user_account) DO NOTHING;
