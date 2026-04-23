---
- dashboard: gcp_cost_trends
  title: GCP Cost trends
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: 9xzro2LWIdyupNFVviUeTD
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: GCP % Cost Change MoM
    name: GCP % Cost Change MoM
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export_service.description, gcp_billing_export.total_cost,
      gcp_billing_export.usage_end_month]
    pivots: [gcp_billing_export_service.description]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export_service.description: GCP Billing Service,Compute Engine,BigQuery,Networking,Cloud
        Storage,Cloud Logging,Cloud Pub/Sub,Cloud Run,Fivetran Data Pipelines,Cloud
        Composer,Cloud SQL,Cloud Dataflow,cloud spanner
      gcp_billing_export_project.name: ''
      gcp_billing_export.usage_end_month: 12 month ago for 12 month
    sorts: [gcp_billing_export_service.description, gcp_billing_export.usage_end_month]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${gcp_billing_export.total_cost}/offset(${gcp_billing_export.total_cost},\
        \ -1) - 1"
      label: Month over month rate
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: month_over_month_rate
      _type_hint: number
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: gcp_billing_export.total_cost,
            id: BigQuery - gcp_billing_export.total_cost, name: BigQuery - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Composer
              - gcp_billing_export.total_cost, name: Cloud Composer - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Dataflow
              - gcp_billing_export.total_cost, name: Cloud Dataflow - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Logging
              - gcp_billing_export.total_cost, name: Cloud Logging - GCP Billing Total
              Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Pub/Sub - gcp_billing_export.total_cost,
            name: Cloud Pub/Sub - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost,
            id: Cloud Run - gcp_billing_export.total_cost, name: Cloud Run - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud SQL -
              gcp_billing_export.total_cost, name: Cloud SQL - GCP Billing Total Cost},
          {axisId: gcp_billing_export.total_cost, id: Cloud Storage - gcp_billing_export.total_cost,
            name: Cloud Storage - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost,
            id: Compute Engine - gcp_billing_export.total_cost, name: Compute Engine
              - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost, id: Fivetran
              Data Pipelines - gcp_billing_export.total_cost, name: Fivetran Data
              Pipelines - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost,
            id: Networking - gcp_billing_export.total_cost, name: Networking - GCP
              Billing Total Cost}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: month_over_month_rate, id: BigQuery
              - month_over_month_rate, name: BigQuery - Month over month rate}, {
            axisId: month_over_month_rate, id: Cloud Composer - month_over_month_rate,
            name: Cloud Composer - Month over month rate}, {axisId: month_over_month_rate,
            id: Cloud Dataflow - month_over_month_rate, name: Cloud Dataflow - Month
              over month rate}, {axisId: month_over_month_rate, id: Cloud Logging
              - month_over_month_rate, name: Cloud Logging - Month over month rate},
          {axisId: month_over_month_rate, id: Cloud Pub/Sub - month_over_month_rate,
            name: Cloud Pub/Sub - Month over month rate}, {axisId: month_over_month_rate,
            id: Cloud Run - month_over_month_rate, name: Cloud Run - Month over month
              rate}, {axisId: month_over_month_rate, id: Cloud SQL - month_over_month_rate,
            name: Cloud SQL - Month over month rate}, {axisId: month_over_month_rate,
            id: Cloud Storage - month_over_month_rate, name: Cloud Storage - Month
              over month rate}, {axisId: month_over_month_rate, id: Compute Engine
              - month_over_month_rate, name: Compute Engine - Month over month rate},
          {axisId: month_over_month_rate, id: Fivetran Data Pipelines - month_over_month_rate,
            name: Fivetran Data Pipelines - Month over month rate}, {axisId: month_over_month_rate,
            id: Networking - month_over_month_rate, name: Networking - Month over
              month rate}], showLabels: true, showValues: true, valueFormat: '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: [gcp_billing_export.total_cost]
    listen:
      Usage End Month: gcp_billing_export.usage_end_month
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 0
    col: 0
    width: 24
    height: 12
    tab_name: ''
  - title: Most expensive services by project last X months
    name: Most expensive services by project last X months
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_grid
    fields: [gcp_billing_export_service.description, gcp_billing_export.total_cost,
      gcp_billing_export_project.name, gcp_billing_export.usage_end_month]
    pivots: [gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export_service.description: BigQuery,Compute Engine,Networking,Cloud
        Storage,Cloud Logging,Cloud Run,Cloud Pub/Sub,Cloud SQL
      gcp_billing_export_project.name: ''
      gcp_billing_export.usage_end_month: 12 month ago for 12 month
    sorts: [gcp_billing_export.usage_end_month, gcp_billing_export_service.description,
      gcp_billing_export.total_cost desc 0]
    subtotals: [gcp_billing_export_service.description]
    limit: 500
    column_limit: 50
    total: true
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      gcp_billing_export.total_cost:
        is_active: true
    series_text_format:
      gcp_billing_export.total_cost: {}
    series_value_format:
      gcp_billing_export.total_cost:
        name: decimal_0
        decimals: '0'
        format_string: "#,##0"
        label: Decimal (0)
        label_prefix:
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Usage End Month: gcp_billing_export.usage_end_month
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 12
    col: 0
    width: 8
    height: 6
    tab_name: ''
  - title: Most expensive services last X months
    name: Most expensive services last X months
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_grid
    fields: [gcp_billing_export_service.description, gcp_billing_export.total_cost]
    filters:
      gcp_billing_export_service.description: "-Snowflake Data Cloud,-Support"
      gcp_billing_export_project.name: ''
      gcp_billing_export.usage_end_month: 12 month ago for 12 month
      gcp_billing_export.total_cost: ">0"
    sorts: [gcp_billing_export.total_cost desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      gcp_billing_export.total_cost:
        is_active: true
        value_display: true
    series_value_format:
      gcp_billing_export.total_cost:
        name: decimal_0
        decimals: '0'
        format_string: "#,##0"
        label: Decimal (0)
        label_prefix:
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Usage End Month: gcp_billing_export.usage_end_month
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 12
    col: 8
    width: 8
    height: 6
    tab_name: ''
  - title: 'Last monthly bill '
    name: 'Last monthly bill '
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_grid
    fields: [gcp_billing_export_service.description, gcp_billing_export.total_cost,
      gcp_billing_export.cost_before_credits, gcp_billing_export_project.name, gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export_service.description: GCP Billing Service,Compute Engine,BigQuery,Networking,Cloud
        Storage,Cloud Logging,Cloud Pub/Sub,Cloud Run,Fivetran Data Pipelines,Cloud
        Composer,Cloud SQL,Cloud Dataflow,cloud spanner
      gcp_billing_export_project.name: ''
    sorts: [gcp_billing_export_service.description desc, gcp_billing_export_project.name
        desc, gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    listen:
      Usage End Month: gcp_billing_export.usage_end_month
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 12
    col: 16
    width: 8
    height: 6
    tab_name: ''
  - title: GCP Cost MoM
    name: GCP Cost MoM
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.usage_end_month, gcp_billing_export.total_cost, gcp_billing_export_service.description]
    pivots: [gcp_billing_export_service.description]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export_service.description: GCP Billing Service,Compute Engine,BigQuery,Networking,Cloud
        Storage,Cloud Logging,Cloud Pub/Sub,Cloud Run,Fivetran Data Pipelines,Cloud
        Composer,Cloud SQL,Cloud Dataflow,cloud spanner
      gcp_billing_export_project.name: ''
      gcp_billing_export.usage_end_month: 12 month ago for 12 month
    sorts: [gcp_billing_export_service.description, gcp_billing_export.total_cost
        desc 2]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${gcp_billing_export.total_cost}/offset(${gcp_billing_export.total_cost},\
        \ -1) - 1"
      label: Month over month rate
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      table_calculation: month_over_month_rate
      _type_hint: number
      is_disabled: true
    query_timezone: America/Los_Angeles
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: gcp_billing_export.total_cost,
            id: BigQuery - gcp_billing_export.total_cost, name: BigQuery - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Composer
              - gcp_billing_export.total_cost, name: Cloud Composer - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Dataflow
              - gcp_billing_export.total_cost, name: Cloud Dataflow - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Logging
              - gcp_billing_export.total_cost, name: Cloud Logging - GCP Billing Total
              Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud Pub/Sub - gcp_billing_export.total_cost,
            name: Cloud Pub/Sub - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost,
            id: Cloud Run - gcp_billing_export.total_cost, name: Cloud Run - GCP Billing
              Total Cost}, {axisId: gcp_billing_export.total_cost, id: Cloud SQL -
              gcp_billing_export.total_cost, name: Cloud SQL - GCP Billing Total Cost},
          {axisId: gcp_billing_export.total_cost, id: Cloud Storage - gcp_billing_export.total_cost,
            name: Cloud Storage - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost,
            id: Compute Engine - gcp_billing_export.total_cost, name: Compute Engine
              - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost, id: Fivetran
              Data Pipelines - gcp_billing_export.total_cost, name: Fivetran Data
              Pipelines - GCP Billing Total Cost}, {axisId: gcp_billing_export.total_cost,
            id: Networking - gcp_billing_export.total_cost, name: Networking - GCP
              Billing Total Cost}], showLabels: true, showValues: true, unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: month_over_month_rate, id: BigQuery
              - month_over_month_rate, name: BigQuery - Month over month rate}, {
            axisId: month_over_month_rate, id: Cloud Composer - month_over_month_rate,
            name: Cloud Composer - Month over month rate}, {axisId: month_over_month_rate,
            id: Cloud Dataflow - month_over_month_rate, name: Cloud Dataflow - Month
              over month rate}, {axisId: month_over_month_rate, id: Cloud Logging
              - month_over_month_rate, name: Cloud Logging - Month over month rate},
          {axisId: month_over_month_rate, id: Cloud Pub/Sub - month_over_month_rate,
            name: Cloud Pub/Sub - Month over month rate}, {axisId: month_over_month_rate,
            id: Cloud Run - month_over_month_rate, name: Cloud Run - Month over month
              rate}, {axisId: month_over_month_rate, id: Cloud SQL - month_over_month_rate,
            name: Cloud SQL - Month over month rate}, {axisId: month_over_month_rate,
            id: Cloud Storage - month_over_month_rate, name: Cloud Storage - Month
              over month rate}, {axisId: month_over_month_rate, id: Compute Engine
              - month_over_month_rate, name: Compute Engine - Month over month rate},
          {axisId: month_over_month_rate, id: Fivetran Data Pipelines - month_over_month_rate,
            name: Fivetran Data Pipelines - Month over month rate}, {axisId: month_over_month_rate,
            id: Networking - month_over_month_rate, name: Networking - Month over
              month rate}], showLabels: true, showValues: true, valueFormat: '', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields:
    listen:
      Usage End Month: gcp_billing_export.usage_end_month
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 18
    col: 0
    width: 24
    height: 12
    tab_name: ''
  filters:
  - name: Project Name
    title: Project Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export_project.name
  - name: Usage End Month
    title: Usage End Month
    type: field_filter
    default_value: 12 month ago for 12 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export.usage_end_month
  - name: Service
    title: Service
    type: field_filter
    default_value: GCP Billing Service,Compute Engine,BigQuery,Networking,Cloud Storage,Cloud
      Logging,Cloud Pub/Sub,Cloud Run,Fivetran Data Pipelines,Cloud Composer,Cloud
      SQL,Cloud Dataflow,cloud spanner
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export_service.description
  - name: Reporting Currency
    title: Reporting Currency
    type: field_filter
    allow_multiple_values: false
    required: false
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export.reporting_currency
