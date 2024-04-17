


library(DiagrammeR)

# Example with two indicator and two EAs
# where we scale variables at the EAA level
# and then aggregate the index also at the EAA level
# giving UNequal weight to EAs
# Does it ever make sense to get area weighted means
# for variables across EAs?
# Obviously not for count variables.

example7 <-  grViz("digraph{
  
   
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
        #I1_EA1[label = ' .5', color = blue, style = filled, fontcolor = white]
        #I2_EA1[label = ' .2', color = orange, style = filled, fontcolor = white]
        #V1_EA1 -> I1_EA1
        #V2_EA1 -> I2_EA1
        
       }
       
       subgraph cluster0_2 {
        label='EA-2';
        labeljust=l;
        peripheries=1;
        V1_EA2[label = 'Value = 1\nRef. = 4', color = blue, style = filled, fontcolor = white]
        V2_EA2[label = 'Value = 1\nRef. = 10', color = orange, style = filled, fontcolor = white]
        #I1_EA2[label = ' .25', color = blue, style = filled, fontcolor = white]
        #I2_EA2[label = ' .1', color = orange, style = filled, fontcolor = white]
        #V1_EA2 -> I1_EA2
        #V2_EA2 -> I2_EA2
       }
    }

V1_EAA[label = 'Value (sum) = 6\nRef.(sum) = 14', color = blue, style = filled, fontcolor = white, width = 2]
V2_EAA[label = 'Value (sum) =  6\nRef.(sum) = 35', color = orange, style = filled, fontcolor = white, width = 2]
I1_EAA[label = '.43', color = blue, style = filled, fontcolor = white]
I2_EAA[label = '.17', color = orange, style = filled, fontcolor = white]
X[label = '.3', color = grey, style = filled]

V1_EA1 -> V1_EAA -> I1_EAA -> X
V1_EA2 -> V1_EAA
V2_EA1 -> V2_EAA -> I2_EAA -> X
V2_EA2 -> V2_EAA
}

}")




example7
