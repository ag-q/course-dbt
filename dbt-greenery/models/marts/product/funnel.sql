select
    created_at_utc
    , count(distinct session_guid) sessions
    , count(distinct case when page_view_events > 0 or add_to_cart_events > 0 or checkout_events > 0 then session_guid else null end) page_view_sessions
    , count(distinct case when (page_view_events > 0 and product_guid is not null) or add_to_cart_events > 0 or checkout_events > 0 then session_guid else null end) product_page_view_sessions
    , count(distinct case when add_to_cart_events > 0 or checkout_events > 0 then session_guid else null end) add_to_cart_sessions
    , count(distinct case when checkout_events > 0 then session_guid else null end) checkout_sessions
from {{ ref('fact_session_events') }}
group by 1