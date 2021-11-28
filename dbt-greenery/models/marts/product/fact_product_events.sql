select
  product_guid
  , product_name
  , events
  , product_page_view_events
  , product_add_to_cart_events
  , product_delete_from_cart_events
  , product_checkout_events
  , product_package_shipped_events
  , sessions
  , product_page_view_sessions
  , product_add_to_cart_sessions
  , product_delete_from_cart_sessions
  , product_checkout_sessions
  , product_package_shipped_sessions
  , users
  , product_page_view_users
  , product_add_to_cart_users
  , product_delete_from_cart_users
  , product_checkout_users
  , product_package_shipped_users
from
  {{ ref('int_product_events') }}
left join
  {{ ref('stg_products') }}
using(product_guid)