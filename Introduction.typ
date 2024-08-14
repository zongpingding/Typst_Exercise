#import "package/base.typ": *
#show: doc => conf(doc)



= Typst
== Basic
=== Environment Setup
Preview just use the Plugin "Tinymist Typst", then use: "Ctrl+k v" to preview the content.

=== Basic Syntax
How to comment in Typst? Use `//` or use `/* */` to comment a block. There is also a useful MarkUp operation: \`\`. Besides the character *escape* is `\`.

=== Item List
+ Test 1
+ Test 2

- test 3
- test 4

=== Formula
Inline Formula: $alpha+beta=gamma$. Display Style and Complex Formula, Test my word $ sum_(i=1)^(n) i^2 = (n(n+1)(2n+1))/6 $


/ Additional: like `{}` makes a group in LaTeX, `()` makes a group in Typst, use multiple `()` to make a nested group, like `((()))`.

=== Code Block
Use code in Typst just like the syntax in MarkDown:
```python
def quick_sort():
    pass
```

=== emoji
🌴🐢🐐🍄⚽

#note[但是目前的Emoji无法在成成的PDF 中显示为彩色，可以参见:https://github.com/typst/typst/issues/144]

=== basic graph
A Rectangle and Circle as follows:
// #Center[
//   circle
// ]

#align(center)[#circle(radius: 25pt)]


== Advanced
=== Font 
The font set are supported in Typst, like:
```typst
#set text(
  font: ("Times New Roman", "SimSun", "Segoe UI Emoji"),
)
```

#note("These fonts are used by Typst from left to right.")

Typst embedded some font, like `New Computer Modern`. You can use command:
```shell
typst fonts
```
to see the font list that Typst found on you computer.

Which set both the english font and the chinese font. If no font set for chinese, then you can't select the chinese font in the PDF.

=== CJK Support
Ref: https://github.com/typst/typst/issues/794。下面这个就是具体的设置效果:

#align(center)[中文支持, 繁体字, 日本語, 한국어]

#note(prefix: "Bug")[Typst 目前无法处理中文加粗]

=== define function
The basic syntax is:
```typst
#let <function>(args1, args2:defalut) = { 
  <content>
  args1 ...
  [#args2] ...
}
```
an example:
#let cmd(args, color: blue) = { text(color, [#args]) }

```typst
// "[]" is optional, [#args] <=> args
#let cmd(args, color: blue) = { text(color, #args) }
```

Then you can use the function like:

#cmd()[defalut color:blue] ---
#cmd(color:red)[red color]


#(calc.pow(2, 62))\
9223372036854775807


=== Counter
在 typst 中也可以使用计数器，如下所示:

// #codly(offset: 5)
```typst
// 更新计数器
#counter(page).update(1)
// 增加计数器，把元素序号转为 `x.x` 的格式
#let counter_chapter = counter("chapter")
```

=== code print
两种方法设置代码块，但是均需要设置对应的字体:
```typst
#show raw:set text(font: ("Consolas", "STXihei"))
```

第一种方法:
```typst
#show raw:set block(
  fill: luma(230),
  inset: 10pt,
  radius: 2pt,
  width: 100%
)
#show raw.where(block: true): code => {
  show raw.line: line => {
    text(fill: gray)[#line.number]
    h(1em)
    line.body
  }
  code
}
```

第二种就是使用额外的包:
```typst
#import "@preview/codly:1.0.0": *
#show: codly-init.with()
#codly(
  zebra-fill: none,
  stroke: .5pt+black,
  radius: 2pt,
  languages: (
    typst: ( name: "Typst", icon: "\u{f0b1b}" )
  )
)
```

== Write a Template in Typst
Typst provide function `#include`, and `#import` to arrange the files:
- `#include`: is used to include the file and excute the content in the file.
- `#import`: is used to import the file and make the content in the file into module, which can be used later.v

