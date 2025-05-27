feature = get_option('toc')

summary({'TOC': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

toc_prpl = shared_library('toc',
  'toc.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
  install: true,
  install_dir: libpurple_dep.get_variable('plugindir'),
)

subdir('pixmaps')
