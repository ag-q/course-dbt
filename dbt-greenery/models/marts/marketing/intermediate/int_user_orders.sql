{%- set order_statuses = dbt_utils.get_column_values(table=ref('stg_orders'), column='order_status') -%}

select
  user_guid
  , min(created_at_utc) user_first_order_created_at_utc
  , extract(day from current_timestamp - min(created_at_utc)) days_from_user_first_order
  , max(created_at_utc) user_last_order_created_at_utc
  , extract(day from current_timestamp - max(created_at_utc)) days_from_user_last_order
  , case when count(distinct order_guid) = 1 then 'new' else 'repeat' end user_type
  , count(distinct order_guid) user_orders_count
  {%- for order_status in order_statuses -%}
  {{ count_distinct_if('order_status', order_status, 'order_guid', 'user_', '_orders_count') }}
  {% endfor -%}
  , count(distinct case when promo_id is not null then order_guid else null end) user_orders_with_discount_count
  , sum(order_cost) user_order_cost_sum
  , sum(order_total) user_order_total_sum
  , sum(shipping_cost) user_order_shipping_cost_sum
  , sum(order_cost)/count(distinct order_guid) avg_user_order_cost
  , sum(order_total)/count(distinct order_guid) avg_user_order_total
from {{ ref('stg_orders') }}
left join {{ ref('stg_promos') }} using (promo_guid)
group by 1


