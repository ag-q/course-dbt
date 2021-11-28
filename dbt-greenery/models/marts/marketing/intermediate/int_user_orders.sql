select
  user_guid
  , min(created_at_utc) user_first_order_created_at_utc
  , extract(day from current_timestamp - min(created_at_utc)) days_from_user_first_order
  , max(created_at_utc) user_last_order_created_at_utc
  , extract(day from current_timestamp - max(created_at_utc)) days_from_user_last_order
  , case when count(distinct order_guid) = 1 then 'new' else 'repeat' end user_type
  , count(distinct order_guid) user_orders_count
  , count(distinct case when order_status = 'pending' then order_guid else null end) user_pending_orders_count
  , count(distinct case when order_status = 'preparing' then order_guid else null end) user_preparing_orders_count
  , count(distinct case when order_status = 'shipped' then order_guid else null end) user_shipped_orders_count
  , count(distinct case when order_status = 'delivered' then order_guid else null end) user_delivered_orders_count
  , count(distinct case when promo_id is not null then order_guid else null end) user_orders_with_discount_count
  , sum(order_cost) user_order_cost_sum
  , sum(order_total) user_order_total_sum
  , sum(shipping_cost) user_order_shipping_cost_sum
  , sum(order_cost)/count(distinct order_guid) avg_user_order_cost
  , sum(order_total)/count(distinct order_guid) avg_user_order_total
from
  {{ ref('stg_orders') }}
left join
  {{ ref('stg_promos') }}
using (promo_guid)
group by 1