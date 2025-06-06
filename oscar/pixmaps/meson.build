install_subdir('emblems', install_dir: pixmap_dir)

foreach prpl: ['aim', 'icq']
  if get_option(prpl).allowed()
    foreach size : [16, 22, 48]
      install_data(f'protocols/@size@/@prpl@.png', install_dir: pixmap_dir,
                   preserve_path: true)
    endforeach
  endif
endforeach
