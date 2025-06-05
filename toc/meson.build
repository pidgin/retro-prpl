feature = get_option('toc')

summary({'TOC': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

toc_prpl = shared_library('toc',
  'toc.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
  name_suffix: plugin_suffix,
  install: true,
  install_dir: plugin_dir,
)

subdir('pixmaps')
