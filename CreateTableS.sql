-- 精品课数据库
create database ExcellentCourse;
-- 使用精品课数据库
use excellentcourse;
-- 用户表
create table t_user(
user_id	varchar(32) primary key,#	用户id，主键，无实际意义，uuid
username	varchar(16) not null unique,#	用户名，最大长度4-16字符，不可重复
password	varchar(16) not null,#	用户密码，16字符
user_desc	varchar(128),#	用户描述
user_sex	int not null default 0,#	用户性别{0：保密，1：男，2：女}，默认为0
user_birthday	date,#	用户出生日期
user_phone	varchar(11),#	手机号码，11位数字
user_email	varchar(32),# not null	电子邮箱
user_avatar	varchar(256),#	用户头像
user_created	datetime not null default now(),#	账户创建时间
user_login	datetime,#	上次登录时间
user_update	datetime not null default now(),#	用户信息更新时间
user_status	int default 0#用户状态，0已激活，1未激活，2邮箱激活，3电话激活。
);
-- 学校表
create table t_school(
    school_id	varchar(32) not null primary key,--	学校id，主键，无实际意义，uuid
    school_name	varchar(32) not null,--	学校名称
    school_alias	varchar(32),--	学校别名（英文名称）
    school_desc	varchar(256),--	描述
    school_created	date,--	学校成立时间
    school_updated	datetime,--	学校信息修改时间
    school_logo	varchar(128),--	学校Logo
    school_address	varchar(128),--	学校地址
    school_phone	varchar(11),--	学校电话
    school_type	int not null--	学校类型{0：大学本科，1：大学专科，3：高中，4：小学}，必须填写
);
-- 专业表 t_major
-- 字段	类型	描述
create table t_major(
major_id	varchar(32) primary key,--	专业id，主键，无实际意义，uuid
major_name	varchar(32) not null,--	专业名称
major_desc	varchar(256),--	专业描述
major_logo	varchar(128)--	专业Logo
);
-- 专业&学校中间表 tm_school_major
-- 字段	类型	描述
create table tm_school_major(
    inner_id	varchar(32) primary key,--	中间表id，主键，无实际意义，uuid
    school_id	varchar(32),--	学校id，外键
    major	varchar(32)--	专业id，外键
);

-- 班级表
create table t_class(
class_id	varchar(32) primary key,--	班级id，主键，无实际意义，uuid
school_id	varchar(32) not null,--	学校id，与学校绑定
major_id	varchar(32) not null,--	专业id，与专业绑定
class_no	varchar(32) not null,--	班级号
class_grade	date not null--	班级年级
);
# 学生表
create table t_student(
    student_id	varchar(32) primary key,	#学生id，主键，无实际意义，uuid
    user_id	varchar(32) not null,	#用户id，与用户账号绑定
    school_id	varchar(32) not null,#	学校id，与学校绑定
    major_id	varchar(32) not null,	#	专业id，与专业绑定
    class_id	varchar(32) not null,	#	班级id，与班级绑定
    student_no	varchar(64) not null,	#	学生号
    student_name	varchar(16) not null	#	学生姓名，最大长度16字符
);

# 教师表
create table t_teacher(
    teacher_id	varchar(32) primary key,	#	教师id，主键，无实际意义，uuid
    user_id	varchar(32) not null,	#	用户id，与用户账号绑定
    school_id	varchar(32) not null,	#	学校id，与学校绑定
    teacher_no	varchar(32) not null,	#	教师号
    teacher_name	varchar(16) not null,	#	教师姓名，最大长度16字符
    teacher_avatar	varchar(256),	#	头像
    teacher_desc	varchar(256),	#	描述
    teacher_post	varchar(10)	#	教师职位
);

# 课程表
create table t_course(
    course_id	varchar(32) primary key,	#	课程id，主键，无实际意义，uuid
    teacher_id	varchar(32),	#	教师id
    course_name	varchar(16) not null,	#	课程名，最大长度16字符
    course_desc	varchar(256) not null,	#	课程描述，最大长度256字符
    course_logo	varchar(128),	#	课程Logo
    course_created	datetime not null default now(),	#	课程创建日期
    course_updated	datetime not null default now(),	#	课程更新日期
    section_count	int not null,	#	课程章节数量，通过设置计算
    course_hour	int not null,	#	课程学时，必须手动设置，不能为0
    course_views	long not null,	#	课程观看次数，默认为0
    course_star	long not null,	#	课程收藏次数，默认为0
    course_price	decimal(5,2) not null default 0,	#.00	课程价格，默认为0
    course_status	int not null default 0 #	课程状态，{0：开放，1：关闭}，默认为0
);

# 课程章节表
create table t_course_section(
section_id	varchar(32) primary key,#	章节id，主键，无实际意义，uuid
course_id	varchar(32) not null,#	课程id，与课程绑定
section_name	varchar(16) not null,#	章节名称，最大长度16字符，不能为空
parent_id	varchar(32) not null default 0,#	父章节id，默认为0，表示当前为根目录
section_no	int not null,#	章节序号，查询时排序使用
resource_count	int not null,#	当前资源数量，通过资源计算
section_desc	varchar(128)#	章节描述，最大长度128字符
);

# 课程资源表
create table t_course_resource(
resource_id	varchar(32) primary key,#	资源id，主键，无实际意义，uuid
section_id	varchar(32) not null,#	章节id，与章节绑定
resource_type	int not null,#	资源类型{0:图片，1:视频，2:PPT，3:word, 4:其它}
resource_path	varchar(256) not null#	资源路径地址，上传后自动获取
);

# 班级&课程中间表
create table tm_class_course(
inner_id	varchar(32) primary key,#	中间表id，主键，无实际意义，uuid
class_id	varchar(32) not null,#	班级id，绑定班级
class_type	int not null,#	班级类型：{0：系统开设，1：院校开设}
course_id	varchar(32) not null,#	课程id，绑定课程
teacher_id	varchar(32) not null,#	开设老师，绑定教师表，{系统开设默认为课程老师}
create_time	date,#	开设日期
finish_time	date,#	结束日期
credit	double not null default 0,#	学分，{系统开设默认为0}
schedule	double not null default 0#	班级学习进度，默认为0，通过班级平均进度计算
);

# 用户课程中间表
create table tm_user_course(
inner_id	varchar(32) primary key,#	中间表id，主键，无实际意义，uuid
user_id	varchar(32) not null,#	用户id，与用户绑定
course_id	varchar(32) not null#	课程id，与课程绑定
);

# 学习进度表
create table t_schedule(
schedule_id	varchar(32) primary key,#	进度表id，主键，无实际意义，uuid
course_aid	varchar(32),#	课程id，与班级绑定
user_id	varchar(32),#	用户id，与用户绑定
section_id	varchar(32),#	章节id，与章节绑定
schedule	double not null default 0.0#	进度
);

# 成绩表
create table t_score(
score_id	varchar(32) primary key,#	成绩id，主键，无意义，uuid
user_id	varchar(32) not null,#	用户id，与用户绑定
class_id	varchar(32) not null,#	班级id，与班级绑定
mark	double not null default 0.0,#	分数，默认为0
schedule	double not null default 0.0#	学习进度，默认为0
);

# 标签表
create table t_label(
label_id	varchar(32) primary key,#	标签id，主键，无意义，uuid
label_name	varchar(16) not null unique,#	标签名称，最大长度16字符，不能重复
label_desc	varchar(128)#	标签描述
);

# 课程&标签中间表
create table tm_course_lable(
    inner_id	varchar(32) primary key,#	中间表id，主键，无实际意义，uuid
    label_id	varchar(32) not null,#	标签id，与标签绑定
    course_id	varchar(32) not null#	课程id，与课程绑定
);

# 类别表
create table t_category(
    category_id	varchar(32) primary key,#	类别id，主键，无实际意义，uuid
    category_name	varchar(16) not null unique,#	类别名称，不能重复
    category_desc	varchar(128),#	类别描述
    parent_id	varchar(32) not null default 0#	父类别id，根类别默认为0
);

# 类别&课程中间表
create table tm_course_category(
    inner_id	varchar(32) primary key,#	中间表id，主键，无实际意义，uuid
    course_id	varchar(32) not null,#	课程id，绑定课程
    category_id	varchar(32) not null#	类别id，绑定类别
);

# 评论表
create table t_comment(
    comment_id	varchar(32) primary key,#	评论id，主键，无实际意义，uuid
    course_id	varchar(32) not null,#	课程id，与课程绑定
    user_id	varchar(32) not null,#	用户id，与用户绑定
    parent_id	varchar(32) not null default 0,#	父评论id，如为根评论默认为0
    comment_content	varchar(128) not null,#	评论内容，最大长度128个字符，不能为空
    comment_star	int default 0#	点赞次数，默认为0
);

# 角色表
create table t_role(
    role_id	varchar(32) primary key,#	角色id，主键，无实际意义，uuid
    role_name	varchar(16) not null,#	角色名称
    role_created	datetime not null default now(),#	创建时间
    role_desc	varchar(256)#	角色描述
);

# 用户&角色中间表
create table tm_user_role(
    inner_id	varchar(32) primary key,#	中间表id，主键，无实际意义，uuid
    user_id	varchar(32),#	用户id，与用户绑定
    role_id	varchar(32),#	角色id，与角色绑定
    created	datetime not null default now()#	创建时间
);

# 权限表
create table t_permission(
    permission_id	varchar(32) primary key,#	权限表id，主键，无实际意义，uuid
    permission_name	varchar(16) not null,#	权限名称
    permission_created	datetime default now()	,#权限创建时间
    permission_desc	varchar(128)#	权限描述
);

# 角色&权限中间表
create table tm_role_permission(
    inner_id	varchar(32) primary key,#	中间表id，主键，无实际意义，uuid
    role_id	varchar(32),#	角色id，与角色绑定
    permission_id	varchar(32),#	权限id，与权限绑定
    created	datetime not null default now()#	创建时间
);

# 网站布局表
create table t_website_layout(
        layout_id	varchar(32) primary key,#	布局id，主键，无实际意义,uuid
        layout_name	varchar(32) not null,#	布局名称
        layout_type	int not null	,#布局类型，{0：文字，1：图片，2：视频，3：音频}
        layout_page	varchar(32) not null,#	布局页面，如：首页
        layout_location	varchar(32) not null,#	布局位置，如：导航栏
        layout_desc	varchar(128)#	布局描述
);

# 网站资源表
create table t_website_resource(
    resource_id	varchar(32) primary key,#	资源id,uuid
    resource_name	varchar(32) not null	,#资源名称
    associated_data_id	varchar(32) not null	,#关联数据id
    resource_type	int not null,#	资源类型{0：文字，1：图片，2：视频，3：音频}
    resource_weight	int default 0,#	资源权重，排序，默认为0
    resource_desc	varchar(128),#	资源描述
    resource_path	varchar(256) not null#	资源地址
);

# 网站布局&资源中间表
create table tm_website_loyout_resource(
    inner_id	varchar(32) primary key,#	中间表id，uuid
    layout_id	varchar(32) not null,#	布局id
    resource_id	varchar(32) not null,#	资源id
    created	datetime default now(),#	设置时间
    user_id	varchar(32) not null,#	操作用户id
    `desc` varchar(128) not null#	描述
);

# 直播课程表
create table t_live_course(
    live_course_id	varchar(32) primary key,#	id
    teacher_id	varchar(32)	,#教师id
    created	date,#	创建时间
    reserve_time	date,#	预定直播时间
    title	varchar(32),#	直播标题
    star	int,#	预约人数
    finished	date,#	结束时间
    live_course_desc	varchar(256),#	直播课程描述
    start	date	#开始时间，直播时记录
);

# 章节评论表
create table t_section_comment(
    comment_id	varchar(32)	,#id
    section_id	varchar(32),#	章节id
    user_id	varchar(32),#	用户id
    parent_id	varchar(32),#	父评论id，根评论为0
    comment_content	varchar(256),#	评论内容
    comment_star	int default 0,#	点赞次数
    comment_time	datetime#	评论时间
);
