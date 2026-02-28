return {
  {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    opts = {
      router = {
        browse = {
          ['^mindbox%.gitlab%.yandexcloud%.net'] = 'https://mindbox.gitlab.yandexcloud.net/'
            .. '{_A.ORG}/'
            .. '{_A.REPO}/blob/'
            .. '{_A.CURRENT_BRANCH}/'
            .. '{_A.FILE}'
            .. '#L{_A.LSTART}'
            .. "{(_A.LEND > _A.LSTART and ('-' .. _A.LEND) or '')}",
          ['^gitlab%.svodka%.space'] = 'https://gitlab.svodka.space/'
            .. '{_A.ORG}/'
            .. '{_A.REPO}/blob/'
            .. '{_A.CURRENT_BRANCH}/'
            .. '{_A.FILE}'
            .. '#L{_A.LSTART}'
            .. "{(_A.LEND > _A.LSTART and ('-' .. _A.LEND) or '')}",
        },
        current_branch = {
          ['^gitlab%.svodka%.space'] = 'https://gitlab.svodka.space/'
            .. '{_A.ORG}/'
            .. '{_A.REPO}/blob/'
            .. '{_A.CURRENT_BRANCH}/'
            .. '{_A.FILE}'
            .. '#L{_A.LSTART}'
            .. "{(_A.LEND > _A.LSTART and ('-' .. _A.LEND) or '')}",
        },
      },
    },
  },
}
