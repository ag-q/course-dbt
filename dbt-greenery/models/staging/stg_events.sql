{{
  config(
    unique_key='event_id'
  )
}}

with

events_src as (
  select * from {{ source('src_public', 'events') }}
),

final as (
  select
    id as event_id
    , event_id as event_guid
    , session_id as session_guid
    , user_id as user_guid
    , page_url
    , created_at as created_at_utc
    , event_type
    , case when substring(page_url, '[^/]*$') ~ '^[a-z\.]+$' then null else substring(page_url, '[^/]*$') end product_guid
  from events_src
)

select * from final