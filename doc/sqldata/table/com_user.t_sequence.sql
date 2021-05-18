DROP table if exists com_user.t_sequence;
CREATE TABLE com_user.t_sequence
(
    `id`          bigint(21)                                       NOT NULL COMMENT '序列号ID',
    `name`        varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '序列名',
    `value`       bigint(21)                                       NOT NULL COMMENT '序列值',
    `increment`   int(1)                                           NOT NULL DEFAULT 1 COMMENT '序列自增值 1',
    `min_value`   bigint(21)                                       NOT NULL DEFAULT 1000000 COMMENT '最小序列值',
    `max_value`   bigint(21)                                       NOT NULL DEFAULT 9999999 COMMENT '最大序列值',
    `create_time` timestamp                                        NULL     DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` timestamp                                        NULL     DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE KEY `id` (`id`) USING BTREE,
    UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_bin comment '序列表';

drop function if exists com_user.get_seq_current;
CREATE
    DEFINER = `com_user`@`%` FUNCTION com_user.get_seq_current(seq_name char(100))
    RETURNS BIGINT
    LANGUAGE SQL
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    DECLARE current_value BIGINT;
    SET current_value = 0;
    SELECT value into current_value FROM t_sequence WHERE name = seq_name;
    RETURN current_value;
END;

##获取最大value
drop function if exists com_user.get_seq_max;
CREATE
    DEFINER = `com_user`@`%` FUNCTION com_user.get_seq_max(seq_name char(100))
    RETURNS BIGINT
    LANGUAGE SQL
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    DECLARE max BIGINT;
    SET max = 0;
    SELECT max_value into max FROM t_sequence WHERE name = seq_name;
    RETURN max;
END;

drop function if exists com_user.get_seq_next1;
CREATE
    DEFINER = `com_user`@`%` FUNCTION com_user.get_seq_next1(seq_name char(100))
    RETURNS BIGINT
    LANGUAGE SQL
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    IF (com_user.get_seq_current(seq_name) >= com_user.get_seq_max(seq_name)) THEN
        update t_sequence SET value = min_value where name = seq_name;
    ELSE
        update t_sequence SET value = (value + increment) where name = seq_name;
    END IF;
    RETURN com_user.get_seq_current(seq_name);
END;