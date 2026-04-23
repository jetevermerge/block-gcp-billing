---
- dashboard: gcp_billing_forecast
  title: GCP Billing Forecast
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: vONmQaD3FBxSHF1Qx3tT6S
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Monthly Cost Forecast
    name: Monthly Cost Forecast
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_start_month]
    fill_fields: [gcp_billing_export.usage_start_month]
    filters:
      gcp_billing_export.usage_start_month: 12 month ago for 12 month
    sorts: [gcp_billing_export.usage_start_month desc]
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    analysis_config:
      forecasting:
      - field_name: gcp_billing_export.total_cost
        forecast_n: 6
        forecast_interval: month
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
            id: gcp_billing_export.total_cost, name: Total Cost}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    trend_lines: []
    defaults_version: 1
    hidden_pivots: {}
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    note_state: collapsed
    note_display: hover
    note_text: "This chart shows the prediction of costs for the upcoming 6 months\
      \ on the basis of data from previous COMPLETE months.\n\nAll the filters above\
      \ are applicable for this visualization. The Usage Start Months shows the number\
      \ of months used for the forecast.\n\n\nThis chart - is a forecast created by\
      \ Looker AutoRegressive Integrated Moving Average (ARIMA). "
    listen:
      Project Name: gcp_billing_export_project.name
      Service: gcp_billing_export_service.description
      Usage Start Month (Only for monthly forecast): gcp_billing_export.usage_start_month
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 4
    col: 0
    width: 15
    height: 12
    tab_name: ''
  - title: Forecasted cost for a current month
    name: Forecasted cost for a current month
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: single_value
    fields: [gcp_billing_export.usage_start_date, gcp_billing_export.total_cost]
    fill_fields: [gcp_billing_export.usage_start_date]
    filters:
      gcp_billing_export.usage_start_date: 1 months
      gcp_billing_export_project.name: ''
      gcp_billing_export_service.description: ''
    sorts: [gcp_billing_export.usage_start_date]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: x_bar
      label: x_bar
      expression: mean(${gcp_billing_export.total_cost})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: cov
      label: cov
      expression: sum((${day}-${y_bar})*(${gcp_billing_export.total_cost}-${x_bar}))
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: var
      label: var
      expression: sum((${gcp_billing_export.total_cost}-${x_bar})*(${gcp_billing_export.total_cost}-${x_bar}))
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: beta
      label: beta
      expression: "${cov}/${var}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: alpha
      label: alpha
      expression: "${y_bar}-${beta}*${x_bar}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: predicted_cost
      label: Predicted Cost
      expression: "${alpha} + ${beta}*${day}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: total_cost
      label: Total cost
      expression: sum(${gcp_billing_export.total_cost})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: actual_cumulative_cost
      label: Actual Cumulative Cost
      expression: running_total(${gcp_billing_export.total_cost})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: predicted_cumulative_cost
      label: Predicted Cumulative Cost
      expression: running_total(if(extract_days(${gcp_billing_export.usage_start_date})>
        extract_days(now()),${predicted_cost},${gcp_billing_export.total_cost}))
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: day
      label: Day
      expression: extract_days(${gcp_billing_export.usage_start_date})
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - table_calculation: y_bar
      label: y_bar
      expression: mean(${day})
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - category: table_calculation
      expression: max(${predicted_cumulative_cost})
      label: Total Predicted Costs
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: total_predicted_costs
      _type_hint: number
    custom_color_enabled: false
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: forestgreen
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    hidden_fields: [day, y_bar, x_bar, cov, var, beta, alpha, gcp_billing_export.total_cost,
      total_cost, predicted_cost, predicted_cumulative_cost, actual_cumulative_cost]
    hidden_series: [predicted_cost]
    single_value_title: Predicted Total Monthly Cost
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: "This chart shows the Predicted Cost by the end of a current month.\n\
      \nPlease, notice that the predicted numbers for this chart will be different\
      \ from Monthly cost forecast because it uses Regression Formula and only current\
      \ months data.\n\nOnly Project Name and Service are applicable for this chart. "
    listen:
      Project Name: gcp_billing_export_project.name
      Service: gcp_billing_export_service.description
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 4
    col: 15
    width: 9
    height: 4
    tab_name: ''
  - title: Predicted Cumulative Cost for a current month
    name: Predicted Cumulative Cost for a current month
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.usage_start_date, gcp_billing_export.total_cost]
    fill_fields: [gcp_billing_export.usage_start_date]
    filters:
      gcp_billing_export.usage_start_date: 1 months
      gcp_billing_export_project.name: ''
      gcp_billing_export_service.description: ''
    sorts: [gcp_billing_export.usage_start_date]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: x_bar
      label: x_bar
      expression: mean(${gcp_billing_export.total_cost})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: cov
      label: cov
      expression: sum((${day}-${y_bar})*(${gcp_billing_export.total_cost}-${x_bar}))
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: var
      label: var
      expression: sum((${gcp_billing_export.total_cost}-${x_bar})*(${gcp_billing_export.total_cost}-${x_bar}))
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: beta
      label: beta
      expression: "${cov}/${var}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: alpha
      label: alpha
      expression: "${y_bar}-${beta}*${x_bar}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: predicted_cost
      label: Predicted Cost
      expression: "${alpha} + ${beta}*${day}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: total_cost
      label: Total cost
      expression: sum(${gcp_billing_export.total_cost})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: actual_cumulative_cost
      label: Actual Cumulative Cost
      expression: running_total(${gcp_billing_export.total_cost})
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - category: table_calculation
      expression: running_total(if(extract_days(${gcp_billing_export.usage_start_date})>
        extract_days(now()),${predicted_cost},${gcp_billing_export.total_cost}))
      label: Predicted Cumulative Cost
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: predicted_cumulative_cost
      _type_hint: number
    - table_calculation: day
      label: Day
      expression: extract_days(${gcp_billing_export.usage_start_date})
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - table_calculation: y_bar
      label: y_bar
      expression: mean(${day})
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: number
    - table_calculation: total_predicted_costs
      label: Total Predicted Costs
      expression: max(${predicted_cumulative_cost})
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      _type_hint: number
      is_disabled: true
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: predicted_cumulative_cost,
            id: predicted_cumulative_cost, name: Predicted Cumulative Cost}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    hidden_series: [predicted_cost]
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    hidden_fields: [day, y_bar, x_bar, cov, var, beta, alpha, gcp_billing_export.total_cost,
      total_cost, predicted_cost, actual_cumulative_cost]
    single_value_title: Predicted Total Monthly Cost
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: "This chart shows the Predicted Cost trend during the current month.\n\
      \nPlease, notice that the predicted numbers for this chart will be different\
      \ from Monthly cost forecast because it uses Regression Formula and only current\
      \ months data.\n\nOnly Project Name and Service are applicable for this chart. "
    listen:
      Project Name: gcp_billing_export_project.name
      Service: gcp_billing_export_service.description
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 8
    col: 15
    width: 9
    height: 8
    tab_name: ''
  - name: ''
    type: text
    title_text: ''
    body_text: '[{"type":"h1","children":[{"text":"GCP Billing Forecast","bold":true}],"align":"center"},{"type":"p","children":[{"text":""}],"id":"pfahz"},{"type":"p","id":"wuro9","children":[{"text":"This
      dashboard contains cost forecasts for GCP. \nCan be used as a forecasts for
      the particular GCP Projects, GCP services or for the whole organization."}],"align":"center"},{"type":"p","id":"el0z1","align":"center","children":[{"text":"All
      the forecasts are using data on previous dates so that they can''t be 100% accurate."}]},{"type":"p","id":"bu9rt","align":"center","children":[{"text":"Please,
      also read additional descriptions in the icon hover near the names of charts."}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 4
    tab_name: ''
  filters:
  - name: Usage Start Month (Only for monthly forecast)
    title: Usage Start Month (Only for monthly forecast)
    type: field_filter
    default_value: 12 month ago for 12 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export.usage_start_month
  - name: Project Name
    title: Project Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export_project.name
  - name: Service
    title: Service
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
