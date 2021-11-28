select
  order_id
  , order_guid
  , user_guid
  , user_order_number
  , extract(day from user_next_order_created_at_utc - created_at_utc) days_to_next_user_order
  , created_at_utc
  , order_cost
  , shipping_cost
  , order_total
  , coalesce(order_total/(1::float-discount/100::float), order_total)::real order_total_before_discount
  , promo_guid
  , discount as promo_discount
  , promo_status
  , tracking_guid
  , shipping_service
  , estimated_delivery_at_utc
  , delivered_at_utc
  , extract(day from delivered_at_utc - created_at_utc) days_to_deliver
  , order_status
  , address_guid
from
  {{ ref('stg_orders') }} o
left join
  {{ ref('int_orders') }}
using (order_guid)
left join
  {{ ref('stg_promos') }}
using (promo_guid)