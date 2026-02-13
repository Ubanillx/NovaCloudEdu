// 几何图形渲染模板
// 从 data.json 读取 code 字段，使用 cetz 绘制几何图形

#import "@preview/cetz:0.3.4"

#let data = json("data.json")

#set page(
  width: auto,
  height: auto,
  margin: 0.5cm,
)

#set text(
  font: ("Noto Serif CJK SC", "Noto Sans CJK SC"),
  size: 10pt,
  lang: "zh",
)

// 执行传入的 cetz 绘图代码
#eval(data.code, mode: "markup", scope: (cetz: cetz))
