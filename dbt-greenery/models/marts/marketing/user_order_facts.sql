select
  user_id
  , user_guid
  , first_name
  , last_name
  , zipcode
  , state
  , country
  , created_at_utc as user_created_at_utc
  , user_first_order_created_at_utc
  , user_last_order_created_at_utc
  , days_from_user_last_order
  , user_orders_count
  , user_type
  , user_pending_orders_count
  , user_preparing_orders_count
  , user_shipped_orders_count
  , user_delivered_orders_count
  , user_order_cost_sum
  , user_order_total_sum
  , user_order_shipping_cost_sum
  , avg_user_order_cost
  , avg_user_order_total
  , ordered_products
  , user_total_product_quantity
  , avg_user_order_product_quantity
  , user_first_session_created_at_utc
  , user_sessions
  , user_page_views
  , user_account_created
  , user_page_view_sessions
  , user_add_to_cart_sessions
  , user_delete_from_cart_sessions
  , user_checkout_sessions
  , user_package_shipped_sessions
from
  {{ ref('stg_users') }}
left join
  {{ ref('stg_addresses') }}
using(address_guid)
left join
  {{ ref('int_user_orders') }}
using(user_guid)
left join
  {{ ref('int_user_products') }}
using(user_guid)
left join
  {{ ref('int_user_events') }}
using(user_guid)