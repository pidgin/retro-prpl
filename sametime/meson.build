feature = get_option('sametime')

summary({'Sametime': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

meanwhile_dep = dependency('meanwhile', version: ['>= 1.0.0', '< 2.0.0'],
                           required: false, disabler: true)

sametime_prpl = shared_library('sametime',
  'sametime.c',
  include_directories: toplevel_inc,
  dependencies: [meanwhile_dep, libpurple_dep, glib_dep],
  install: true,
  install_dir: libpurple_dep.get_variable('plugindir'),
)

subdir('pixmaps')
