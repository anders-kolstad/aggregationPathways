


library(DiagrammeR)

# Example with two indicator and two EAs
# where we scale variables at the EA level
# and calculate an index at the EA level
# and then aggregate the indeces for the EAA level
# giving equal weight to EAs

example4 <-  grViz("digraph{
  
   
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
        label='EA-1';
        labeljust=l;
        peripheries=1;
        V1_EA1[label = 'Value = 5\nRef. = 10', color = blue, style = filled, fontcolor = white]
        V2_EA1[label = 'Value = 5\nRef. = 25', color = orange, style = filled, fontcolor = white]
        I1_EA1[label = ' .5', color = blue, style = filled, fontcolor = white]
        I2_EA1[label = ' .2', color = orange, style = filled, fontcolor = white]
        V1_EA1 -> I1_EA1
        V2_EA1 -> I2_EA1
        
       }
       
       subgraph cluster0_2 {
        label='EA-2';
        labeljust=l;
        peripheries=1;
        V1_EA2[label = 'Value = 1\nRef. = 4', color = blue, style = filled, fontcolor = white]
        V2_EA2[label = 'Value = 1\nRef. = 10', color = orange, style = filled, fontcolor = white]
        I1_EA2[label = ' .25', color = blue, style = filled, fontcolor = white]
        I2_EA2[label = ' .1', color = orange, style = filled, fontcolor = white]
        V1_EA2 -> I1_EA2
        V2_EA2 -> I2_EA2
       }
    }

I1_EAA[label = ' .375', color = blue, style = filled, fontcolor = white]
I2_EAA[label = ' .15', color = orange, style = filled, fontcolor = white]
X[label = '.2625', color = grey, style = filled]


I1_EA2 -> I1_EAA
I1_EA1 -> I1_EAA -> X

I2_EA2 -> I2_EAA
I2_EA1 -> I2_EAA -> X

}

}")




example4
