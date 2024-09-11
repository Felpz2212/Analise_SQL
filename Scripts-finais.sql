# Duração total do aluguel das bikes em horas
select SUM(duracao_segundos/60/60) from cap06.tb_bikes;

# Duração total do aluguel das bikes em horas ao longo do tempo
select duracao_segundos ,sum(duracao_segundos/60/60) over (order by data_inicio) as duracao_total_horas
from cap06.tb_bikes;

# Duracao total do aluguel das bikes em horas ao longo do tempo por estação de inicio quando a dara de inicio for inferior a '2021-01-08'
select duracao_segundos, estacao_inicio, data_inicio, 
sum(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as duracao_total_horas
from cap06.tb_bikes where data_inicio < cast('2012-01-08' as date);

# Qual a media de tempo em horas de aluguel de bike da estacao de inicio 31017?
select estacao_inicio, avg(duracao_segundos/60/60) as media_horas
from cap06.tb_bikes where numero_estacao_inicio = 31017 group by estacao_inicio;

#Qual a media de tempo em horas de aluguel da estação 31017, ao longo do tempo? (media movel)
select estacao_inicio, avg(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as media_horas 
from cap06.tb_bikes where numero_estacao_inicio = 31017;

# Retornar:
# Estacao_inicio, data_inicio e duracao de cada aluguel de bike em segundos
# Duracao total de aluguel das bikes ao longo do tempo por estação de inicio
# Duracao media do aluguel de bikes ao longo do tempo por estação de inicio
# Numero de alugueis de bikes por estação ao longo do tempo
# Somente os registros quando a data de inicio for inferior a '2012-01-08'
select estacao_inicio, data_inicio, duracao_segundos, 
sum(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as soma_tempo,
avg(duracao_segundos/60/60) over (partition by estacao_inicio order by data_inicio) as media_tempo,
count(*) over (partition by estacao_inicio order by data_inicio) as quantidade_alugueis
from cap06.tb_bikes where data_inicio < '2012-01-08';

# Retornar
# Estação de inicio, data de inicio de cada aluguel de bike e duracao de cada aluguel em segundos
# Numero de alugueis de bikes (independente da estação) ao longo do tempo
# Somente os registros quando a data de inicio for inferior a '2012-01-08'
select estacao_inicio, data_inicio, duracao_segundos, count(*) over(order by data_inicio) as qtd_alugueis
from cap06.tb_bikes where data_inicio < '2012-01-08';

## Solução 2
select estacao_inicio, data_inicio, duracao_segundos, row_number() over(order by data_inicio) as qtd_alugueis
from cap06.tb_bikes where data_inicio < '2012-01-08';

# E se quisermos o mesmo resultado anterior, mas a contagem por estação?
select estacao_inicio, data_inicio, duracao_segundos, row_number() over(partition by estacao_inicio order by data_inicio) as qtd_alugueis
from cap06.tb_bikes where data_inicio < '2012-01-08';

#Diferença de tempo entre o aluguel com o aluguel anterior Lag=anterior LEAD=Proximo
select estacao_inicio, 
cast(data_inicio as date), 
duracao_segundos - lag(duracao_segundos, 1) over(partition by estacao_inicio order by cast(data_inicio as date)) as qtd_alugueis
from cap06.tb_bikes where data_inicio < '2012-01-08' and numero_estacao_inicio = 31000;


# Manipulação de datas


