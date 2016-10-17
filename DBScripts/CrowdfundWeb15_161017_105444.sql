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


