{{
  config(
    unique_key='promo_id'
  )
}}

with

promos_src as (
  select * from {{ source('src_public', 'promos') }}
),

final as (
  select
    id as promo_id
    , promo_id as promo_guid
    , discout as discount
    , status as promo_status
  from promos_src
)

select * from final