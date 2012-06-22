include sudo

sudo::conf { 'oracle':
  content => ['User_Alias ORADM = oracle',
              'Cmnd_Alias ADM = /bin/su',
              'ORADM   ALL = ADM',
              'oracle ALL = NOPASSWD: MP,RESCAN']
}
