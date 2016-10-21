-- Suggestion [ent3]
create table "public"."suggestion" (
   "oid"  int4  not null,
  primary key ("oid")
);


-- User_Suggestion [rel11]
alter table "public"."suggestion"  add column  "user_oid"  int4;


-- User_Suggestion_2 [rel12]
alter table "public"."suggestion"  add column  "user_oid_2"  int4;


-- Suggestion_Campaign [rel14]
alter table "public"."suggestion"  add column  "campaign_oid"  int4;


