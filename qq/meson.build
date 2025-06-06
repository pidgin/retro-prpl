feature = get_option('qq')

summary({'QQ': feature.allowed()}, bool_yn : true, section : 'Protocols')

if not feature.allowed()
  subdir_done()
endif

datadir = get_option('prefix') / get_option('datadir')

qq_prpl = shared_library('qq',
  'buddy_info.c',
  'buddy_list.c',
  'buddy_memo.c',
  'buddy_opt.c',
  'char_conv.c',
  'file_trans.c',
  'group.c',
  'group_im.c',
  'group_info.c',
  'group_internal.c',
  'group_join.c',
  'group_opt.c',
  'im.c',
  'packet_parse.c',
  'qq_base.c',
  'qq.c',
  'qq_crypt.c',
  'qq_define.c',
  'qq_network.c',
  'qq_process.c',
  'qq_trans.c',
  'send_file.c',
  'utils.c',
  # QQ_BUDDY_ICON_DIR is the path where a bunch of stock icons can be
  # placed for users to choose from when setting their buddy icon.  We
  # don't distribute those icons ourselves because of possible copyright
  # concerns, but distributions might want to put icons here.
  c_args: f'-DQQ_BUDDY_ICON_DIR="@datadir@/pixmaps/purple/buddy_icons/qq"',
  include_directories: toplevel_inc,
  dependencies: [libpurple_dep, glib_dep, ws2_32_dep],
  name_suffix: plugin_suffix,
  install: true,
  install_dir: plugin_dir,
)

subdir('pixmaps')
