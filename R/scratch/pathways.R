


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

subgraph clusterEAA {
      graph[colour = black]
      label='EAA scale';   
   
subgraph clusterRegion {
      graph[style=dashed]
      label='Regional scale';

   
subgraph clusterPlot {
      graph[style=dashed]
      style=filled; 
      color=lightblue;
      label='Measurement scale';

  Variable[label='Original\nvariable']
  Variable2[label='Original\nvariable']
  Scale2[label='Scale']
  
  
}

subgraph clusterHEA {
      graph[style=dashed]
      style=filled; 
      color=grey90;
      label='HEA';

  Scale[label='Scale']

} # end HEA scale
} # end regional scale

  Agg[label='Aggregate']
  Agg2[label='Aggregate']

} # end EAA scale
  
  Variable -> Scale -> Agg
  Variable2 -> Scale2 -> Agg2
{rank=same; Agg; Agg2;}


}")

pathways

