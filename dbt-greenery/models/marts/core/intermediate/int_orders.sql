select
  order_guid
  , rank() over (partition by user_guid order by created_at_utc) user_order_number
  , lead(created_at_utc) over (partition by user_guid order by created_at_utc) user_next_order_created_at_utc
from {{ ref('stg_orders') }}