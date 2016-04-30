# Simulação de fila M/M/1
lambda <- 20 #taxa de chegada
mu <- 50 #taxa de atendimento
tempo <- 1000 # tempo de simulação
t_0 <- 0 # instante inicial da simulação
fila <- 0 # fila inicialmente com tamanho zero
s <- 0 # soma acumulada para calcular o tamanho médio da fila

#Primeira chegada
t1 <- rexp(1, rate = lambda)
fila_atual <- 1
t_eventos <- t1
t_0 <- t1
n_eventos <- 1 #Número total de eventos ocorridos

while(t_0 < tempo){
  n_eventos <- n_eventos + 1
  if(fila_atual > 0){ # A fila está vazia?
    t1 <- rexp(1, rate = lambda + mu) # Tempo até o próximo evento
    #o evento é chegada ou partida?
    p <- runif(1)
    fila[n_eventos] <- fila_atual #quantos estavam na fila?
    fila_atual <- ifelse(p<lambda/(lambda + mu), 
                         fila_atual+1, # chegada
                         fila_atual-1) # partida
  }
  else{ # a fila esta vazia
    t1 <- rexp(1, rate = lambda)
    fila[n_eventos] <- fila_atual
    fila_atual <- 1
  }
  t_0 <- t_0 + t1
  t_eventos[n_eventos] <- t1
  s <- s+t1*fila[n_eventos]
}

plot(cumsum(t_eventos),fila,type="s", xlab="Time",ylab="Tamanho da fila",
     main=paste("Simulação de fila M/M/1\nTamanho Médio da Fila ",s/t_0))