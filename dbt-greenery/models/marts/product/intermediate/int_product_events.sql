{%- set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') -%}

with product_deleted_from_cart_info as (
  select
    session_guid
    , product_guid
    , case when max(case when event_type = 'delete_from_cart' then created_at_utc else null end) = 
    max(case when event_type in ('add_to_cart', 'delete_from_cart') then created_at_utc else null end)
    then 'true' else 'false' end is_deleted_from_cart
    from {{ ref('stg_events') }}
    {{ dbt_utils.group_by(2) }}
)
, session_info as (
  select session_guid
  , max(case when event_type = 'checkout' then 1 else 0 end) has_checkout
  , max(case when event_type = 'package_shipped' then 1 else 0 end) has_package_shipped
  from {{ ref('stg_events') }}
  group by 1
)
select
  product_guid
  , session_guid
  , event_guid
  , user_guid
  , created_at_utc
  , event_type
  , is_deleted_from_cart
  , has_checkout
  , has_package_shipped
from {{ ref('stg_events') }}
left join product_deleted_from_cart_info using(session_guid, product_guid)
left join session_info using(session_guid)
where product_guid is not null
  
