# Points

`scans.points` is written by the API when a scan is saved.
`lab_attempts.delta` is 0 or -5.
Visible total is `max(0, scan sum + lab sum)`.
No SQL trigger recomputes it.
