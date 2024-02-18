local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
-- local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta

local function selected_text(_env, snip)
  return snip.env.TM_SELECTED_TEXT or {}
end

local function centered_input(_env, _snip, _old_state, max_len)
  return sn(nil, {
    f(function(args)
      return (" "):rep(math.floor((max_len - string.len(args[1][1])) / 2))
    end, { 1 }, {}),
    i(1, "Header"),
    f(function(args)
      return (" "):rep(math.ceil((max_len - string.len(args[1][1])) / 2))
    end, { 1 }, {})
  })
end

local function fancy_comment(_env, snip)
  local len = tonumber(snip.captures[1])
  len = len >= 13 and len or 13
  local h_border = '(' .. string.rep("*", len - 2) .. ')'
  local empty_line = '(*' .. string.rep(" ", len - 4) .. '*)'

  return sn(nil, {
    t({ h_border, "" }),
    t({ empty_line, "" }),
    t('(* '), d(1, centered_input, {}, { user_args = { len - 6 } }), t(' *)'),
    t({ "", empty_line, "" }),
    t({ '(* content' .. string.rep(' ', len - 12) .. '*)', "" }),
    t({ empty_line, "" }),
    t(h_border)
  })
end

-- TODO: Remove redundant i(0) calls.
return {
  s({
    trig = "for",
    name = "forLoop",
    dscr = "Imperative for loop with a variable [i].",
  }, {
    t("for "), i(1, "i"), t(" = "), i(2, "0"), t(" to "), i(3, "n"),
    t({ " do", "  " }), i(0), t({ "", "done" })
  }),
  s({
    trig = "while",
    name = "whileLoop",
    dscr = "Imperative while loop."
  }, {
    t("while "), i(1, "condition"),
    t({ " do", "  " }), i(0), t({ "", "done" })
  }),
  s({
    trig = "match",
    name = "matchWith",
    dscr = "Pattern-matching block."
  }, {
    t("match "), i(1, "scrutinee"), t({ " with", "| " }),
    i(2, "_"), t(" -> ")
  }),
  s({
    trig = "matcho",
    name = "matchWithOption",
    dscr = "Pattern-matching block for option types."
  }, {
    t("match "), i(1, "option"), t({ " with", "" }),
    t("| Some "), i(2, "_"), t(" -> "), i(3, "some branch"),
    t({ "", "| None -> " }), i(0, "none branch")
  }),
  s({
    trig = "matchr",
    name = "matchWithResult",
    dscr = "Pattern-matching block for result types."
  }, {
    t("match "), i(1, "result"), t({ " with", "" }),
    t("| Ok "), i(2, "_"), t(" -> "), i(3, "error branch"),
    t({ "", "| Error " }), i(4, "_"), t(" -> "), i(0, "error branch"),
  }),
  s({
    trig = "try",
    name = "tryWith",
    dscr = "Exception handling block."
  }, {
    t({ "try", "  " }),
    f(selected_text),
    i(1),
    t({ "", "with", "| " }),
    i(2, "_"), t(" -> "), i(0)
  }),
  s({
    trig = "beg",
    name = "beginBlock",
    dscr = "Begin block to wrap expressions."
  }, {
    t({ "begin", "  " }),
    f(selected_text, {}),
    i(0),
    t({ "", "end" })
  }),
  s({
    trig = "fun",
    name = "lambda",
    descr = "Anonymous lambda function."
  }, {
    t("fun "), i(1, "x"), t(" -> "), i(0)
  }),
  s({
    trig = "func",
    name = "function",
    descr = "Pattern matched lambda function."
  }, {
    t("function | "), i(1, "_"), t(" -> "), i(0)
  }),
  s({
    trig = "and",
    name = "and",
    descr = "Mutually recursive AND definition."
  }, {
    t("and "), i(1, "identifier"), t(" = "), f(selected_text, {}), i(0)
  }),
  s({
    trig = "let",
    name = "let",
    descr = "Top level binding."
  }, {
    t("let "), i(1, "identifier"), t(" = "), f(selected_text, {}), i(0)
  }),
  s({
    trig = "leti",
    name = "letIn",
    descr = "let..in local binding."
  }, {
    t("let "), i(1, "identifier"), t(" = "), i(2, "value"),
    t({ " in", "" })
  }),
  s({
    trig = "letf",
    name = "letFunction",
    descr = "Named pattern matched function."
  }, {
    t("let "), i(1, "name"), t({ " = function", "" }),
    t("  | "), i(2, "_"), t(" -> "), i(0),
    t({ "", ";;" })
  }),
  s({
    trig = "letr",
    name = "letRefIn",
    descr = "Local binding of a reference type."
  }, {
    t("let "), i(1, "name"), t(" = ref "), i(2),
    t({ " in", "" })
  }),
  s({
    trig = "lett",
    name = "typedLet",
    descr = "Type-annotated top level binding."
  }, {
    t("let "), i(1, "name"), t(" : "), i(2, "type"), t(" = ")
  }),
  s({
    trig = "leto",
    name = "letOpen",
    descr = "Local module scoping."
  }, {
    t("let open "), i(1, "M"), t({ " in", "" })
  }),
  s({
    trig = "pat",
    name = "pattern",
    descr = "Pattern-matching branch."
  }, {
    t("| "), i(1, "_"), t(" -> ")
  }),
  s({
    trig = "type",
    name = "typeDef",
    descr = "Type definition and aliasing."
  }, {
    t("type "), i(1, "identifier"), t(" = "), i(0)
  }),
  s({
    trig = "typer",
    name = "recordType",
    descr = "Record type definition."
  }, {
    t("type "), i(1, "identifier"), t({ " =", "  { " }),
    i(0), t({ "", "  }" })
  }),
  s({
    trig = "val",
    name = "val",
    descr = "value signature"
  }, {
    t("val "), i(1, "identifier"), t(" : "), i(0)
  }),
  s({
    trig = "sig",
    name = "sigBlock",
    descr = "Module signature block."
  }, {
    t({ "sig", "  " }), i(1), t({ "", "end" }), i(0)
  }),
  s({
    trig = "struct",
    name = "structBlock",
    descr = "Module struct block."
  }, {
    t({ "struct", "  " }), i(1), t({ "", "end" }), i(0)
  }),
  s({
    trig = "modtype",
    name = "moduleType",
    descr = "Module type definition."
  }, {
    t("module type "), i(1, "M"), t({ " = sig", "  " }),
    i(0), t({ "", "end" })
  }),
  s({
    trig = "module",
    name = "module",
    descr = "Full module definition."
  }, {
    t("module "), i(1, "M"), t(" "),
    c(2, {
      sn(nil, { t(": "), i(1, "T"), t(" ") }),
      sn(nil, { t({ ": sig", "  " }), i(1), t({ "", "end " }) }),
      t("")
    }),
    t({ "= struct", "  " }), i(0), t({ "", "end" })
  }),
  s({
    trig = "functor",
    name = "functor",
    descr = "Full functor definition."
  }, {
    t("module "), i(1, "F"), t(" ("),
    i(2, "M"), t(" : "), i(3, "MT"),
    t(") : "), i(4, "FT"), t({ " = struct", "" }),
    t("  "), i(0), t({ "", "end" })
  }),
  s({
    trig = "mut",
    name = "mutField",
    descr = "Mutable record field"
  }, {
    t("mutable "), i(1, "field"), t(" : "), i(0, "type")
  }),
  s({
    trig = "odoc",
    name = "odoc",
    descr = "ODoc comment."
  }, {
    t("(** ["), i(1, "identifier"), t("] "), i(0, "is the..."), t(" *)")
  }),
  s({
    trig = "rec",
    name = "recursiveFun",
    descr = "Recursive function definition."
  }, {
    t("let rec "), i(1, "name"), t(" "), i(2, "params"),
    t({ " =", "  " }), i(0), t({ "", ";;" })
  }),
  s({
    trig = "rectco",
    name = "recursiveTCOFun",
    descr = "Tail-call optimized recursive function."
  }, {
    t("let "), i(1, "name"), t(" "), i(2, "params"),
    t({ " =", "  let rec aux " }), i(3, "~acc"),
    t({ " =", "    " }), i(0),
    t({ "", "  in", "  aux " }),
    d(4, function(args) return sn(nil, { i(1, args[1]) }) end, { 3 }),
    t({ "", ";;" })
  }),
  s({
    trig = "comm",
    name = "comment",
    descr = "Comment (non-ODoc)."
  }, {
    t("(* "), i(0), t(" *)")
  }),
  s({
    trig = "if",
    name = "ifElse",
    descr = "if/else expression."
  }, {
    -- TODO: Reimplement as a choice node with an alternate multiline version.
    t("if "), i(1, "condition"), t(" then "), i(2), t(" else "), i(0)
  }),
  s({
    trig = "arr",
    name = "array",
    descr = "Array syntax."
  }, {
    t("[| "), i(1), t(" |]")
  }),
  s({
    trig = "qstr",
    name = "quotedString",
    descr = "Quoted string literal."
  }, {
    t("{|"), i(1), t("|}")
  }),
  s({
    trig = "oparam",
    name = "optParam",
    descr = "Optional parameter with default."
  }, {
    t("?("), i(1, "param"), t(" = "), i(2, "default"), t(")")
  }),
  s({
    trig = "tparam",
    name = "typedParam",
    descr = "Typed parameter with parenthesis."
  }, {
    t("("), i(1, "param"), t(" : "), i(2, "type"), t(")")
  }),
  s({
    trig = "cr",
    name = "charRange",
    descr = "Character range pattern."
  }, {
    t("'"), i(1, "a"), t("'..'"), i(0, "b"), t("'")
  }),
  s({
    trig = "printf",
    name = "printf",
    descr = "Snippet for (Printf.)printf."
  }, {
    c(1, {
      sn(nil, { t("printf \""), i(1), t("\\n\"") }),
      sn(nil, { t("Printf.printf \""), i(1), t("\\n\"") }),
    }),
    t(" "), i(0, "args")
  }),
  -- OOP Snippets (Rare use)
  s({
    trig = "class",
    name = "class",
    descr = "OOP Class definition."
  }, {
    t("class "), i(1, "name"), t({ " =", "  object" }),
    c(2, { t(" (self) "), t("") }), t({ "", "    " }), i(0),
    t({ "", "  end" })
  }),
  s({
    trig = "object",
    name = "object",
    descr = "Object block."
  }, {
    t("object"), c(1, { t(" (self) "), t("") }),
    t({ "", "  " }), i(0),
    t({ "", "end" })
  }),
  s({
    trig = "mutv",
    name = "valMutable",
    descr = "Mutable object property."
  }, {
    t("val mutable "), i(1, "identifier"), t(" = ")
  }),
  s({
    trig = "meth",
    name = "method",
    descr = "Object/Class public method."
  }, {
    t("method "), i(1, "name"), t(" = ")
  }),
  s({
    trig = "methp",
    name = "privateMethod",
    descr = "Object/Class private method."
  }, {
    t("method private"), i(1, "name"), t(" = ")
  }),
  s({
    regTrig = true,
    trig = "fancy(%d+)",
    name = "fancyComment",
    descr = "Fancy block comment of [n] width."
  }, {
    d(1, fancy_comment, {})
  }),
}
