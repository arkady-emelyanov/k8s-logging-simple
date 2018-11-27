NAMESPACE ?= logging


.PHONY: all
all: elasticsearch kibana curator fluentbit

.PHONY: elasticsearch
elasticsearch:
	helm upgrade --recreate-pods --install --debug --namespace=$(NAMESPACE) elasticsearch \
		--wait \
		--timeout=120 \
		./elasticsearch

.PHONY: fluentbit
fluentbit:
	helm upgrade --recreate-pods --install --debug --namespace=logging fluentbit \
		--set config.elasticsearch.host=elasticsearch.$(NAMESPACE) \
		--set config.elasticsearch.port=9200 \
		--wait \
		--timeout=120 \
		./fluentbit

.PHONY: curator
curator:
	helm upgrade --recreate-pods --install --debug --namespace=$(NAMESPACE) curator \
		--set config.elasticsearch.host=elasticsearch.$(NAMESPACE) \
		--set config.elasticsearch.port=9200 \
		./curator

.PHONY: kibana
kibana:
	helm upgrade --recreate-pods --install --debug --namespace=$(NAMESPACE) kibana \
		--set config.elasticsearch.host=elasticsearch.$(NAMESPACE) \
		--set config.elasticsearch.port=9200 \
		--wait \
		--timeout=120 \
		./kibana
