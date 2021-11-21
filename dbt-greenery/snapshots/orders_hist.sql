{% snapshot orders_snapshot %}

  {{
    config(
      target_schema='dbt_ak_snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['order_id', 'user_id', 'promo_id', 'address_id', 'created_at', 'order_cost', 'shipping_cost', 'order_total', 'tracking_id', 'shipping_service', 'estimated_delivery_at', 'delivered_at', 'status']
    )
  }}

  SELECT * 
  FROM {{ source('src_public', 'orders') }}

{% endsnapshot %}