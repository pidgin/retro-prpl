zlib_dep = dependency('zlib')

libgadu_inc = include_directories('include')

libgadu = static_library('libgadu',
  'common.c',
  'dcc7.c',
  'dcc.c',
  'debug.c',
  'deflate.c',
  'encoding.c',
  'endian.c',
  'events.c',
  'handlers.c',
  'http.c',
  'libgadu.c',
  'message.c',
  'network.c',
  'obsolete.c',
  'packets.pb-c.c',
  'protobuf.c',
  'protobuf-c.c',
  'pubdir50.c',
  'pubdir.c',
  'resolver.c',
  'sha1.c',
  'tvbuff.c',
  'tvbuilder.c',
  include_directories: [libgadu_inc, toplevel_inc],
  dependencies: zlib_dep,
)

libgadu_dep = declare_dependency(
  include_directories: libgadu_inc,
  dependencies: zlib_dep,
  link_with: libgadu,
)
