select
  user_guid
  , string_agg(product_name, ' & ' order by product_name) ordered_products
  , sum(product_quantity) as user_total_product_quantity
  , sum(product_quantity)/count(distinct order_guid) avg_user_order_product_quantity
from {{ ref('stg_orders') }}
left join {{ ref('stg_order_items') }} using(order_guid)
left join {{ ref('stg_products') }} using(product_guid)
group by 1