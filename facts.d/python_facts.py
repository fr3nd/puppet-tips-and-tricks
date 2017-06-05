#!/usr/bin/env python

data = {"pykey1": "pyvalue1", "key2": "value2", "pyfoo": "bar"}

for k in data:
    print "%s=%s" % (k, data[k])
