select
  user_guid
  , min(created_at_utc) user_first_session_created_at_utc
  , count(distinct session_guid) user_sessions
  , count(distinct case when event_type = 'page_view' then event_guid else null end) user_page_views
  , count(distinct case when event_type = 'account_created' then 'true' else 'false' end) user_account_created
  , count(distinct case when event_type = 'page_view' then session_guid else null end) user_page_view_sessions
  , count(distinct case when event_type = 'add_to_cart' then session_guid else null end) user_add_to_cart_sessions
  , count(distinct case when event_type = 'delete_from_cart' then session_guid else null end) user_delete_from_cart_sessions
  , count(distinct case when event_type = 'checkout' then session_guid else null end) user_checkout_sessions
  , count(distinct case when event_type = 'package_shipped' then session_guid else null end) user_package_shipped_sessions

from
  {{ ref('stg_events') }}
  group by 1