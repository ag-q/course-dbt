{%- set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') -%}

select
  user_guid
  , min(created_at_utc) user_first_session_created_at_utc
  , count(distinct session_guid) user_sessions
  , count(distinct case when event_type = 'page_view' then event_guid else null end) user_page_views
  , count(distinct case when event_type = 'account_created' then 'true' else 'false' end) user_account_created
  {%- for event_type in event_types -%}
  {{ count_distinct_if('event_type', event_type, 'session_guid', 'user_', '_sessions') }}
  {% endfor -%}
from {{ ref('stg_events') }}
group by 1