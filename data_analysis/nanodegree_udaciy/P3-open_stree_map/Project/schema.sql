CREATE TABLE nodes (
    id INTEGER PRIMARY KEY NOT NULL,
    lat REAL,
    lon REAL,
    user TEXT,
    uid INTEGER,
    version INTEGER,
    changeset INTEGER,
    timestamp TEXT
);

CREATE TABLE nodes_tags (
    id INTEGER,
    key TEXT,
    value TEXT,
    type TEXT,
    FOREIGN KEY (id) REFERENCES nodes(id)
);

CREATE TABLE ways (
    id INTEGER PRIMARY KEY NOT NULL,
    user TEXT,
    uid INTEGER,
    version TEXT,
    changeset INTEGER,
    timestamp TEXT
);

CREATE TABLE ways_tags (
    id INTEGER NOT NULL,
    key TEXT NOT NULL,
    value TEXT NOT NULL,
    type TEXT,
    FOREIGN KEY (id) REFERENCES ways(id)
);

CREATE TABLE ways_nodes (
    id INTEGER NOT NULL,
    node_id INTEGER NOT NULL,
    position INTEGER NOT NULL,
    FOREIGN KEY (id) REFERENCES ways(id),
    FOREIGN KEY (node_id) REFERENCES nodes(id)
);

UPDATE nodes_tags SET key = 'postcode' WHERE value = '06097-100' AND key = 'city';

UPDATE nodes_tags SET value = 'São Paulo'
WHERE value IN 
('São Paulol','São Paulo, SP','São Paulo - SP','São Paulo',
'Sao paulo','Sao Paulo','Sao Paolo','São Pailo','Sâo Paulo',
'SÃO PAULO','São paulo','são paulo','são Paulo','sp','sao paulo')
AND key = 'city';

SELECT COUNT(DISTINCT value) FROM nodes_tags WHERE key = 'city';
-- 80