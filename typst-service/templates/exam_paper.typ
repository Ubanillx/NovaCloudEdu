// 试卷排版模板
// 从 data.json 读取试卷数据并生成专业排版的试卷

#let data = json("data.json")

// ==================== 安全内容渲染 ====================
// Typst 数学模式中，多字母序列（如 mg）会被当作变量名导致编译失败
// 解决方案：拆分 $...$ 边界，文本直接输出，数学部分预处理多字母序列

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

// 修复数学表达式，使其兼容 Typst 数学模式
#let _fix-math(s) = {
  let r = s
  // 1. Fix LaTeX-style subscript/superscript braces: _{...} → _(...), ^{...} → ^(...)
  r = r.replace(regex("_\\{([^}]*)\\}"), m => "_(" + m.captures.at(0) + ")")
  r = r.replace(regex("\\^\\{([^}]*)\\}"), m => "^(" + m.captures.at(0) + ")")
  // 2. Fix fill-in-the-blank underscores (3+ consecutive) → quoted text
  r = r.replace(regex("_{3,}"), m => "\"" + m.text + "\"")
  // 3. Fix remaining double underscores
  r = r.replace("__", "\"__\"")
  // 4. Remove stray LaTeX backslashes (e.g. \frac → frac, \cdot → cdot)
  r = r.replace("\\", "")
  // 5. Fix multi-char variable names: "mg" → "m g", keep known names like "frac"
  r = r.replace(regex("[a-zA-Z]{2,}"), m => {
    if m.text in _math-names { m.text }
    else { m.text.clusters().join(" ") }
  })
  // 6. Trim leading/trailing underscores that would cause "unexpected underscore"
  r = r.trim("_")
  r
}

// 安全渲染：拆分文本/公式，分别处理
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
          // Still risky after fix, fall back to plain text
          [#("$" + p + "$")]
        } else {
          eval("$" + fixed + "$", mode: "markup")
        }
      }
    }
  }
}

// 纸张和排版设置
#let paper-size = if "paper_size" in data { data.paper_size } else { "a4" }
#let col-count = if "columns" in data { data.columns } else { 1 }
#let font-size = if "font_size" in data { eval(data.font_size) } else { 10.5pt }

#set page(
  paper: paper-size,
  margin: (top: 2.5cm, bottom: 2cm, left: 2cm, right: 2cm),
  header: align(center, text(size: 9pt, fill: rgb("#999999"))[
    #if "title" in data { data.title }
  ]),
  footer: context align(center, text(size: 9pt)[
    第 #counter(page).display() 页 共 #counter(page).final().first() 页
  ]),
)

#set text(
  font: ("Noto Serif CJK SC", "Noto Sans CJK SC"),
  size: font-size,
  lang: "zh",
)

#set par(leading: 0.8em, justify: true)

// ==================== 试卷标题区域 ====================

#align(center)[
  #text(size: 22pt, weight: "bold")[
    #if "title" in data { data.title }
  ]

  #v(0.3cm)

  #if "subtitle" in data and data.subtitle != none {
    text(size: 12pt)[#data.subtitle]
    v(0.2cm)
  }
]

// 考生信息栏
#v(0.3cm)
#line(length: 100%, stroke: 0.5pt)
#v(0.2cm)
#grid(
  columns: (1fr, 1fr, 1fr),
  align: left,
  text[姓名：#h(3cm)],
  text[班级：#h(3cm)],
  text[学号：#h(3cm)],
)
#v(0.2cm)
#line(length: 100%, stroke: 0.5pt)
#v(0.5cm)

// ==================== 试卷内容 ====================

#if col-count > 1 {
  columns(col-count, gutter: 1cm)[
    #for section in data.sections {
      [
        == #section.title
        #if "description" in section and section.description != none {
          text(size: 9.5pt, style: "italic")[#section.description]
        }
        #v(0.3cm)

        #for q in section.questions {
          [
            *#q.number.* #safe-eval(q.content)
          ]

          // 选择题选项
          if "options" in q and q.options != none and q.options.len() > 0 {
            v(0.15cm)
            let labels = ("A", "B", "C", "D", "E", "F")
            let opt-count = q.options.len()
            if opt-count <= 4 {
              grid(
                columns: (1fr,) * calc.min(opt-count, 4),
                row-gutter: 0.3em,
                ..q.options.enumerate().map(((i, opt)) => {
                  [#labels.at(i). #safe-eval(opt)]
                })
              )
            } else {
              for (i, opt) in q.options.enumerate() {
                [#labels.at(i). #safe-eval(opt) #h(1em)]
              }
            }
          }

          // 填空题/简答题留白
          if "type" in q {
            if q.type == "FILL_BLANK" {
              v(0.3cm)
            } else if q.type == "SHORT_ANSWER" or q.type == "CALCULATION" or q.type == "ESSAY" {
              v(2cm)
            }
          }

          v(0.4cm)
        }
      ]
    }
  ]
} else {
  for section in data.sections {
    [
      == #section.title
      #if "description" in section and section.description != none {
        text(size: 9.5pt, style: "italic")[#section.description]
      }
      #v(0.3cm)

      #for q in section.questions {
        [
          *#q.number.* #safe-eval(q.content)
        ]

        // 选择题选项
        if "options" in q and q.options != none and q.options.len() > 0 {
          v(0.15cm)
          let labels = ("A", "B", "C", "D", "E", "F")
          let opt-count = q.options.len()
          if opt-count <= 4 {
            grid(
              columns: (1fr,) * calc.min(opt-count, 4),
              row-gutter: 0.3em,
              ..q.options.enumerate().map(((i, opt)) => {
                [#labels.at(i). #safe-eval(opt)]
              })
            )
          } else {
            for (i, opt) in q.options.enumerate() {
              [#labels.at(i). #safe-eval(opt) #h(1em)]
            }
          }
        }

        // 填空题/简答题留白
        if "type" in q {
          if q.type == "FILL_BLANK" {
            v(0.3cm)
          } else if q.type == "SHORT_ANSWER" or q.type == "CALCULATION" or q.type == "ESSAY" {
            v(2cm)
          }
        }

        v(0.4cm)
      }
    ]
  }
}
