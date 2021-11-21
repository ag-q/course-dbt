{% snapshot addresses_snapshot %}

  {{
    config(
      target_schema='dbt_ak_snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['address_id', 'address', 'zipcode', 'state', 'country']
    )
  }}

  SELECT * 
  FROM {{ source('src_public', 'addresses') }}

{% endsnapshot %}