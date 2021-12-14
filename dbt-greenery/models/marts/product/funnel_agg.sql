select
    sum(sessions)/sum(sessions) sessions
    , sum(page_view_sessions)/sum(sessions) page_view_rate
    , sum(product_page_view_sessions)/sum(sessions) product_page_view_rate
    , sum(add_to_cart_sessions)/sum(sessions) add_to_cart_rate
    , sum(checkout_sessions)/sum(sessions) checkout_rate
from {{ ref('funnel') }}