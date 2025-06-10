feature = get_option('sametime')

meanwhile_dep = dependency('meanwhile', version: ['>= 1.0.0', '< 2.0.0'],
                           required: feature)

summary({'Sametime': meanwhile_dep.found()}, bool_yn : true, section : 'Protocols')

if not meanwhile_dep.found()
  subdir_done()
endif

sametime_prpl = shared_library('retrosametime',
  'sametime.c',
  include_directories: toplevel_inc,
  dependencies: [meanwhile_dep, libpurple_dep, glib_dep, ws2_32_dep],
  name_suffix: plugin_suffix,
  install: true,
  install_dir: plugin_dir,
)

subdir('pixmaps')
