local ls = require('luasnip')

return {
  ls.s({
    trig = 'fori',
    name = 'forLoopSideEffectsOnly',
    dscr = 'Creates a for loop that is only for side-effect purposes.'
  }, {
    ls.t("Hello")
  })
}
