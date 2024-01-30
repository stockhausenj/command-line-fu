List databases.
```
\l
```

Switch databases.
```
\c <database>
```

Update search path.
```
SET search_path TO <schema>;
```

List tables.
```
\dt
```

Find long running queries.
```
SELECT
  pid,
  now() - pg_stat_activity.query_start AS duration,
  query,
  state
FROM pg_stat_activity
WHERE (now() - pg_stat_activity.query_start) > interval '2 hours';
```

Kill long running query.
```
SELECT pg_cancel_backend(__pid__);
```
