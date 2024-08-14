// ==> structure
// title in Typst
#let title(args) = {
  v(20pt)
  align(center)[
    #set text(
      size: 25pt, 
      weight: "bold", 
      fill: gradient.linear(red, blue, angle:0deg)
    )
    #box[#upper(args)]
  ]
}
// section
#let section(args) = {
  v(10pt)
  text(size: 15pt, weight: "bold")[#args]
  v(-12pt)
  line(length: 100%, stroke: .5pt) 
}
#let subsection(args) = {
  v(6pt)
  text(size: 12pt, weight: "bold")[#args]
}


// ==> some defined useful commands
// 1. introduce
#let note(text, prefix:"Note") = {
  rect(fill: luma(240), stroke: (left: 0.25em), width: 100%)[
    *#prefix:* #text
  ]
}
// 2. cmd
// 3. code example block
#let code(type: "typst", source) = {
  set raw(block: true, lang: type)
  grid(
    columns: (60%, 35%),
    column-gutter: 5%,
    // align: (left, right),
    block(
      width: 100%,
      raw(source)
    ),
    block(
      width: 100%,
      fill: luma(230),
      inset: 4pt,
      radius: 2pt,
      // source
      eval(source, mode: "markup")
    )
  )
}


// ==> load Settings for the document
#let conf(doc) = {
  // ==> code style
  show raw:set text(font: ("Consolas", "STXihei"))
  import "@preview/codly:1.0.0": *
  show: codly-init.with()
  codly(
    zebra-fill: none,
    stroke: .5pt+black,
    radius: 2pt,
    languages: (
      typst: ( name: "Typst", icon: "\u{f0b1b}" )
    )
  )
  // `` style in typst
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // ==> font and layout
  set par(
    justify: true, 
    leading: 1.5em,
    first-line-indent: 2em
  )
  // english, chinese, emoji fonts setup 
  set text(
    font: ("Times New Roman", "SimSun", "Segoe UI Emoji"),
  )

  // ==> itemize indent 
  show list: it => pad(left: 1.5em, {
    set list(marker: style(styles => place(dx: -measure([•], styles).width, [•])))
    it
  })
  show enum: it => pad(left: 1.5em, {
    set enum(numbering: n => style(styles => {
      let num = numbering("1.", n)
      place(dx: -measure(num, styles).width, num)
    }))
    it
  })

  // main matter
  doc
}