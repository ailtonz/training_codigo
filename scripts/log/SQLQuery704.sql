SELECT 
    SchemaName = s.name
    ,TableName = t.name
FROM
    sys.schemas AS s
    INNER JOIN sys.tables AS t ON s.schema_id = t.schema_id
    INNER JOIN sys.columns AS c ON t.object_id = c.object_id
    INNER JOIN sys.identity_columns AS ic on c.object_id = ic.object_id AND c.column_id = ic.column_id
GROUP BY
    s.name
    ,t.name
ORDER BY
    s.name
    ,t.name;
