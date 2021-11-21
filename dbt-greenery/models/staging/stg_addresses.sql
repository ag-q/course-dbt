{{
  config(
    unique_key='address_id'
  )
}}

with

addresses_src as (
  select * from {{ source('src_public', 'addresses') }}
),

final as (
  select
    id as address_id,
    address_id as address_guid,
    address,
    zipcode,
    state,
    country
  from addresses_src
)

select * from final