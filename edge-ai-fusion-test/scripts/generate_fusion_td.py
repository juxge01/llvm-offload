# generate_fusion_td.py  (fixed)
import json, sys, textwrap

cand = json.load(open(sys.argv[1]))[0]   # top-1 candidate
ops  = cand["ops"]
s, e = ops[0], ops[-1]                   # <-- 핵심 수정

print(textwrap.dedent(f"""
  transform.sequence failures(propagate) {{
    ^bb0(%arg0: !transform.any_op):
      %d = transform.structured.match ops_in_range({s}, {e}) in %arg0
      transform.structured.fuse_into_dispatch_region %d
      transform.yield
  }}
"""))

