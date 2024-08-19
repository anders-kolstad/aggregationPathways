


library(DiagrammeR)


pathways <- grViz("digraph{

   graph [
            compound = true, 
            nodesep = .8, 
            ranksep = .8,
            color = crimson, 
            rankdir = LR
        ]

  
    node [
            fontname = Helvetica, 
            fontcolor = darkslategray,
            shape = rectangle, 
            fixedsize = true, 
            width = 1,
            color = darkslategray
        ]
        
        
    edge [
            color = black
        ]

   three[label='3) ', shape = plaintext]
   two  [label='2) ', shape = plaintext]
   one  [label='1) ', shape = plaintext]

subgraph cluster0_1 {
        label='Measurement scale';
        labeljust=l;
        peripheries=1;

   m3[label = 'measure']
   m2[label = 'measure']
   m1[label = 'measure']
   n1[label = 'normalise']
   scale

}

subgraph cluster0_2 {
        label='Larger scale';
        labeljust=l;
        peripheries=1;

   a1[label = 'aggregate']
   a2[label = 'aggregate']
   a3[label = 'aggregate']
   n2[label = 'normalise']
   truncate

}


one -> m3 [style = invis]
m3 ->a3 [minlen=2, weight=0]
a3 -> n2

two -> m2 [style = invis]
m2 -> n1 -> a2
   
three -> m1 [style = invis]
m1 -> scale -> a1 -> truncate

{rank=same; one; two; three;}


}")

pathways

#grViz_png <- function(x, filename = "graph.png") {
#  utils::capture.output({
#   rsvg::rsvg_png(svg = charToRaw(DiagrammeRsvg::export_svg(DiagrammeR::grViz(x))), file = filename)})
#  invisible()}
#grViz_png(pathways[[1]]$diagram, filename = "R/figures/pathways.png")
