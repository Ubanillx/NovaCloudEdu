// 高考数学试卷模板
// A3 纸张 · 密封线侧栏 · 双栏排版 · 考生信息填写区
// 兼容系统 data.json 数据格式

#let data = json("data.json")

// ==================== 安全内容渲染 ====================
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

// ==================== 数据读取 ====================
#let paper-title = if "title" in data { data.title } else { "数学试卷" }
#let paper-subtitle = if "subtitle" in data { data.subtitle } else { none }
#let duration-min = if "duration_min" in data { data.duration_min } else { 120 }
#let total-score = if "total_score" in data { data.total_score } else { 150 }
#let font-size = if "font_size" in data { eval(data.font_size) } else { 10.5pt }

// ==================== 密封线侧栏宽度 ====================
#let seal-width = 3.2cm

// ==================== 页面设置：A3 横向 ====================
#set page(
  paper: "a3",
  flipped: true,
  margin: (
    top: 2.2cm,
    bottom: 2cm,
    left: seal-width + 2cm,
    right: 2cm,
  ),
  background: {
    // ── 密封线侧栏（绘制在左侧留白区域内） ──
    place(left + top, dx: 0pt, dy: 0pt,
      box(width: seal-width, height: 100%,
        // 外框虚线
        stroke: none,
        {
          // 竖向虚线（密封线本体）
          place(right + top, dx: -0.3cm, dy: 1.5cm,
            line(
              start: (0pt, 0pt),
              end: (0pt, 100% - 3cm),
              stroke: (paint: rgb("#999999"), thickness: 0.8pt, dash: "dashed"),
            )
          )

          // 「密封线」三字（竖排，居中放置）
          place(right + top, dx: -0.65cm, dy: 45%,
            rotate(-90deg,
              text(size: 11pt, tracking: 0.8em, fill: rgb("#999999"), weight: "bold")[密 封 线]
            )
          )

          // 「密封线内不得答题」提示
          place(right + top, dx: -1.1cm, dy: 35%,
            rotate(-90deg,
              text(size: 7.5pt, fill: rgb("#bbbbbb"))[← 密封线内不得答题 →]
            )
          )

          // ── 考生信息填写区（竖排，纵向居中均匀分布） ──
          // A3 纸高 420mm，4 个字段居中分布，起始 ~25%，间距 ~15%
          // 姓名
          place(left + top, dx: 0.6cm, dy: 25%,
            rotate(-90deg,
              text(size: 10.5pt)[
                姓#h(0.5em)名：#box(width: 3.5cm, stroke: (bottom: 0.5pt + black))[]
              ]
            )
          )

          // 准考证号
          place(left + top, dx: 0.6cm, dy: 40%,
            rotate(-90deg,
              text(size: 10.5pt)[
                准考证号：#box(width: 3.5cm, stroke: (bottom: 0.5pt + black))[]
              ]
            )
          )

          // 考场号
          place(left + top, dx: 0.6cm, dy: 55%,
            rotate(-90deg,
              text(size: 10.5pt)[
                考场号：#box(width: 3cm, stroke: (bottom: 0.5pt + black))[]
              ]
            )
          )

          // 座位号
          place(left + top, dx: 0.6cm, dy: 70%,
            rotate(-90deg,
              text(size: 10.5pt)[
                座位号：#box(width: 3cm, stroke: (bottom: 0.5pt + black))[]
              ]
            )
          )
        }
      )
    )
  },
  // 页脚：页码
  footer: context align(center, text(size: 9pt, fill: rgb("#666666"))[
    第 #counter(page).display() 页 #h(0.5em) 共 #counter(page).final().first() 页
  ]),
)

#set text(
  font: ("Noto Serif CJK SC", "Noto Sans CJK SC"),
  size: font-size,
  lang: "zh",
)

#set par(leading: 0.85em, justify: true)
#set heading(numbering: none)

// ==================== 试卷内容（双栏排版，标题在第一栏） ====================
#columns(2, gutter: 1.2cm)[
  // ── 标题区域（仅第一栏） ──
  #align(center)[
    #text(size: 10pt, weight: "bold", fill: rgb("#cc0000"))[绝密 ★ 启用前]
    #v(0.3cm)

    #text(size: 22pt, weight: "bold", tracking: 0.1em)[
      #paper-title
    ]
    #v(0.1cm)

    #if paper-subtitle != none {
      text(size: 12pt)[#paper-subtitle]
      v(0.1cm)
    }

    #text(size: 10.5pt, fill: rgb("#333333"))[
      数学 #h(1.5em) 考试时间：#str(duration-min) 分钟 #h(1.5em) 满分：#str(total-score) 分
    ]
  ]

  #v(0.3cm)

  // ── 注意事项 ──
  #block(width: 100%, inset: (x: 0.5cm, y: 0.4cm), radius: 0pt,
    stroke: (top: 1.5pt + black, bottom: 0.5pt + rgb("#cccccc")),
  )[
    #text(weight: "bold", size: 10.5pt)[注意事项：]
    #v(0.1cm)
    #set text(size: 9pt, fill: rgb("#333333"))
    #set par(leading: 0.65em)

    1. 答卷前，考生务必将自己的姓名、准考证号填写在密封线内指定位置。

    2. 回答选择题时，选出每小题答案后，用铅笔把答题卡上对应题目的答案标号涂黑。如需改动，用橡皮擦干净后，再选涂其他答案标号。

    3. 回答非选择题时，将答案写在答题卡上。写在本试卷上无效。

    4. 考试结束后，将本试卷和答题卡一并交回。
  ]

  #v(0.4cm)

  // ── 题目内容 ──
  #for section in data.sections {
    // ── 大题标题 ──
    [
      #v(0.2cm)
      #block(width: 100%)[
        #text(weight: "bold", size: 12pt)[#section.title]
        #if "description" in section and section.description != none {
          text(size: 9.5pt, style: "italic", fill: rgb("#555555"))[ #section.description]
        }
      ]
      #v(0.25cm)
    ]

    // ── 题目 ──
    for q in section.questions {
      // 题号 + 内容
      [
        *#q.number.* #h(0.3em) #safe-eval(q.content)
      ]

      // 选择题选项（2×2 网格或 4 列）
      if "options" in q and q.options != none and q.options.len() > 0 {
        v(0.15cm)
        let labels = ("A", "B", "C", "D", "E", "F")
        let opt-count = q.options.len()
        if opt-count <= 4 {
          // 长选项：2 列 × 2 行；短选项：4 列 × 1 行
          let max-len = q.options.fold(0, (acc, opt) => calc.max(acc, opt.len()))
          let cols = if max-len > 15 { 2 } else { calc.min(opt-count, 4) }
          grid(
            columns: (1fr,) * cols,
            row-gutter: 0.4em,
            column-gutter: 0.5em,
            ..q.options.enumerate().map(((i, opt)) => {
              [#labels.at(i).  #safe-eval(opt)]
            })
          )
        } else {
          for (i, opt) in q.options.enumerate() {
            [#labels.at(i). #safe-eval(opt) #h(1em)]
          }
        }
      }

      // 不同题型的作答空间
      if "type" in q {
        if q.type == "SINGLE_CHOICE" or q.type == "MULTIPLE_CHOICE" {
          v(0.3cm)
        } else if q.type == "FILL_BLANK" {
          v(0.5cm)
        } else if q.type == "SHORT_ANSWER" {
          v(3cm)
        } else if q.type == "CALCULATION" {
          v(4.5cm)
        } else if q.type == "ESSAY" {
          v(4cm)
        } else {
          v(1cm)
        }
      } else {
        v(0.5cm)
      }

      v(0.25cm)
    }
  }
]
