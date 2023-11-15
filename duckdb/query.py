#!/usr/bin/env python3

import duckdb
import timeit
import psutil
import sys

query = sys.stdin.read()
print(query)

for try_num in range(3):
    start = timeit.default_timer()
    results = duckdb.sql(query).fetchall()
    end = timeit.default_timer()
    print(end - start)
