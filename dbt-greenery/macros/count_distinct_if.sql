{%- macro count_distinct_if(column_name, column_value, count_column_name, prefix = '', suffix = '') -%}
, count(distinct case when {{column_name}} = '{{column_value}}' then {{count_column_name}} else null end) as {{prefix}}{{column_value}}{{suffix}}
{%- endmacro -%}