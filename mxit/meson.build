feature = get_option('mxit')

summary({'MXit': feature}, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

mxit_prpl = shared_library('mxit',
  'actions.c',
  'aes.c',
  'chunk.c',
  'cipher.c',
  'filexfer.c',
  'formcmds.c',
  'http.c',
  'login.c',
  'markup.c',
  'multimx.c',
  'mxit.c',
  'profile.c',
  'protocol.c',
  'roster.c',
  'splashscreen.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep],
  install: true,
  install_dir: libpurple_dep.get_variable('plugindir'),
)

subdir('pixmaps')
