ActiveRecordDoctor.configure do
  # Global settings affect all detectors.
  global :ignore_tables, [
    # Ignore internal Rails-related tables.
    'ar_internal_metadata',
    'schema_migrations',
    'active_storage_blobs',
    'active_storage_attachments',
    'action_text_rich_texts',

    # Add project-specific tables here.
    'solid_cable_messages',
    'solid_cache_entries',
    /^solid_queue_/
  ]
  global :ignore_indexes, [
    /^index_taggings_on_/
  ]

  # Detector-specific settings affect only one specific detector.
  detector :undefined_table_references,
           ignore_models: [
             'ActionMailbox::InboundEmail',
             'SolidCable::Message',
             'SolidCache::Entry',
             /^ActionText/,
             /^ActiveStorage/,
             /^SolidQueue/
           ]

  detector :missing_unique_indexes,
           ignore_models: [
             /^SolidQueue/
           ]
end
