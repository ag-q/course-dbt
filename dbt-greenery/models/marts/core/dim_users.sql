select
  user_id
  , user_guid
  , first_name
  , last_name
  , hashed_email
  , hashed_phone_number
  , hashed_address
  , zipcode
  , state
  , country
  , created_at_utc
from {{ ref('stg_users') }}
left join {{ ref('int_hashed_pii') }} using(user_guid)
left join {{ ref('stg_addresses') }} using(address_guid)