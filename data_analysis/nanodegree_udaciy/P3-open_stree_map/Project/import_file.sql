
sqllite3

.read schema.sql

.mode csv

## node
.import nodes.csv nodes

## ways
.import ways.csv ways

## nodes_tags
.import nodes_tags.csv nodes_tags

## ways_tags
.import ways_tags.csv ways_tags

## ways_nodes
.import ways_nodes.csv 


---

UPDATE nodes_tags
SET
	value = SUBSTR(value,1,5)||'-'||SUBSTR(value,6,8)
WHERE
	LENGTH(value) = 8
	AND key = 'postcode';