# Elasticsearch
## Data Node Sizing
### 64-bit JVM
Set `Xms` and `Xmx` to be the same and about 50% of the total physical memory allocated to node. Old GC stops threads from executing. To make sure GC runs fast enough it's good to keep the `Xmx` <= 30.5 GB.
### Node
* The number of nodes should be based on having 20 shards per GB of heap memory.
### Shards
* Use ILM.
* 50 GB per shard and if you notice shard relocation slowness consider making them smaller.