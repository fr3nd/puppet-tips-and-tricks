#!/usr/bin/env python

data = {"pykey1": "pyvalue1", "key2": "value2", "py_fact": "hello from python"}

for k in data:
    print "%s=%s" % (k, data[k])
