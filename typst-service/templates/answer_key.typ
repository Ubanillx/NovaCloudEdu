// 参考答案模板
// 从 data.json 读取试卷数据并生成参考答案

#let data = json("data.json")

// 已知 Typst 数学函数/符号（不拆分）
#let _math-names = (
  "frac", "sqrt", "root", "sum", "prod", "integral", "lim",
  "sin", "cos", "tan", "cot", "sec", "csc", "arcsin", "arccos", "arctan",
  "log", "ln", "exp", "max", "min", "inf", "sup",
  "det", "gcd", "lcm", "mod", "dim", "ker", "deg", "sgn", "dif",
  "alpha", "beta", "gamma", "delta", "epsilon", "zeta", "eta", "theta",
  "iota", "kappa", "lambda", "mu", "nu", "xi", "pi", "rho",
  "sigma", "tau", "upsilon", "phi", "chi", "psi", "omega",
  "Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta",
  "Iota", "Kappa", "Lambda", "Mu", "Nu", "Xi", "Pi", "Rho",
  "Sigma", "Tau", "Upsilon", "Phi", "Chi", "Psi", "Omega",
  "bold", "italic", "upright", "arrow", "tilde", "hat", "bar", "dot", "ddot",
  "vec", "mat", "cases", "binom", "abs", "norm", "floor", "ceil", "round",
  "overline", "underline", "underbrace", "overbrace", "cancel",
  "dots", "infinity", "space", "quad", "limits", "scripts",
  "display", "inline", "text", "not", "and", "or",
  "plus", "minus", "times", "div", "equiv", "approx", "sim", "cong",
  "prop", "perp", "angle", "therefore", "because", "forall", "exists",
  "subset", "supset", "cup", "cap", "empty", "partial", "nabla",
  "lt", "gt", "le", "ge", "ne", "eq", "in", "sect", "union",
  "content", "hbar", "ell", "aleph",
)

#let _fix-math(s) = {
  let r = s
  r = r.replace(regex("_\\{([^}]*)\\}"), m => "_(" + m.captures.at(0) + ")")
  r = r.replace(regex("\\^\\{([^}]*)\\}"), m => "^(" + m.captures.at(0) + ")")
  r = r.replace(regex("_{3,}"), m => "\"" + m.text + "\"")
  r = r.replace("__", "\"__\"")
  r = r.replace("\\", "")
  r = r.replace(regex("[a-zA-Z]{2,}"), m => {
    if m.text in _math-names { m.text }
    else { m.text.clusters().join(" ") }
  })
  r = r.trim("_")
  r
}

#let safe-eval(s) = {
  if s == none { [] }
  else if type(s) != str { [#s] }
  else if s.len() == 0 { [] }
  else if not s.contains("$") { s }
  else {
    let parts = s.split("$")
    for (i, p) in parts.enumerate() {
      if calc.rem(i, 2) == 0 {
        if p.len() > 0 { [#p] }
      } else if p.len() > 0 {
        let fixed = _fix-math(p)
        if fixed.trim().len() == 0 { [] }
        else if fixed.contains("__") or fixed.trim().starts-with("_") or fixed.trim().ends-with("_") {
          [#("$" + p + "$")]
        } else {
          eval("$" + fixed + "$", mode: "markup")
        }
      }
    }
  }
}

#let paper-size = if "paper_size" in data { data.paper_size } else { "a4" }
#let is-landscape = paper-size == "a3"

#set page(
  paper: paper-size,
  flipped: is-landscape,
  margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
)

#set text(
  font: ("Noto Serif CJK SC", "Noto Sans CJK SC"),
  size: 10.5pt,
  lang: "zh",
)

#set par(leading: 0.8em)

#align(center)[
  #text(size: 18pt, weight: "bold")[
    #if "title" in data { data.title } — 参考答案
  ]
]

#v(0.5cm)

#for section in data.sections {
  [
    == #section.title
    #v(0.2cm)

    #for q in section.questions {
      [
        *#q.number.* 
        #if "answer" in q { 
          text(fill: rgb("#0066cc"))[#safe-eval(q.answer)]
        }
      ]

      if "explanation" in q and q.explanation != none {
        text(size: 9pt, fill: rgb("#666666"))[
          【解析】#safe-eval(q.explanation)
        ]
      }

      v(0.3cm)
    }
  ]
}
