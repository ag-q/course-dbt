{%- set event_types = dbt_utils.get_column_values(table=ref('stg_events'), column='event_type') -%}

select
    session_guid
    , user_guid
    , min(created_at_utc) as created_at_utc
    {%- for event_type in event_types -%}
    {{ sum_if('event_type', event_type, '', '_events') }}
    {% endfor -%}
from {{ ref('stg_events') }}
{{ dbt_utils.group_by(2) }}