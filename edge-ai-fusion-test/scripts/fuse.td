
transform.sequence failures(propagate) {
  ^bb0(%arg0: !transform.any_op):
    %d = transform.structured.match ops_in_range(60, 63) in %arg0
    transform.structured.fuse_into_dispatch_region %d
    transform.yield
}

