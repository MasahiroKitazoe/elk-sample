INDEX_NAME :=
LOG_FILE_PATH := ./logs/apigateway

##############################
# Index関連コマンド
##############################
create-index:
	curl -X PUT --header "Content-Type: application/json" 'http://localhost:9200/iot_pf_logs'

delete-index:
	curl -XDELETE 'http://localhost:9200/iot_pf_logs'

add-field-to-index:
	curl -X PUT --header "Content-Type: application/json" 'http://localhost:9200/iot_pf_logs/_mapping' -d '{"properties": {"log": {"properties": {"status": {"type": "integer"}}}}}'

##############################
# Document関連コマンド
##############################
delete-all-doc:
	curl -XPOST --header "Content-Type: application/json" 'http://localhost:9200/iot_pf_logs/_delete_by_query' -d '{"query" : { "match_all" : {}}}'

build-bulk-req-body:
	(cd scripts/build_bulk_req_body && python main.py)

bulk-insert: build-bulk-req-body
	curl -XPOST --header "Content-Type: application/json" 'http://localhost:9200/iot_pf_logs/_bulk' --data-binary @bulk.json
