


library(DiagrammeR)

# Example with two indicator and two EAs
# where we scale variables at the EA level
# and calculate an index at the EA level
# and then aggregate the indeces for the EAA level
# Version b. Adding area weighting

example3b <- grViz("digraph{
  
   
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
        
# Orange part --------------------------

   subgraph clusterTop {
      graph[color = orange]
      
    subgraph cluster0 {
      graph[color = green]
      peripheries=0;
       
       subgraph cluster0_1 {
        label='EA-1, 1 hectare';
        labeljust=l;
        peripheries=1;
        V2_EA1[label = 'Value = 5\nRef. = 25', color = orange, style = filled, fontcolor = white]
        V1_EA1[label = 'Value = 5\nRef. = 10', color = blue, style = filled, fontcolor = white]
        I1_EA1[label = ' .5', color = blue, style = filled, fontcolor = white]
        I2_EA1[label = ' .2', color = orange, style = filled, fontcolor = white]
        X_EA1[label = ' .35', color = grey, style = filled]
        V1_EA1 -> I1_EA1 -> X_EA1
        V2_EA1 -> I2_EA1 -> X_EA1
        
       }
       
       subgraph cluster0_2 {
        label='EA-2, 2 hectare';
        labeljust=l;
        peripheries=1;
        V2_EA2[label = 'Value = 1\nRef. = 10', color = orange, style = filled, fontcolor = white]
        V1_EA2[label = 'Value = 1\nRef. = 4', color = blue, style = filled, fontcolor = white]
        I1_EA2[label = ' .25', color = blue, style = filled, fontcolor = white]
        I2_EA2[label = ' .1', color = orange, style = filled, fontcolor = white]
        X_EA2[label = ' .175', color = grey, style = filled]
        V1_EA2 -> I1_EA2 -> X_EA2
        V2_EA2 -> I2_EA2 -> X_EA2
       }
    }
X[label = '.233', color = grey, style = filled]
X_EA1 -> X
X_EA2 -> X

}


   
   

}")




example3b
