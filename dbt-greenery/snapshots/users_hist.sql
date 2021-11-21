{% snapshot users_snapshot %}

  {{
    config(
      target_schema='dbt_ak_snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

  SELECT * 
  FROM {{ source('src_public', 'users') }}

{% endsnapshot %}