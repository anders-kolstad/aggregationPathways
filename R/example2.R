


library(DiagrammeR)
#library(DiagrammeRsvg)
#library(magrittr)
#library(rsvg)

example2 <- 
  grViz("digraph{
  
   
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
            fixedsize = false, 
            width = 1.5,
            heigth=3,
            color = darkslategray
        ]
        
        
    edge [
            color = black
        ]
        
        
   subgraph clusterAll1 {
      graph[color = black]
      peripheries=0;
      
    subgraph cluster0 {
      peripheries=0;
       
       subgraph clusterSubReg1 {
        peripheries=1;
        label='EA-1';
        labeljust=l;
        Area1A[label = 'Indicator = A\nValue = 5\nRef. = 10', color=blue]
        Area1B[label = 'Indicator = B\nValue = 5\nRef. = 25']
        Area1_2A[label = 'Indicator A = .5',  style=filled, color=grey90]
        Area1_2B[label = 'Indicator B = .2', style=filled, color=grey90]
        Area1A -> Area1_2A
        Area1B -> Area1_2B
        
        SR1[label='EA-1 = 0.35', style=filled, color=grey90]
        Area1_2A -> SR1
        Area1_2B -> SR1

       }
       
       subgraph clusterSubReg2 {
       peripheries=1;
        label='EA-2';
        labeljust=l;
        Area2A[label = 'Indicator= A\nValue = 1\nRef. = 4', color=blue]
        Area2B[label = 'Indicator= B\nValue = 1\nRef. = 10']
        Area2_2A[label = 'Indicator A = .25', style=filled, color=grey90]
        Area2_2B[label = 'Indicator B = .1', style=filled, color=grey90]
        Area2A -> Area2_2A
        Area2B -> Area2_2B
        
        SR2[label='EA-2 = 0.18', style=filled, color=grey90]
        Area2_2A -> SR2
        Area2_2B -> SR2
    
       }
    }
    
   
 
      Norge[label = 'EAA\n = .27',style=filled, color=grey90]
    
   
    SR1 -> Norge
    SR2 -> Norge
 
     
      subgraph clusterWholeRegion {
      label = 'EAA';
      peripheries=1;
      
      IAraw[label='Indicator A\nValue = 6\nRef. = 14', color=blue]
      IBraw[label='Indicator B\nValue = 6\nRef. = 35']
       
      Area1A -> IAraw
      Area2A -> IAraw
      Area1B -> IBraw
      Area2B -> IBraw
      
      IAraw -> IAs
      IBraw -> IBs
      
      IAs[label='Indicator A = .43', style=filled, color=grey90]
      IBs[label='Indicator B = .17', style=filled, color=grey90]
      
      Norge2[label = '.22',style=filled, color=grey90]

      IAs -> Norge2
      IBs -> Norge2
      }
       
   }
   
  }")

example2