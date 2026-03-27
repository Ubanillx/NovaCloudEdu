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

-- teacher 账号 → TEACHER 会员计划（永久有效，状态=生效中）
INSERT INTO user_membership (user_id, plan_id, start_time, expire_time, status)
SELECT u.id, p.id, NOW(), NULL, 1
FROM "user" u, membership_plan p
WHERE u.user_account = 'teacher' AND p.code = 'TEACHER'
ON CONFLICT DO NOTHING;

-- admin 账号 → TEACHER 会员计划（永久有效，状态=生效中）
INSERT INTO user_membership (user_id, plan_id, start_time, expire_time, status)
SELECT u.id, p.id, NOW(), NULL, 1
FROM "user" u, membership_plan p
WHERE u.user_account = 'admin' AND p.code = 'TEACHER'
ON CONFLICT DO NOTHING;

-- teacher 账号 → teacher 表（讲师管理，admin 为创建者）
INSERT INTO teacher (name, introduction, expertise, user_id, admin_id)
SELECT u.user_name, '测试讲师简介', '[]', u.id,
       (SELECT id FROM "user" WHERE user_account = 'admin' LIMIT 1)
FROM "user" u
WHERE u.user_account = 'teacher'
AND NOT EXISTS (SELECT 1 FROM teacher WHERE teacher.user_id = u.id);
