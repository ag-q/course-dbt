select
  substring(page_url, '[^/]*$') product_guid
  , count(distinct event_guid) events
  , count(distinct case when event_type = 'page_view' then event_guid else null end) product_page_view_events
  , count(distinct case when event_type = 'add_to_cart' then event_guid else null end) product_add_to_cart_events
  , count(distinct case when event_type = 'delete_from_cart' then event_guid else null end) product_delete_from_cart_events
  , count(distinct case when event_type = 'checkout' then event_guid else null end) product_checkout_events
  , count(distinct case when event_type = 'package_shipped' then event_guid else null end) product_package_shipped_events
  , count(distinct session_guid) sessions
  , count(distinct case when event_type = 'page_view' then session_guid else null end) product_page_view_sessions
  , count(distinct case when event_type = 'add_to_cart' then session_guid else null end) product_add_to_cart_sessions
  , count(distinct case when event_type = 'delete_from_cart' then session_guid else null end) product_delete_from_cart_sessions
  , count(distinct case when event_type = 'checkout' then session_guid else null end) product_checkout_sessions
  , count(distinct case when event_type = 'package_shipped' then session_guid else null end) product_package_shipped_sessions
  , count(distinct user_guid) users
  , count(distinct case when event_type = 'page_view' then user_guid else null end) product_page_view_users
  , count(distinct case when event_type = 'add_to_cart' then user_guid else null end) product_add_to_cart_users
  , count(distinct case when event_type = 'delete_from_cart' then user_guid else null end) product_delete_from_cart_users
  , count(distinct case when event_type = 'checkout' then user_guid else null end) product_checkout_users
  , count(distinct case when event_type = 'package_shipped' then user_guid else null end) product_package_shipped_users
from
  {{ ref('stg_events') }}
group by 1