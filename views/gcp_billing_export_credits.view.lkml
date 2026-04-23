view: gcp_billing_export_credits {

  ### Field description reference https://cloud.google.com/billing/docs/how-to/export-data-bigquery
  ### DIMENSIONS

  dimension: credit_id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${gcp_billing_export.pk} as STRING), COALESCE(${credit_name}, "0")) ;;
  }

  dimension: credit_amount {
    group_label: "Credits"
    description: "Amount of credit given to billing account (always negative)"
    type: number
    sql: ${TABLE}.amount ;;
  }

  dimension: credit_name {
    group_label: "Credits"
    description: "Name of the credit applied to account"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: credit_type {
    type: string
    description: "The type of credit (e.g., FEE_UTILIZATION_OFFSET, COMMITTED_USAGE_DISCOUNT)."
    sql: ${TABLE}.type ;;
  }

  ### MEASURES

  measure: total_credit {
    description: "The total credit given to billing account (always negative)"
    type: sum
    sql:
      {% if gcp_billing_export.reporting_currency._parameter_value == "'USD'" %}
        SAFE_DIVIDE(${credit_amount}, NULLIF(${gcp_billing_export.currency_conversion_rate}, 0))
      {% else %}
        ${credit_amount}
      {% endif %} ;;
    value_format_name: decimal_2
    html: {% if gcp_billing_export.reporting_currency_code._value == 'GBP' %}
            <a href="{{ link }}">GBP {{ rendered_value }}</a>
          {% elsif gcp_billing_export.reporting_currency_code._value == 'USD' %}
            <a href="{{ link }}">${{ rendered_value }}</a>
          {% elsif gcp_billing_export.reporting_currency_code._value == 'EUR' %}
            <a href="{{ link }}">EUR {{ rendered_value }}</a>
          {% else %}
            <a href="{{ link }}"> {{ rendered_value }} {{ gcp_billing_export.reporting_currency_code._value }}</a>
          {% endif %} ;;
    drill_fields: [gcp_billing_export_credits.credit_name,gcp_billing_export_credits.credit_amount]
  }

}
