---
- dashboard: monthly_gcp_billing_alerting
  title: Monthly GCP Billing Alerting
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: PENlGy9UGc6RRejhvTXdEY
  layout: newspaper
  tabs:
  - name: ''
    label: ''
  elements:
  - title: Total Cost
    name: Total Cost
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
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
    show_null_points: false
    interpolation: linear
    y_axes: [{label: Total Cost, orientation: left, series: [{axisId: gcp_billing_export.total_cost,
            id: gcp_billing_export.total_cost, name: Total Cost}, {axisId: moving_median,
            id: moving_median, name: Moving Median}, {axisId: upper_bound, id: upper_bound,
            name: Upper Bound}, {axisId: outlier_high, id: outlier_high, name: Outlier
              High}, {axisId: allert_high, id: allert_high, name: Allert High}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_labels:
      gcp_billing_export.total_cost: Total Cost
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, allert_high, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    title_hidden: true
    listen:
      Service (ONLY for Total Costs): gcp_billing_export_service.description
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 4
    col: 0
    width: 24
    height: 9
    tab_name: ''
  - title: Compute Engine
    name: Compute Engine
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Compute Engine
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Alert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: alert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, allert_high, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 17
    col: 0
    width: 8
    height: 6
    tab_name: ''
  - title: Support
    name: Support
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Support
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, allert_high, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 17
    col: 8
    width: 8
    height: 6
    tab_name: ''
  - title: Cloud Storage
    name: Cloud Storage
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Cloud Storage
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Allert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: allert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 17
    col: 16
    width: 8
    height: 6
    tab_name: ''
  - title: BiqQuery
    name: BiqQuery
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: BigQuery
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Allert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: allert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 23
    col: 0
    width: 8
    height: 6
    tab_name: ''
  - title: Networking
    name: Networking
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Networking
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Alert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: alert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, allert_high, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 23
    col: 8
    width: 8
    height: 6
    tab_name: ''
  - title: Cloud Run
    name: Cloud Run
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Cloud Run
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Allert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: allert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 23
    col: 16
    width: 8
    height: 6
    tab_name: ''
  - title: Cloud SQL
    name: Cloud SQL
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Cloud SQL
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Allert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: allert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 29
    col: 0
    width: 8
    height: 6
    tab_name: ''
  - title: Cloud Logging
    name: Cloud Logging
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Cloud Logging
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Allert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: allert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 29
    col: 8
    width: 8
    height: 6
    tab_name: ''
  - title: Cloud Composer
    name: Cloud Composer
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    type: looker_line
    fields: [gcp_billing_export.total_cost, gcp_billing_export.usage_end_month]
    fill_fields: [gcp_billing_export.usage_end_month]
    filters:
      gcp_billing_export.usage_end_month: 14 month ago for 14 month
      gcp_billing_export_service.description: Cloud Composer
    sorts: [gcp_billing_export.usage_end_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '14'
      label: Months for moving Median
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: months_for_moving_median
      _type_hint: number
    - category: table_calculation
      expression: '2'
      label: IQR Multiplier
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: iqr_multiplier
      _type_hint: number
    - category: table_calculation
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        90, yes, no)
      label: Show The last 90 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_the_last_90_months
      _type_hint: yesno
    - category: table_calculation
      expression: median(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}))
      label: Moving Median
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_median
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.25)
      label: Moving Q1
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q1
      _type_hint: number
    - category: table_calculation
      expression: percentile(offset_list(${gcp_billing_export.total_cost}, 0, ${months_for_moving_median}),
        0.75)
      label: Moving Q3
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_q3
      _type_hint: number
    - category: table_calculation
      expression: "${moving_q3} - ${moving_q1}"
      label: Moving IQR
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: moving_iqr
      _type_hint: number
    - category: table_calculation
      expression: "${moving_median} + (${iqr_multiplier} * ${moving_iqr})"
      label: Upper Bound
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: upper_bound
      _type_hint: number
    - category: table_calculation
      description: Will show this value if the Metric we checking would be greater
        than Upper Bound
      expression: |-
        if (
          ${gcp_billing_export.total_cost} > ${upper_bound},
          ${gcp_billing_export.total_cost},
          null
        )
      label: Outlier High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: outlier_high
      _type_hint: number
    - category: table_calculation
      description: Triggers if value is greater than Upper Bound
      expression: if(diff_months(${gcp_billing_export.usage_end_month}, now()) <=
        3 AND NOT is_null(${outlier_high}), ${outlier_high}, 0)
      label: Allert High
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: allert_high
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
    show_null_points: false
    interpolation: linear
    x_axis_zoom: true
    y_axis_zoom: true
    series_types:
      outlier_high: scatter
      upper_bound: area
    series_colors:
      upper_bound: "#d2cbd4"
      outlier_high: "#fa0820"
      gcp_billing_export.total_cost: "#003d6e"
      moving_median: "#5b5e63"
    series_point_styles:
      outlier_high: diamond
    hidden_fields: [months_for_moving_median, iqr_multiplier, show_the_last_90_months,
      moving_q1, moving_q3, moving_iqr, moving_median]
    defaults_version: 1
    hidden_pivots: {}
    listen:
      Project Name: gcp_billing_export_project.name
      Usage End Date: gcp_billing_export.usage_end_date
      Reporting Currency: gcp_billing_export.reporting_currency
    row: 29
    col: 16
    width: 8
    height: 6
    tab_name: ''
  - name: ''
    type: text
    title_text: ''
    body_text: '[{"type":"h1","children":[{"text":"TOTAL COSTS","bold":true}],"align":"center"},{"type":"p","children":[{"text":""}],"id":"j79zy"},{"type":"p","id":"2skne","children":[{"text":"Alerting
      chart on total monthly GCP costs with historical data for the last 14 months"}],"align":"center"},{"type":"p","id":"sddq7","align":"center","children":[{"text":"Use
      the filter to see the data for particular service or particular project"}]},{"type":"p","id":"j871r","align":"center","children":[{"text":"Alerts
      are sent to #bi-alerts-info Slack channel every month"}]}]'
    rich_content_json: '{"format":"slate"}'
    row: 0
    col: 0
    width: 24
    height: 4
    tab_name: ''
  - name: " (Copy)"
    type: text
    title_text: " (Copy)"
    body_text: '[{"children":[{"text":"Top most expensive services"}],"type":"h1","align":"center"},{"type":"p","children":[{"text":""}],"id":"er3ny"},{"type":"p","id":"j871r","align":"center","children":[{"text":"Alerting
      chart for 9 most expensive services"}]},{"type":"p","id":"ajnu0","align":"center","children":[{"text":"Can
      be filtered by a project"}]},{"type":"p","align":"center","children":[{"text":"Alerts
      are sent to #bi-alerts-info Slack channel every month"}],"id":"wesbs"}]'
    rich_content_json: '{"format":"slate"}'
    row: 13
    col: 0
    width: 24
    height: 4
    tab_name: ''
  filters:
  - name: Service (ONLY for Total Costs)
    title: Service (ONLY for Total Costs)
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
    field: gcp_billing_export_service.description
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
  - name: Usage End Date
    title: Usage End Date
    type: field_filter
    default_value: 14 month ago for 14 month
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export.usage_end_date
  - name: Reporting Currency
    title: Reporting Currency
    type: field_filter
    allow_multiple_values: false
    required: false
    ui_config:
      type: button_group
      display: inline
      options: []
    model: block_gcp_billing_v2
    explore: gcp_billing_export
    listens_to_filters: []
    field: gcp_billing_export.reporting_currency
