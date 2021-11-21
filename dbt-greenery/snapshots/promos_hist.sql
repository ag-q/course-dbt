{% snapshot promos_snapshot %}

  {{
    config(
      target_schema='dbt_ak_snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['promo_id', 'discout', 'status']
    )
  }}

  SELECT * 
  FROM {{ source('src_public', 'promos') }}

{% endsnapshot %}