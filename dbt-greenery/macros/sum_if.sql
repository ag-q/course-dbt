{%- macro sum_if(column_name, column_value, prefix = '', suffix = '') -%}

    , sum(case when {{column_name}} = '{{column_value}}' then 1 else 0 end) as {{prefix}}{{column_value}}{{suffix}} 

{%- endmacro -%}