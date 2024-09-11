## Numero de hubs por cidade
select * from exercicio04.hubs; #hub_city
select count(*) as quantidade, hub_city from exercicio04.hubs group by hub_city;

## Numero de orders por status
select * from exercicio04.orders LIMIT 100; #order_status
select count(*) as quantidade, order_status from exercicio04.orders group by order_status;

## Numero de lojas por cidade dos hubs
select * from exercicio04.stores;
select * from exercicio04.hubs;
select count(s.store_name) as qtd, hub_city from exercicio04.stores s 
inner join exercicio04.hubs h on s.hub_id = h.hub_id group by h.hub_city;

## Menor valor de pagamento registrado
select * from exercicio04.payments LIMIT 100;
select MIN(payment_amount) as minimo from exercicio04.payments;

## Qual o tipo de driver fez o maior numero de entregas
select * from exercicio04.drivers LIMIT 100; # driver_type
select COUNT(*) maior_qtd, driver_type from exercicio04.drivers group by driver_type order by maior_qtd desc LIMIT 1;

## Qual a distancia media das entregas por tipo de driver
select * from exercicio04.deliveries limit 100; #delivery_distance_meters, driver_id
select * from exercicio04.drivers limit 100;  #driver_id, driver_modal
select AVG(dl.delivery_distance_meters) as media, dr.driver_modal from exercicio04.deliveries dl inner join exercicio04.drivers dr on dr.driver_id = dl.driver_id
group by dr.driver_modal;

## Qual o valor médio de pedido por loja em ordem decrescente
select * from exercicio04.orders limit 10; # store_id, order_amount
select * from exercicio04.stores limit 10; # store_id
select AVG(o.order_amount) as media, s.store_name from exercicio04.orders o inner join exercicio04.stores s on s.store_id = o.store_id
group by store_name order by media desc;

## Existem pedidos que não são associados a lojas? se sim, quantos?
select * from exercicio04.orders limit 10;
select * from exercicio04.orders where store_id is null or store_id = '';
select * from exercicio04.stores limit 100;
select o.store_id, s.store_id from exercicio04.orders o left join exercicio04.stores s on o.store_id = s.store_id where s.store_id is null;
select o.store_id ,count(*), s.store_id from exercicio04.orders o left join exercicio04.stores s on o.store_id = s.store_id group by o.store_id having s.store_id is null;
select count(*) from exercicio04.orders o left join exercicio04.stores s on o.store_id = s.store_id where s.store_id is null; # 85.036 pedidos ligados a lojas inexistentes

## Qual o valor total de pedidos no canal 'FOOD PLACE'
select * from exercicio04.channels where channel_name = 'FOOD PLACE'; # 5
select SUM(order_amount) from exercicio04.orders o where o.channel_id = 5; 

## Quantos pagamentos foram cancelados(chargeback)
select * from exercicio04.payments limit 100;
select distinct payment_status from exercicio04.payments; # CHARGEBACK
select count(*) from exercicio04.payments where payment_status = 'CHARGEBACK';

## Qual foi o valor médio dos pagamentos cancelados
select * from exercicio04.payments limit 100; #payment_amount
select distinct payment_status from exercicio04.payments; # CHARGEBACK
select AVG(payment_amount) from exercicio04.payments where payment_status = 'CHARGEBACK';

## Qual a média de valor de pagamento por método de pagamento em ordem decrescente
select * from exercicio04.payments limit 100; #payment_method, payment_amount
select avg(payment_amount) as media, payment_method from exercicio04.payments group by payment_method order by media desc;

## Quais métodos tiveram valor médio superior a 100
select * from exercicio04.payments limit 100; #payment_method, payment_amount
select avg(payment_amount) as media, payment_method from exercicio04.payments group by payment_method having media > 100;

## Qual a media de valor de pedido por estado do hub, segmento da loja e tipo de canal
select * from exercicio04.orders limit 100; #payment_order_id, store_id, channel_id
select * from exercicio04.payments limit 100; #payment_amount
select * from exercicio04.stores limit 100; #store_segment, hub_id
select * from exercicio04.hubs limit 100; #hub_state

select avg(p.payment_amount) as media, h.hub_state, s.store_segment, c.channel_type from exercicio04.orders o
inner join exercicio04.payments p on p.payment_order_id = o.payment_order_id
inner join exercicio04.stores s on s.store_id = o.store_id
inner join exercicio04.hubs h on s.hub_id = h.hub_id
inner join exercicio04.channels c on c.channel_id = o.channel_id 
group by h.hub_state, s.store_segment, c.channel_type;
 