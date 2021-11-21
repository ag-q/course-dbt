{% snapshot products_snapshot %}

  {{
    config(
      target_schema='dbt_ak_snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['product_id', 'name', 'price', 'quantity']
    )
  }}

  SELECT * 
  FROM {{ source('src_public', 'products') }}

{% endsnapshot %}