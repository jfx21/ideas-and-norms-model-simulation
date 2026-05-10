extensions [ nw ]

turtles-own [
  opinion       
  threshold     
  adopted?      
  new-opinion   
  new-adopted?  
]

to setup
  clear-all
  
  ;; 1. Tworzenie sieci Small-World (Watts-Strogatz)
  ;; 100 agentów, każdy połączony z 4 sąsiadami, 0.1 szansy na losowe połączenie
  nw:generate-watts-strogatz turtles links 100 4 0.1
  
  ask turtles [
    set shape "person"
    set size 1.5
    set opinion random-float 1.0
    set adopted? false
    set new-adopted? false ;; inicjalizacja zmiennej pomocniczej
    
    ;; Rozmieszczenie na okręgu, żeby było widać sieć
    setxy (15 * cos (who * 3.6)) (15 * sin (who * 3.6))
    
    ;; Przypisanie progów (Rogers)
    let r random-float 100
    if r < 2.5 [ set threshold 0.05 ]   
    if r >= 2.5 and r < 16 [ set threshold 0.15 ] 
    if r >= 16 [ set threshold 0.5 ]    
  ]
  
  ;; 2. Inicjalizacja innowatorów
  ask n-of 3 turtles [
    set adopted? true
    set new-adopted? true
    set color red
  ]
  
  reset-ticks
end

to go
  ;; 1. Faza obliczeń
  ask turtles [
    let moje-polaczenia link-neighbors 
    
    ;; Filtrowanie wg epsilon (Hegselmann-Krause)
    let valid-neighbors moje-polaczenia with [abs (opinion - [opinion] of myself) <= epsilon]
    
    ;; AKTUALIZACJA OPINII - używamy ifelse zamiast if/else
    ifelse any? valid-neighbors [
      set new-opinion mean [opinion] of (turtle-set self valid-neighbors)
    ] 
    [
      set new-opinion opinion
    ]
    
    ;; DECYZJA O ADOPCJI (Granovetter)
    let total-neighbors count moje-polaczenia
    ifelse total-neighbors > 0 [
      let adopted-count count moje-polaczenia with [adopted?]
      ;; Jeśli frakcja adoptujących sąsiadów > próg, ustaw nową adopcję na true
      ifelse (adopted-count / total-neighbors) > threshold [
        set new-adopted? true
      ]
      [
        ;; Jeśli już adoptował, niech zostanie true (proces nieodwracalny)
        ;; Jeśli nie, zostaje false
        set new-adopted? adopted? 
      ]
    ]
    [
      set new-adopted? adopted?
    ]
  ]
  
  ;; 2. Faza aktualizacji (synchronizacja stanów)
  ask turtles [
    set opinion new-opinion
    set adopted? new-adopted?
    
    ;; Wizualizacja
    ifelse adopted? [ 
      set color red 
    ] 
    [ 
      set color scale-color gray opinion 0 1 
    ]
  ]
  
  tick
  if ticks >= 500 [ stop ]
end