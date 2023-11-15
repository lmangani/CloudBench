#!/usr/bin/env python3

import chdb
import timeit
import sys

from chdb import session as chs
db = chs.Session()


query = sys.stdin.read()
print(query)

for try_num in range(3):
    start = timeit.default_timer()
    db.query(query, "Null")
    end = timeit.default_timer()
    print(end - start)
