{{
  config(
    unique_key='product_id'
  )
}}

with

products_src as (
  select * from {{ source('src_public', 'products') }}
),

final as (
  select
    id as product_id,
    product_id as product_guid,
    name as product_name,
    price as product_price,
    quantity as product_quantity
  from products_src
)

select * from final