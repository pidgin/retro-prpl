feature = get_option('gadu-gadu')

summary({'Gadu-Gadu': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

if host_machine.endian() == 'big'
  cfg.set('WORDS_BIGENDIAN', true)
endif

libgadu_dep = dependency('libgadu', version: '>= 1.12.0', required: false)
if not libgadu_dep.found()
  subdir('lib')
endif

gg_prpl = shared_library('gg',
  'buddylist.c',
  'confer.c',
  'gg.c',
  'gg-utils.c',
  'search.c',
  include_directories: toplevel_inc,
  dependencies: [libgadu_dep, libpurple_dep, glib_dep],
  install_dir: libpurple_dep.get_variable('plugindir'),
)
