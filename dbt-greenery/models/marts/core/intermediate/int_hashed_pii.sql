select
  user_guid
  , md5(email) hashed_email
  , md5(phone_number) hashed_phone_number
  , md5(address) hashed_address
from
  {{ ref('stg_users') }}
left join
  {{ ref('stg_addresses') }}
using(address_guid)