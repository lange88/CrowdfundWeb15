-- Group [Group]
create table "public"."group_2" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module_2" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- User [User]
create table "public"."user_2" (
   "oid"  int4  not null,
   "username"  varchar(255),
   "password"  varchar(255),
   "email"  varchar(255),
   "birthdate"  date,
   "reputation"  int4,
   "wisdom"  int4,
  primary key ("oid")
);


-- Pledge [ent1]
create table "public"."pledge_2" (
   "oid"  int4  not null,
   "amount"  numeric(19, 2),
  primary key ("oid")
);


-- Campaign [ent10]
create table "public"."campaign_2" (
   "oid"  int4  not null,
   "title"  varchar(255),
   "description"  varchar(255),
   "goal"  numeric(19, 2),
   "expiration"  timestamp,
   "popularity"  float8,
   "quality"  float8,
  primary key ("oid")
);


-- Question [ent11]
create table "public"."question_2" (
   "oid"  int4  not null,
   "private"  bool,
   "content"  varchar(255),
   "answer"  varchar(255),
  primary key ("oid")
);


-- Tag [ent12]
create table "public"."tag_2" (
   "oid"  int4  not null,
   "caption"  varchar(255),
  primary key ("oid")
);


-- PaymentInformation [ent2]
create table "public"."paymentinformation_2" (
   "oid"  int4  not null,
   "data"  varchar(255),
  primary key ("oid")
);


-- Contribution [ent7]
create table "public"."contribution_2" (
   "oid"  int4  not null,
   "title"  varchar(255),
   "description"  varchar(255),
   "min_amount"  numeric(19, 2),
   "max_pledges"  int4,
  primary key ("oid")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group_2"  add column  "module_2_oid"  int4;


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module_2" (
   "group_2_oid"  int4 not null,
   "module_2_oid"  int4 not null,
  primary key ("group_2_oid", "module_2_oid")
);


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user_2"  add column  "group_2_oid"  int4;


-- User_Group [User2Group_Group2User]
create table "public"."user_group_2" (
   "user_2_oid"  int4 not null,
   "group_2_oid"  int4 not null,
  primary key ("user_2_oid", "group_2_oid")
);


-- Campaign_Contribution [rel1]
alter table "public"."contribution_2"  add column  "campaign_2_oid"  int4;


-- PaymentInformation_User [rel10]
alter table "public"."paymentinformation_2"  add column  "user_2_oid"  int4;


-- Campaign_Tag [rel3]
create table "public"."campaign_tag_2" (
   "campaign_2_oid"  int4 not null,
   "tag_2_oid"  int4 not null,
  primary key ("campaign_2_oid", "tag_2_oid")
);


-- CampaignOwner [rel4]
alter table "public"."campaign_2"  add column  "user_2_oid"  int4;


-- User_Pledge [rel5]
alter table "public"."pledge_2"  add column  "user_2_oid"  int4;


-- Pledge_Contribution [rel6]
alter table "public"."pledge_2"  add column  "contribution_2_oid"  int4;


-- User_Campaign_Vote [rel7]
create table "public"."user_campaign_vote_2" (
   "user_2_oid"  int4 not null,
   "campaign_2_oid"  int4 not null,
  primary key ("user_2_oid", "campaign_2_oid")
);


-- Question_Supporter [rel8]
alter table "public"."question_2"  add column  "user_2_oid"  int4;


-- Question_Campainer [rel9]
alter table "public"."question_2"  add column  "user_2_oid_2"  int4;


