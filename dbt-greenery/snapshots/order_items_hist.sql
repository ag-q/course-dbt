{% snapshot order_items_snapshot %}

  {{
    config(
      target_schema='dbt_ak_snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['order_id', 'product_id', 'quantity']
    )
  }}

  SELECT * 
  FROM {{ source('src_public', 'order_items') }}

{% endsnapshot %}