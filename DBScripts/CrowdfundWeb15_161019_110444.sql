-- Group [Group]
create table "public"."group" (
   "oid"  int4  not null,
   "groupname"  varchar(255),
  primary key ("oid")
);


-- Module [Module]
create table "public"."module" (
   "oid"  int4  not null,
   "moduleid"  varchar(255),
   "modulename"  varchar(255),
  primary key ("oid")
);


-- User [User]
create table "public"."user" (
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
create table "public"."pledge" (
   "oid"  int4  not null,
   "amount"  numeric(19, 2),
  primary key ("oid")
);


-- Campaign [ent10]
create table "public"."campaign" (
   "oid"  int4  not null,
   "title"  varchar(255),
   "description"  varchar(255),
   "goal"  numeric(19, 2),
   "expiration"  timestamp,
  primary key ("oid")
);


-- Question [ent11]
create table "public"."question" (
   "oid"  int4  not null,
   "private"  bool,
   "content"  varchar(255),
   "answer"  varchar(255),
  primary key ("oid")
);


-- Tag [ent12]
create table "public"."tag" (
   "oid"  int4  not null,
   "caption"  varchar(255),
  primary key ("oid")
);


-- PaymentInformation [ent2]
create table "public"."paymentinformation" (
   "oid"  int4  not null,
   "data"  varchar(255),
  primary key ("oid")
);


-- Contribution [ent7]
create table "public"."contribution" (
   "oid"  int4  not null,
   "title"  varchar(255),
   "description"  varchar(255),
   "min_amount"  numeric(19, 2),
   "max_pledges"  int4,
  primary key ("oid")
);


-- Group_DefaultModule [Group2DefaultModule_DefaultModule2Group]
alter table "public"."group"  add column  "module_oid"  int4;
alter table "public"."group"   add constraint fk_group_module foreign key ("module_oid") references "public"."module" ("oid");


-- Group_Module [Group2Module_Module2Group]
create table "public"."group_module" (
   "group_oid"  int4 not null,
   "module_oid"  int4 not null,
  primary key ("group_oid", "module_oid")
);
alter table "public"."group_module"   add constraint fk_group_module_group foreign key ("group_oid") references "public"."group" ("oid");
alter table "public"."group_module"   add constraint fk_group_module_module foreign key ("module_oid") references "public"."module" ("oid");


-- User_DefaultGroup [User2DefaultGroup_DefaultGroup2User]
alter table "public"."user"  add column  "group_oid"  int4;
alter table "public"."user"   add constraint fk_user_group foreign key ("group_oid") references "public"."group" ("oid");


-- User_Group [User2Group_Group2User]
create table "public"."user_group" (
   "user_oid"  int4 not null,
   "group_oid"  int4 not null,
  primary key ("user_oid", "group_oid")
);
alter table "public"."user_group"   add constraint fk_user_group_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."user_group"   add constraint fk_user_group_group foreign key ("group_oid") references "public"."group" ("oid");


-- Campaign_Contribution [rel1]
alter table "public"."contribution"  add column  "campaign_oid"  int4;
alter table "public"."contribution"   add constraint fk_contribution_campaign foreign key ("campaign_oid") references "public"."campaign" ("oid");


-- PaymentInformation_User [rel10]
alter table "public"."paymentinformation"  add column  "user_oid"  int4;
alter table "public"."paymentinformation"   add constraint fk_paymentinformation_user foreign key ("user_oid") references "public"."user" ("oid");


-- Question_Campaign [rel2]
alter table "public"."question"  add column  "campaign_oid"  int4;
alter table "public"."question"   add constraint fk_question_campaign foreign key ("campaign_oid") references "public"."campaign" ("oid");


-- Campaign_Tag [rel3]
create table "public"."campaign_tag" (
   "campaign_oid"  int4 not null,
   "tag_oid"  int4 not null,
  primary key ("campaign_oid", "tag_oid")
);
alter table "public"."campaign_tag"   add constraint fk_campaign_tag_campaign foreign key ("campaign_oid") references "public"."campaign" ("oid");
alter table "public"."campaign_tag"   add constraint fk_campaign_tag_tag foreign key ("tag_oid") references "public"."tag" ("oid");


-- CampaignOwner [rel4]
alter table "public"."campaign"  add column  "user_oid"  int4;
alter table "public"."campaign"   add constraint fk_campaign_user foreign key ("user_oid") references "public"."user" ("oid");


-- User_Pledge [rel5]
alter table "public"."pledge"  add column  "user_oid"  int4;
alter table "public"."pledge"   add constraint fk_pledge_user foreign key ("user_oid") references "public"."user" ("oid");


-- Pledge_Contribution [rel6]
alter table "public"."pledge"  add column  "contribution_oid"  int4;
alter table "public"."pledge"   add constraint fk_pledge_contribution foreign key ("contribution_oid") references "public"."contribution" ("oid");


-- User_Campaign_Vote [rel7]
create table "public"."user_campaign_vote" (
   "user_oid"  int4 not null,
   "campaign_oid"  int4 not null,
  primary key ("user_oid", "campaign_oid")
);
alter table "public"."user_campaign_vote"   add constraint fk_user_campaign_vote_user foreign key ("user_oid") references "public"."user" ("oid");
alter table "public"."user_campaign_vote"   add constraint fk_user_campaign_vote_campaign foreign key ("campaign_oid") references "public"."campaign" ("oid");


-- Question_Supporter [rel8]
alter table "public"."question"  add column  "user_oid"  int4;
alter table "public"."question"   add constraint fk_question_user_2 foreign key ("user_oid") references "public"."user" ("oid");


-- Question_Campainer [rel9]
alter table "public"."question"  add column  "user_oid_2"  int4;
alter table "public"."question"   add constraint fk_question_user foreign key ("user_oid_2") references "public"."user" ("oid");


-- Campaign.popularity [ent10#att12]
create view "public"."campaign_popularity_view" as
select AL1."oid" as "oid", sum(AL3."amount") as "der_attr"
from  "public"."campaign" AL1 
               left outer join "public"."contribution" AL2 on AL1."oid"=AL2."campaign_oid"
               left outer join "public"."pledge" AL3 on AL2."oid"=AL3."contribution_oid"
group by AL1."oid";


-- Campaign.quality [ent10#att13]
create view "public"."campaign_quality_view" as
select AL1."oid" as "oid", count(distinct AL2."user_oid") as "der_attr"
from  "public"."campaign" AL1 
               left outer join "public"."user_campaign_vote" AL2 on AL1."oid"=AL2."campaign_oid"
group by AL1."oid";


