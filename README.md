# Simple K8S log collection

* FluentBit v0.13
* Kibana v6.4.3
* ElasticSearch v6.4.3
* Curator v5.5.4

After deploy, stdout from all Kubernetes pods will end up in ElasticSearch
index `logstast-%Y.%m.%d`.

> Don't forget to create Kibana "Index Mapping", this example didn't provide any 

Following index fields will be available:

* `namespace` - pod namespace
* `deployment` - deployment, pod belongs to 
* `pod` - pod name
* `message` - log line

Following ingress-controller entry will be created:
* `kibana.example.com`

While fluentbit configuration is stable and has been used in production
for a while, elasticsearch, kibana and curator deployments provided as an example, 
just to demonstrate how things should be composed together.

Additional note: having Logstash in front of ElasticSearch, will allow
perform more granular routing, e.g. different indexes for a namespaces, deployments
or even a pods.

Sample helm commands are provided in [Makefile](./Makefile)

## License

[WTFPL](http://www.wtfpl.net/)
