select
  order_item_id
  , order_guid
  , product_guid
  , product_quantity
from
  {{ ref('stg_order_items') }}