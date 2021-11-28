{{
  config(
    unique_key='user_id'
  )
}}

with

users_src as (
  select * from {{ source('src_public', 'users') }}
),

final as (
  select
    id as user_id
    , user_id as user_guid
    , first_name
    , last_name
    , email
    , phone_number
    , created_at as created_at_utc
    , updated_at as updated_at_utc
    , address_id as address_guid
  from users_src
)

select * from final