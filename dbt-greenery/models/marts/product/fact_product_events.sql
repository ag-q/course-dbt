select
  product_guid
  , product_name
  , count(distinct case when event_type = 'page_view' then session_guid else null end) product_page_view_sessions
  , count(distinct case when event_type = 'add_to_cart' then session_guid else null end) add_to_cart_sessions
  , count(distinct case when event_type = 'delete_from_cart' then session_guid else null end) delete_from_cart_sessions
  , count(distinct case when has_checkout = 1 and is_deleted_from_cart = 'false' then session_guid else null end) checkout_sessions
  , count(distinct case when has_package_shipped = 1 and is_deleted_from_cart = 'false' then session_guid else null end) package_shipped_sessions
from {{ ref('int_product_events') }}
left join {{ ref('dim_products') }} using(product_guid)
{{ dbt_utils.group_by(2) }}
