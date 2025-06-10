feature = get_option('msn')

summary({'MSN': feature.allowed()}, bool_yn : true, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

msn_prpl = shared_library('retromsn',
  'cmdproc.c',
  'command.c',
  'contact.c',
  'directconn.c',
  'error.c',
  'group.c',
  'history.c',
  'httpconn.c',
  'msg.c',
  'msn.c',
  'msnutils.c',
  'nexus.c',
  'notification.c',
  'object.c',
  'oim.c',
  'p2p.c',
  'page.c',
  'sbconn.c',
  'servconn.c',
  'session.c',
  'slp.c',
  'slpcall.c',
  'slplink.c',
  'slpmsg.c',
  'slpmsg_part.c',
  'soap.c',
  'state.c',
  'switchboard.c',
  'table.c',
  'tlv.c',
  'transaction.c',
  'user.c',
  'userlist.c',
  'xfer.c',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
  name_suffix: plugin_suffix,
  install: true,
  install_dir: plugin_dir,
)

subdir('pixmaps')
