begin
    dbms_network_acl_admin.create_acl (         -- 创建访问控制文件（ACL）
        acl         => 'http.xml',              -- 文件名称
        description => 'HTTP Access',           -- 描述
        principal   => 'SCOTT',                 -- 授权或者取消授权账号，大小写敏感
        is_grant    => TRUE,                    -- 授权还是取消授权
        privilege   => 'connect',               -- 授权或者取消授权的权限列表
        start_date  => null,                    -- 起始日期
        end_date    => null                     -- 结束日期
    );

    dbms_network_acl_admin.add_privilege (      -- 添加访问权限列表项
        acl        => 'http.xml',               -- 刚才创建的acl名称
        principal  => 'SCOTT',                  -- 授权或取消授权用户
        is_grant   => TRUE,                     -- 与上同
        privilege  => 'resolve',                -- 权限列表
        start_date => null,
        end_date   => null
    );

    dbms_network_acl_admin.assign_acl (         -- 该段命令意思是允许访问acl名为utl_http.xml下授权的用户，使用oracle网络访问包，所允许访问的目的主机，及其端口范围。
        acl        => 'http.xml',
        host       => '*',                      
                                                -- 且建议使用ip地址或者使用域名，若用localhost，当oracle不是安装在本机上的情况下，会出现问题
        lower_port => 1,                        -- 允许访问的起始端口号
        upper_port => 9999                      -- 允许访问的截止端口号
    );
    commit;
end;
/