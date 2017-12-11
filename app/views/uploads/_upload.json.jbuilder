json.extract! upload, :id, :file, :ingested, :records_upserted, :error_message, :created_at, :updated_at
json.url upload_url(upload, format: :json)
