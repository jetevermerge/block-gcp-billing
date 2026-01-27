project_name: "block-gcp-billing"

################ Constants ################

constant: CONNECTION_NAME {
  value: "gcp_logging"
  export: override_optional
}

constant: PROJECT_ID {
  value: "project-20122b5a-1dba-40c9-831"
  export: override_optional
}

constant: SCHEMA_NAME {
  value: "gcp_billing_noc_reporting"
  export: override_optional
}

# Looks like it should just be a single table, so no _* notation
constant: BILLING_EXPORT_TABLE_NAME {
  value: "gcp_billing_export_v1_011327_2E97FB_98468B"
  export: override_optional
}
