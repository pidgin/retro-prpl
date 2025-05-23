feature = get_option('napster')

summary({'Napster': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

novell_prpl = shared_library('napster',
  'napster.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep],
  install: true,
  install_dir: libpurple_dep.get_variable('plugindir'),
)

subdir('pixmaps')
