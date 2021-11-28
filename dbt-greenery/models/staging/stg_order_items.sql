{{
  config(
    unique_key='order_item_id'
  )
}}

with

order_items_src as (
  select * from {{ source('src_public', 'order_items') }}
),

final as (
  select
    id as order_item_id
    , order_id as order_guid
    , product_id as product_guid
    , quantity as product_quantity
  from order_items_src
)

select * from final