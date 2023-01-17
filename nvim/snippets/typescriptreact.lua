local ls = require('luasnip')
local rep = require('luasnip.extras').rep

return {
  ls.s({
    trig = 'rfcp',
    name = 'reactFCWithPropIface',
    dscr = 'Creates a react functional component with a prop interface.'
  }, {
    ls.t({
      'import React from "react";',
      '',
      'interface ',
    }),
    ls.d(1, function(_, snip)
      return ls.sn(nil, {
        ls.i(1, snip.env.TM_FILENAME_BASE)
      })
    end),
    ls.t({
      'Props {',
      '}',
      '',
      'function '
    }),
    rep(1),
    ls.t('('),
    ls.c(2, {
      ls.t('props: '),
      ls.t('{}: ')
    }),
    rep(1),
    ls.t('Props'),
    ls.t({
      ') {',
      '  return (',
      '    <div>',
    }),
    ls.i(3),
    ls.t({
      '</div>',
      '  );',
      '}',
      '',
      'export default '
    }),
    rep(1),
    ls.t(';')
  })
}
